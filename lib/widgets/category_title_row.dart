import 'package:flutter/material.dart';

class CategoryTitleRow extends StatelessWidget {
  CategoryTitleRow({this.pressed, this.title});
  final VoidCallback pressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 24),
        ),
        TextButton(onPressed: pressed, child: Text("See all"))
      ],
    );
  }

}
