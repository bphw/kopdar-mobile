import 'package:flutter/material.dart';
import 'package:kopdar_app/models/OnlineProduct.dart';

class Cart {
  final OnlineProduct product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: const OnlineProduct(id: 1,
    images:[],
    colors:[Colors.blue,Colors.red],
    title: 'Contoh Produk',
    rating: 5.0,
    price: 10000,
    isFavourite: true,
    isPopular: true, description: 'Masuk keranjang'
  ), numOfItem: 2),
  Cart(product: const OnlineProduct(id: 2,
      images:[],
      colors:[Colors.black,Colors.red],
      title: 'Contoh Produk kedua',
      rating: 4.0,
      price: 20000,
      isFavourite: true,
      isPopular: true, description: 'Masuk keranjang #2'
  ), numOfItem: 1),
  Cart(product: const OnlineProduct(id: 3,
      images:[],
      colors:[Colors.blue,Colors.red],
      title: 'Contoh Produk ketiga',
      rating: 1.0,
      price: 5000,
      isFavourite: true,
      isPopular: true, description: 'Masuk keranjang #3'
  ), numOfItem: 1),
];
