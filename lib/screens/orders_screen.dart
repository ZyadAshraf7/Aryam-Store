import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/widgets/order_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      body: orderData.orders.isEmpty
          ? IfOrderIsEmpty()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) {
                return OrderCardItem(
                  orderData.orders[i],
                );
              }),
    );
  }
}
class IfOrderIsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded,size: 50,color: Colors.pinkAccent,),
          SizedBox(height: 20),
          Text(
            "No orders yet",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Hurry and make your first order",
            style: TextStyle(fontSize: 18,),
          ),
        ],
      ),
    );
  }
}