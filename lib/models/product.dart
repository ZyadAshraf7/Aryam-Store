import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  String imagePath;
  int price;
  double rate;

  Product({
    this.id,
    this.title,
    this.description,
    this.imagePath,
    this.price,
    this.rate,
  });
}
