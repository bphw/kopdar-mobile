import 'package:get/get.dart';
import 'package:kopdar_app/models/cart.dart';

class CartController extends GetxController {
  List<Cart> myCart = <Cart>[].obs;

  addCart(Cart item) => myCart.add(item);
  removeCart(Cart item) => myCart.remove(item);
}