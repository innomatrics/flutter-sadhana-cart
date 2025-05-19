import 'package:flutter/material.dart';

class ViewApplication extends StatelessWidget {
  final Map<String, dynamic> sellerData;
  const ViewApplication({
    super.key,
    required this.sellerData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Seller Application',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shop Name: ${sellerData['shopName']}'),
            Text('Name: ${sellerData['name']}'),
            Text('Email: ${sellerData['email']}'),
            Text('Phone: ${sellerData['phone']}'),
            Text('Address: ${sellerData['address']}'),
            Text('GST Number: ${sellerData['gstNumber']}'),
            Text('PAN Number: ${sellerData['panNumber']}'),
            Text('Bank Account: ${sellerData['bankAccount']}'),
            Text('Business Type: ${sellerData['businessType']}'),
            const SizedBox(height: 20),
            _buildImageSection(
                context, 'Bank Proof', sellerData['bankProofUrl']),
            _buildImageSection(
                context, 'GST Certificate', sellerData['gstCertificateUrl']),
            _buildImageSection(context, 'PAN Card', sellerData['panCardUrl']),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(
      BuildContext context, String title, String? imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        imageUrl != null && imageUrl.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImageView(imageUrl: imageUrl, title: title),
                    ),
                  );
                },
                child: Image.network(imageUrl,
                    height: 150, width: double.infinity, fit: BoxFit.cover),
              )
            : Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported,
                    size: 50, color: Colors.grey),
              ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FullScreenImageView(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
