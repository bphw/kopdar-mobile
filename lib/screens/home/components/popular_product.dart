import 'package:flutter/material.dart';
import 'package:kopdar_app/components/product_card.dart';
import 'package:kopdar_app/models/online_product.dart';
import 'package:kopdar_app/screens/details/details_screen.dart';
import 'package:kopdar_app/screens/products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  late Future<List<OnlineProduct>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchOnlineProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Produk Populer",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
          FutureBuilder<List<OnlineProduct>>(
              future: futureProducts,
              builder: (context, snapshot) {
            if(snapshot.hasData) {

              return Row(
                children: [
                  ...List.generate(
                    snapshot.data!.length, (index) {

                      if (snapshot.data![index].rating != null) {
                        if (snapshot.data![index].rating!.isPopular) {
                          print(snapshot.data![index].id);
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ProductCard(
                              product: snapshot.data![index],
                              onPress: () =>
                                  Navigator.pushNamed(
                                    context,
                                    DetailsScreen.routeName,
                                    arguments: ProductDetailsArguments(
                                        product: snapshot.data![index]
                                    ),
                                  ),
                            ),
                          );
                        }
                      }
                      return const SizedBox.shrink(); // here by default width and height is 0
                  },// index
                ),
                  const SizedBox(width: 20),
                ],
              );
            } // shapshot.hasData
            else if(snapshot.hasError) {
              return Text('${snapshot.error}');}
            else {
              return const CircularProgressIndicator();}

          })

        )
      ]
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});
  final List<OnlineProduct> products;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...List.generate(
      products.length, (index) {
        if (products[index].rating!.isPopular) {
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ProductCard(
              product: products[index],
              onPress: () =>
                  Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(
                        product: products[index]),
                  ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    ),
    const SizedBox(width: 20),
    ]
    );
  }
}
