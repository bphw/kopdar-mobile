import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:kopdar_app/constants.dart';

class OnlineProduct {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  const OnlineProduct({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  factory OnlineProduct.fromJson(Map<String, dynamic> json) {
    List<Color> parsedColors = <Color>[];

    json['colors'] != null ?
    json['colors'].forEach((colorString) {
      Color c = Color(int.parse(colorString));
      parsedColors.add(c);
    })
    :
    [];

    return OnlineProduct(
      id: json['tbid'] as int,
      images: json['images'] as List<String>,
      // colors: json['colors'] as List<Color>,
      colors: parsedColors,
      title: json['nama'] as String,
      price: json['hjua'] as double,
      description: json['dsc1'] as String,
      rating: json['detail']['ratg'] as double,
      isFavourite: json['detail']['fav'] as bool,
      isPopular: json['detail']['popu'] as bool,
    );
  }
}


// Online products
Future<List<OnlineProduct>> fetchOnlineProducts() async {
  print('call now http://$endpointUrl/product/all');
  final response = await http.get(Uri.parse('http://$endpointUrl/product/all'));
  return compute(parseProduct, response.body);
}
List<OnlineProduct> parseProduct(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
  return parsed.map<OnlineProduct>((json) => OnlineProduct.fromJson(json)).toList();
}

Future<OnlineProduct> fetchOnlineProduct(int id) async {
  print('call now http://$endpointUrl/product/id/$id');
  final response = await http.get(Uri.parse('http://$endpointUrl/product/id/$id'));
  if (response.statusCode != 200) {
    throw Exception('Failed load Online Product by ID');
  }
  return OnlineProduct.fromJson(json.decode(response.body) as Map<String, dynamic>);
}

