import 'package:flutter/material.dart';
import 'package:kopdar_app/components/product_card.dart';
import 'package:kopdar_app/models/online_product.dart';
import 'package:kopdar_app/screens/details/details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static String routeName = "/products";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}
class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<OnlineProduct>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchOnlineProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<OnlineProduct>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) => ProductCard(
                          product: snapshot.data![index],
                          onPress: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(product: snapshot.data![index]),
                          ),
                        ),
                      )
                    ]
                );
              } else if(snapshot.hasError) {
                return Text('$snapshot.error');
              } else {
                return const CircularProgressIndicator();
              }
            }
          )
        )
      ),
    );
  }
}
