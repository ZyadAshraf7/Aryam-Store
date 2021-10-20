import 'package:flutter/material.dart';

class AllProductDesign extends StatelessWidget {

  final String title, imagePath;
  final int price;
  final VoidCallback function;

  AllProductDesign({this.title, this.imagePath, this.price, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 260,
            height: 260,
            child: InkWell(
              onTap: function,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "\$$price",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}