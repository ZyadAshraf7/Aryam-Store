import 'package:flutter/material.dart';

List items = [
  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.only(right: 20),
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.redAccent.withOpacity(0.5),
      borderRadius: BorderRadius.circular(5),
    ),
    child:
    Center(child: Text("Men", style: TextStyle(color: Colors.white))),
  ),
  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.blueAccent.withOpacity(0.5),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
        child: Text(
          "Women",
          style: TextStyle(color: Colors.white),
        )),
  ),
  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: 50,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.5),
      borderRadius: BorderRadius.circular(5),
    ),
    child:
    Center(child: Text("Kids", style: TextStyle(color: Colors.white))),
  ),
];