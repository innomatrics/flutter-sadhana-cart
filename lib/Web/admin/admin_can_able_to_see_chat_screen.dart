import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminCanAbleToSeeChatScreen extends StatefulWidget {
  const AdminCanAbleToSeeChatScreen({super.key});

  @override
  _AdminCanAbleToSeeChatScreenState createState() => _AdminCanAbleToSeeChatScreenState();
}

class _AdminCanAbleToSeeChatScreenState extends State<AdminCanAbleToSeeChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('customers').snapshots(),
        builder: (context, customersSnapshot) {
          if (!customersSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final customers = customersSnapshot.data!.docs;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              final customerId = customer.id;
              final customerData = customer.data() as Map<String, dynamic>;
              final customerName = customerData['name'] ?? 'No Name';
              final customerEmail = customerData['email'] ?? 'No Email';

              return StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('customers')
                    .doc(customerId)
                    .collection('chat')
                    .orderBy('timestamp', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, chatSnapshot) {
                  if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                    // Skip customers with no messages
                    return const SizedBox.shrink();
                  }

                  final latestMessage = chatSnapshot.data!.docs.first;
                  final messageText = latestMessage['message'] ?? '';
                  final isCustomer = latestMessage['isCustomer'] ?? false;
                  final timestamp = latestMessage['timestamp'] as Timestamp?;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      onTap: () {
                        // Navigate to individual chat screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerChatDetailScreen(
                              customerId: customerId,
                              customerName: customerName,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          customerName[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(customerName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messageText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (timestamp != null)
                            Text(
                              _formatTimestamp(timestamp),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class CustomerChatDetailScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  const CustomerChatDetailScreen({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  _CustomerChatDetailScreenState createState() =>
      _CustomerChatDetailScreenState();
}

class _CustomerChatDetailScreenState extends State<CustomerChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('customers')
                  .doc(widget.customerId)
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
        .doc(widget.customerId)
        .collection('chat')
        .add({
      'message': _messageController.text,
      'isCustomer': false, // false because seller is sending
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