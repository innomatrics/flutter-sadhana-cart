import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/products/show_specific_seller_product.dart';
import 'package:sadhana_cart/admin/provider/product_provider.dart';

class ListOfProducts extends StatefulWidget {
  const ListOfProducts({super.key});

  @override
  State<ListOfProducts> createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<ListOfProducts> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getAllSellerProducts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Products by Sellers",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          final products = value.allProducts;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 600),
                          child: ShowSpecificSellerProduct(
                            sellerId: products[index]['sellerId'],
                            sellerName: products[index]['name'],
                          ))),
                  title: Text(products[index]['name']),
                );
              });
        },
      ),
    );
  }
}
