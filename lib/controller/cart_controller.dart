import 'package:get/get.dart';
import 'package:kopdar_app/models/cart.dart';

class CartController extends GetxController {
  var qty = 0.obs;
  incQty() => qty++;
  decQty() => qty--;
  reset() => qty = 0.obs;

  var product = 0.obs;
  selectedProduct(int id) => product = id.obs;

  List<Cart> myCart = <Cart>[].obs;
  addCart(Cart item) => myCart.add(item);
  removeCart(Cart item) => myCart.remove(item);
}