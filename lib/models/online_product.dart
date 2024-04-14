import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:kopdar_app/constants.dart';

List<OnlineProduct> parseProduct(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<OnlineProduct>((json) => OnlineProduct.fromJson(json)).toList();
}
Future<List<OnlineProduct>> fetchOnlineProducts() async {
  final response = await http.get(Uri.parse('http://$endpointUrl/product/all-with-images-color-rating'));
  return compute(parseProduct, response.body);
}

Future<OnlineProduct> fetchOnlineProduct(int id) async {
  print('call now http://$endpointUrl/product/id/$id');
  final response = await http.get(Uri.parse('http://$endpointUrl/product/id/$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed load Online Product by ID @ $id');
  } else {
    return OnlineProduct.fromJson(json.decode(response.body) as Map<String, dynamic>);
  }
}

class OnlineProduct {
  final int id;
  final String title, description;
  final List<String> images;
  final List<String> colors;
  final double price;
  Rating? rating;

  OnlineProduct({
    required this.id,
    required this.images,
    required this.colors,
    required this.title,
    required this.price,
    required this.description,
    required this.rating
  });

  factory OnlineProduct.fromJson(Map<String, dynamic> json) {
    return OnlineProduct(
        id: json['tbid'] as int,
        images: List<String>.from(json['images']),
        colors: List<String>.from(json['colors']),
        title: json['nama'] as String,
        price: json['hjua'] as double,
        description: json['dsc1'] as String,
        rating: json['rating'] != null ? Rating.fromJson(json['rating']) : Rating(tbid: 0, prdktbid: 0, isFavorite: false, isPopular: false, ratg: 0)
    );
  }
}

class Rating {
  final int tbid, prdktbid;
  final bool isFavorite, isPopular;
  final double ratg;

  Rating({
    required this.tbid,
    required this.prdktbid,
    required this.isFavorite,
    required this.isPopular,
    required this.ratg,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      tbid: json['tbid'] as int,
      prdktbid: json['prdktbid'] as int,
      isFavorite: json['fav'] as bool,
      isPopular: json['popu'] as bool,
      ratg: json['ratg'] as double,
    );
  }
}

// data dummy for testing purposes
/*List<OnlineProduct> demoProducts = [
  OnlineProduct(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      "0xFFF6625E",
      "0xFF836DB8",
      "0xFFDECB9C",
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: Rating(isPopular: true, isFavorite: true, ratg: 4.8, tbid: 1, prdktbid: 1),

  ),
  OnlineProduct(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      "0xFFF6625E",
      "0xFF836DB8",
      "0xFFDECB9C",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: Rating(isPopular: true, isFavorite: true, ratg: 5.0, tbid: 1, prdktbid: 1),
  ),
  OnlineProduct(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: Rating(isPopular: true, isFavorite: true, ratg: 3.0, tbid: 1, prdktbid: 1),
  ),
  OnlineProduct(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [],
    title: "Logitech Head",
    price: 20.20,
    description: description,
      rating: Rating(isPopular: false, isFavorite: false, ratg: 2.0, tbid: 1, prdktbid: 1),
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
*/