import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final String title, imagePath;
  final int price;
  final VoidCallback function;

  ProductCardWidget({this.title, this.imagePath, this.price, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10, bottom: 8),
            width: 150,
            height: 240,
            child: InkWell(
              onTap: function,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: title,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/placeholder-image.png'),
                    image: NetworkImage(
                      imagePath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "\$$price",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
