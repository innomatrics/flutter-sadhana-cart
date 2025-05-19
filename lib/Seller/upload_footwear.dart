import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadMobileScreen extends StatefulWidget {
  const UploadMobileScreen({super.key});

  @override
  _UploadMobileScreenState createState() => _UploadMobileScreenState();
}

class _UploadMobileScreenState extends State<UploadMobileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  List<File> images = [];

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child('items/images/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> uploadProduct() async {
    String? sellerId = FirebaseAuth.instance.currentUser?.uid;

    if (nameController.text.isEmpty ||
        brandController.text.isEmpty ||
        categoryController.text.isEmpty ||
        priceController.text.isEmpty ||
        offerPriceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required")));
      return;
    }

    List<String> uploadedImageUrls = [];
    for (File image in images) {
      String imageUrl = await uploadImage(image);
      uploadedImageUrls.add(imageUrl);
    }

    await FirebaseFirestore.instance.collection('items').add({
      'name': nameController.text,
      'brand': brandController.text,
      'category': categoryController.text,
      'description': descriptionController.text,
      'price': int.parse(priceController.text),
      'offerPrice': int.parse(offerPriceController.text),
      'quantity': int.parse(quantityController.text),
      'colors': selectedColors,
      'sizes': selectedSizes,
      'images': uploadedImageUrls,
      'sellerId': sellerId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Mobile Phone")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Mobile Name")),
            TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: "Brand Name")),
            TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category")),
            TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description")),
            TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number),
            TextField(
                controller: offerPriceController,
                decoration: const InputDecoration(labelText: "Offer Price"),
                keyboardType: TextInputType.number),
            TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number),

            // Image Picker
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Images"),
            ),
            Wrap(
              children: images
                  .map((image) => Image.file(image,
                      width: 80, height: 80, fit: BoxFit.cover))
                  .toList(),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: uploadProduct,
              child: const Text("Upload Mobile"),
            ),
          ],
        ),
      ),
    );
  }
}
