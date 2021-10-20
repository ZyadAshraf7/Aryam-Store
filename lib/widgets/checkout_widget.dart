import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutCartProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double _shippingFees=10.0;
    final cart = Provider.of<Cart>(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal",style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
              ),),
              Text("\$${cart.totalAmountCartProducts}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping",style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey
              ),),
              Text("\$$_shippingFees",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 20),
          Divider(thickness: 2,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",style: TextStyle(
                  fontSize: 24
              ),),
              Text("\$${cart.totalAmountCartProducts + _shippingFees}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}