import 'package:flutter/material.dart';

class SelectedSizes extends StatefulWidget {

  @override
  _SelectedSizesState createState() => _SelectedSizesState();
}

class _SelectedSizesState extends State<SelectedSizes> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 60,
      width: double.infinity,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueAccent,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: 5),
              child: Center(
                child: Text(
                  "S",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueAccent,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 5),
            child: Center(
              child: Text(
                "M",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueAccent,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 5),
            child: Center(
              child: Text(
                "L",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueAccent,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 5),
            child: Center(
              child: Text(
                "XL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
