import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_cart/admin/products/admin_view_seller_products.dart';
import 'package:sadhana_cart/admin/provider/product_provider.dart';

class ShowSpecificSellerProduct extends StatefulWidget {
  final String sellerId;
  final String sellerName;
  const ShowSpecificSellerProduct(
      {super.key, required this.sellerId, required this.sellerName});

  @override
  State<ShowSpecificSellerProduct> createState() =>
      _ShowSpecificSellerProductState();
}

class _ShowSpecificSellerProductState extends State<ShowSpecificSellerProduct> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSellerProducts();
  }

  Future<void> _fetchSellerProducts() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductsBySeller(context: context, sellerId: widget.sellerId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Show Specific Seller Product',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          final products = value.productBySeller;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: size.height * 0.30,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 600),
                        child: AdminViewSellerProducts(
                          sellerProducts: products[index],
                        ))),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.001),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (product['images'] != null)
                          Container(
                            height: size.height * 0.22,
                            width: size.width * 1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      product['images'][0]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          product['name'] ?? 'No Name',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
