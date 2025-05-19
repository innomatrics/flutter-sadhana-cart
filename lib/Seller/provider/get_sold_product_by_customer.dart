import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSoldProductByCustomer extends ChangeNotifier {
  List<Map<String, dynamic>> _allSoldProductByCustomer = [];
  List<Map<String, dynamic>> get allSoldProductByCustomer =>
      _allSoldProductByCustomer;
  List<Map<String, dynamic>> _filteredSoldProductByCustomer = [];

  List<Map<String, dynamic>> get filteredSoldProductByCustomer =>
      _filteredSoldProductByCustomer;

  Future<List<Map<String, dynamic>>> fetchSoldProductsByCustomer({
    required BuildContext context,
  }) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection('customers').get();

        List<Map<String, dynamic>> fetchedOrders = [];

        for (final orderCollection in querySnapshot.docs) {
          final orderRef = orderCollection.reference.collection('orders');
          final orderSnapShot = await orderRef
              .where("productSellerId", isEqualTo: user.uid)
              .get();

          fetchedOrders.addAll(orderSnapShot.docs.map((doc) => doc.data()));
        }

        _allSoldProductByCustomer = fetchedOrders;
        _filteredSoldProductByCustomer = List.from(fetchedOrders);
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return _allSoldProductByCustomer;
  }

  Future<bool> deleteSellerProductById(
      {required String productId, required BuildContext context}) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final ref = await FirebaseFirestore.instance
            .collection('seller')
            .doc(currentUser.uid)
            .get();
        final List<String> subcategories = [
          'Electronics',
          'Clothing',
          'Footwear',
          'Accessories',
          'Home Appliances',
          'Books',
          'Others',
        ];
        for (final subcategory in subcategories) {
          await ref.reference.collection(subcategory).doc(productId).delete();
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product deleted successfully')));
        }
        return true;
      }
      return false;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return false;
  }

  Future<bool> updateSellerProduct(
      {required BuildContext context, required String productId}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final List<String> subCollections = [
        'Electronics',
        'Clothing',
        'Footwear',
        'Accessories',
        'Home Appliances',
        'Books',
        'Others',
      ];
      final Map<String, dynamic> newData = {};
      for (final subcategory in subCollections) {
        final CollectionReference collectionReference = FirebaseFirestore
            .instance
            .collection('seller')
            .doc(userId)
            .collection(subcategory);
        final DocumentSnapshot documentSnapshot =
            await collectionReference.doc(productId).get();
        if (documentSnapshot.exists) {
          newData.addAll(documentSnapshot.data() as Map<String, dynamic>);
          await collectionReference.doc(productId).update(newData);
          return true;
        }
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return false;
  }

  Future<bool> uploadSellerImages({
    required BuildContext context,
    required File image,
  }) async {
    try {
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final currentUser = firebaseAuth.currentUser!.uid;

      //  Upload image to Firebase Storage
      final ref = firebaseStorage
          .ref()
          .child('sellers_documents')
          .child(currentUser)
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      final uploadTask = await ref.putFile(image);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      //  Save the image URL to Firestore
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('seller');

      await collectionReference.doc(currentUser).set({
        'sellerImages': FieldValue.arrayUnion([imageUrl])
      }, SetOptions(merge: true));

      // Save to SharedPreferences
      final pref = await SharedPreferences.getInstance();
      final sellerImages = pref.getStringList('sellerImages') ?? [];
      sellerImages.add(imageUrl);
      await pref.setStringList('sellerImages', sellerImages);

      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Upload failed")));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return false;
  }

  Future<File> pickerImagesFromGallery({required BuildContext context}) async {
    File image = File('');
    try {
      final pickerFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickerFile != null) {
        image = File(pickerFile.path);
      }
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    return image;
  }
}
