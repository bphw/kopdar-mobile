import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopdar_app/controller/cart_controller.dart';
import 'components/cart_card.dart';
import 'components/check_out_cart.dart';
import 'package:get/get.dart';

// class CartScreen extends StatefulWidget {
//   static String routeName = "/cart";
//
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {

    final CartController c = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Keranjang",
              style: TextStyle(color: Colors.black),
            ),
            Obx(() => Text(
              "${c.myCart.length} item",
              style: Theme.of(context).textTheme.bodySmall,
            )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: c.myCart.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(c.myCart[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // setState(() {
                //   demoCarts.removeAt(index);
                // });
                () => c.removeCart(c.myCart[index]);
                Get.snackbar(
                  'Keranjang',
                  '${c.myCart[index].product.title} Berhasil dihapus',
                );
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: c.myCart[index]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}
