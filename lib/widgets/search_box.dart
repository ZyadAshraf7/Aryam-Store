import 'package:bolt_ecommerce/constants.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [kDefaultShadow],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          labelText: "Search Your Product",
          prefixIcon: Icon(Icons.search),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      )
    );
  }
}
