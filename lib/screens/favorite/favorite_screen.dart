import 'package:flutter/material.dart';
import 'package:kopdar_app/components/product_card.dart';
// import 'package:kopdar_app/models/Product.dart';
import 'package:kopdar_app/models/OnlineProduct.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<OnlineProduct>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchOnlineProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            "Favorites",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder<List<OnlineProduct>>(
                  future: futureProducts,
                  builder: (context, snapshot) =>
                    snapshot.hasError ? Text('$snapshot.error') :
                      snapshot.hasData ?
                        GridView.builder(
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
                              arguments:
                              ProductDetailsArguments(product: snapshot.data![index]),
                            ),
                          ),
                        )
                      : Text('snapshot has no data')
              ),
            ),
          )
        ],
      ),
    );
  }
}
