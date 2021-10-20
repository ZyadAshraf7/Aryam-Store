import 'package:bolt_ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {


  List _allItems = [];

  Future<void> getAllItem() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("allProducts");
    var responseBody = await userRef.get();
    responseBody.docs.forEach((element) {
      allItems.add(element.data());
    });
  }

  List<Product> get allItems {
    return [..._allItems];
  }

  Future loadAllProducts() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("Apz03kiIGBNQzOMHlePM")
        .collection("allProducts")
        .get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
      if(_allItems.length<snapshot.docs.length)
        _allItems.add(Product(
          id: data['id'],
          title: data['title'],
          price: data['price'],
          imagePath: data['imagePath'],
          description: data['description'],
          rate: data['rate'],
        ));
    }
    print("All products fetched");
  }


  ///////////////////////////////////////////////////////

  Product findProductById(String id) {
    return _featuredProducts.firstWhere((prod) => prod.id == id, orElse: () {
      return _bestSellProducts.firstWhere((prod) => prod.id == id,orElse: (){
        return _allItems.firstWhere((prod) => prod.id == id,orElse: (){
          return _trendProducts.firstWhere((prod) => prod.id==id);
        });
      });
    });
  }

  List<Product> _featuredProducts = [];

  List<Product> get featuredProducts {
    return [..._featuredProducts];
  }

  Future loadFeatureProducts() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("Apz03kiIGBNQzOMHlePM")
        .collection("featuredProducts")
        .get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
    if(_featuredProducts.length<snapshot.docs.length)
      _featuredProducts.add(Product(
        id: data['id'],
        title: data['title'],
        price: data['price'],
        imagePath: data['imagePath'],
        description: data['description'],
        rate: data['rate'],
      ));
    }
  }

  List<Product> _bestSellProducts = [];

  List<Product> get bestSellProducts {
    return [..._bestSellProducts];
  }

  Future loadBestSellProducts() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("Apz03kiIGBNQzOMHlePM")
        .collection("bestSellProducts")
        .get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
    if(_bestSellProducts.length<snapshot.docs.length)
      _bestSellProducts.add(Product(
        id: data['id'],
        title: data['title'],
        price: data['price'],
        imagePath: data['imagePath'],
        description: data['description'],
        rate: data['rate'],
      ));
    }
  }


  List<Product> _trendProducts = [];

  List<Product> get trendProducts {
    return [..._trendProducts];
  }

  Future loadTrendProducts() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("products")
        .doc("Apz03kiIGBNQzOMHlePM")
        .collection("trendProducts")
        .get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
      if(_trendProducts.length<snapshot.docs.length)
        _trendProducts.add(Product(
          id: data['id'],
          title: data['title'],
          price: data['price'],
          imagePath: data['imagePath'],
          description: data['description'],
          rate: data['rate'],
        ));
    }
  }

}
