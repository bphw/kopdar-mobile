import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopdar_app/controller/cart_controller.dart';
import 'package:kopdar_app/components/rounded_icon_btn.dart';
import 'package:kopdar_app/constants.dart';
import 'package:kopdar_app/models/online_product.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final OnlineProduct product;

  @override
  Widget build(BuildContext context) {
    final CartController c = Get.put(CartController());
    // Now this is fixed and only for demo
    int selectedColor = 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GetX<CartController>(builder: (_) => Text('Jumlah item: ${c.qty}')),
          ...List.generate(
            product.colors.length,
            (index) => ColorDot(
              color: Color(int.parse(product.colors[index])),
              isSelected: index == selectedColor,
            ),
          ),
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              if(c.qty > 0) {
                c.decQty();
              }
            },
          ),
          const SizedBox(width: 20),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              c.incQty();
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
