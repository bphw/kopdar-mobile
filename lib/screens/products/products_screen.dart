import 'package:flutter/material.dart';
import 'package:kopdar_app/components/product_card.dart';
// import 'package:kopdar_app/models/Product.dart';
import 'package:kopdar_app/models/OnlineProduct.dart';

import '../details/details_screen.dart';

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
              List<Widget> children;
              if(snapshot.hasData) {
                children = <Widget>[GridView.builder(
                  itemCount: snapshot.data?.length,
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
                      arguments:
                      ProductDetailsArguments(product: snapshot.data![index]),
                    ),
                  ),
                )];
              } else if(snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              }  else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          )
        ),
      ),
    );
  }
}
