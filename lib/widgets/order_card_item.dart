import 'package:bolt_ecommerce/constants.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCardItem extends StatelessWidget {
  final OrderItem order;

  OrderCardItem(this.order);

  @override
  Widget build(BuildContext context) {
    var _shippingFees = 10;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [kDefaultShadow],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      width: 350,
      height: 210,
      child: ListView(
        children: [
          ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        order.address,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            "Ordered in : ${DateFormat('dd/MM/yy').format(
                                order.dateTime) }"),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.call, size: 16,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          order.phoneNumber,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Processing",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Column(
              children: order.products
                  .map(
                    (prod) =>
                    ListTile(
                      title: Text(
                        prod.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Quantity: ${prod.quantity}x"),
                      trailing: Text(
                        "Subtotal: \$${prod.quantity * prod.price}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
              )
                  .toList()),
          Divider(
            thickness: 2,
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text("Shipping fees:     \$$_shippingFees",
              style: TextStyle(
                  fontSize: 18),),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text("Total:     \$${order.amount + _shippingFees}",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),),
          ),

        ],
      ),
    );
  }
}
