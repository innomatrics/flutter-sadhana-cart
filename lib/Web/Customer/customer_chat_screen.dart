import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebChatScreen extends StatefulWidget {
  const WebChatScreen({super.key});

  @override
  _WebChatScreenState createState() => _WebChatScreenState();
}

class _WebChatScreenState extends State<WebChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _customerId;

  @override
  void initState() {
    super.initState();
    _customerId = _auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Support'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('customers')
                  .doc(_customerId)
                  .collection('chat')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final message = doc['message'] as String;
                    final isCustomer = doc['isCustomer'] as bool;

                    return Align(
                      alignment: isCustomer
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isCustomer
                              ? Colors.blue[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(message),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    await _firestore
        .collection('customers')
        .doc(_customerId)
        .collection('chat')
        .add({
      'message': _messageController.text,
      'isCustomer': true,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}


//


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class WebChatScreen extends StatefulWidget {
//   const WebChatScreen({super.key});
//
//   @override
//   State<WebChatScreen> createState() => _WebChatScreenState();
// }
//
// class _WebChatScreenState extends State<WebChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ScrollController _scrollController = ScrollController();
//   late String _customerId;
//   bool _isComposing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _customerId = _auth.currentUser!.uid;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToBottom();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width > 800;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Support'),
//         backgroundColor: Colors.deepOrange,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.deepOrange,
//                 Colors.amber,
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.deepOrange.withOpacity(0.05),
//               Colors.amber.withOpacity(0.02),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('customers')
//                     .doc(_customerId)
//                     .collection('chat')
//                     .orderBy('timestamp', descending: false)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
//                       ),
//                     );
//                   }
//
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     _scrollToBottom();
//                   });
//
//                   return ListView.builder(
//                     controller: _scrollController,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: isDesktop ? 100 : 16,
//                       vertical: 16,
//                     ),
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       final doc = snapshot.data!.docs[index];
//                       final message = doc['message'] as String;
//                       final isCustomer = doc['isCustomer'] as bool;
//                       final timestamp = doc['timestamp'] as Timestamp?;
//
//                       return AnimatedSize(
//                         duration: const Duration(milliseconds: 200),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4.0),
//                           child: Row(
//                             mainAxisAlignment: isCustomer
//                                 ? MainAxisAlignment.end
//                                 : MainAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   constraints: BoxConstraints(
//                                     maxWidth: isDesktop ? 600 : 280,
//                                   ),
//                                   padding: const EdgeInsets.all(12.0),
//                                   decoration: BoxDecoration(
//                                     color: isCustomer
//                                         ? Colors.deepOrange
//                                         : Colors.grey[200],
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(12),
//                                       topRight: const Radius.circular(12),
//                                       bottomLeft: Radius.circular(
//                                           isCustomer ? 12 : 0),
//                                       bottomRight: Radius.circular(
//                                           isCustomer ? 0 : 12),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.1),
//                                         blurRadius: 4,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: isCustomer
//                                         ? CrossAxisAlignment.end
//                                         : CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         message,
//                                         style: TextStyle(
//                                           color: isCustomer
//                                               ? Colors.white
//                                               : Colors.black87,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       if (timestamp != null)
//                                         Padding(
//                                           padding: const EdgeInsets.only(top: 4),
//                                           child: Text(
//                                             _formatTimestamp(timestamp),
//                                             style: TextStyle(
//                                               color: isCustomer
//                                                   ? Colors.white70
//                                                   : Colors.grey[600],
//                                               fontSize: 10,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             _buildMessageInput(isDesktop),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput(bool isDesktop) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: isDesktop ? 100 : 16,
//         vertical: 8,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 8,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: TextField(
//                   controller: _messageController,
//                   decoration: const InputDecoration(
//                     hintText: 'Type your message...',
//                     border: InputBorder.none,
//                   ),
//                   maxLines: null,
//                   onChanged: (text) {
//                     setState(() {
//                       _isComposing = text.trim().isNotEmpty;
//                     });
//                   },
//                   onSubmitted: (_) => _sendMessage(),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: _isComposing
//                   ? const LinearGradient(
//                 colors: [Colors.deepOrange, Colors.amber],
//               )
//                   : null,
//               color: _isComposing ? null : Colors.grey[300],
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.send,
//                 color: _isComposing ? Colors.white : Colors.grey[600],
//               ),
//               onPressed: _isComposing ? _sendMessage : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;
//
//     setState(() {
//       _isComposing = false;
//     });
//
//     await _firestore
//         .collection('customers')
//         .doc(_customerId)
//         .collection('chat')
//         .add({
//       'message': _messageController.text,
//       'isCustomer': true,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//     _scrollToBottom();
//   }
//
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
//
//   String _formatTimestamp(Timestamp timestamp) {
//     final dateTime = timestamp.toDate();
//     return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }