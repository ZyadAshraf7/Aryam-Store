import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CartProductItem extends StatelessWidget {
  final String id;
  final String productId;
  final int price;
  final String imagePath;
  final int quantity;
  final String title;

  CartProductItem({
    this.id,
    this.productId,
    this.price,
    this.imagePath,
    this.quantity,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final userEmail=UserSimplePreference.getEmail();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 140,
      width: 325,
      decoration:
          BoxDecoration(color: Colors.white, boxShadow: [kDefaultShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [kDefaultShadow]),
            height: 110,
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "\$${price * quantity}",
                style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            quantity > 1
                                ? cart.decrementItemQuantity(
                                    productId,userEmail,quantity)
                                : null;
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.minus,
                            size: 16,
                          ),
                        ),
                        Text(
                          "$quantity",
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            cart.incrementItemQuantity(productId,userEmail,quantity);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text("Delete Product"),
                            content: Text(
                                "Do You Want To Delete This Product From Cart"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                  cart.removeItemFromCart(productId,userEmail);
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 28,
                      color: Colors.grey,
                    ),
                  ), //Delete Product button
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
