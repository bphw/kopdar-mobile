import 'package:flutter/material.dart';
import '../../../components/product_card.dart';
import '../../../models/OnlineProduct.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
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
          child: FutureBuilder<List<OnlineProduct>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Row(
                    children: [
                      ...List.generate(
                        snapshot.data!.length,
                        (index) =>
                          snapshot.data![index].isPopular ?
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ProductCard(
                                product: snapshot.data![index],
                                onPress: () => Navigator.pushNamed(
                                  context,
                                  DetailsScreen.routeName,
                                  arguments: ProductDetailsArguments(
                                      product: snapshot.data![index]
                                  ),
                                ),
                              ),
                            )
                          :
                          const SizedBox.shrink()
                      )
                    ]
                );
              } else if (snapshot.hasError) {
                return Row(
                  children: [
                    Text('${snapshot.error}'),
                  ],
                );
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          )
        )
      ],
    );
  }
}
