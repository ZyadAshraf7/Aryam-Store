import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:bolt_ecommerce/widgets/cart_product_item.dart';
import 'package:bolt_ecommerce/widgets/checkout_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cart screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final order = Provider.of<Orders>(context);
    final userEmail = UserSimplePreference.getEmail();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: cart.fetchedCartItems.isEmpty
          ? IfCartIsEmpty()
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: ListView.builder(
                      itemCount: cart.fetchedCartItems.length,
                      itemBuilder: (ctx, i) =>
                          ChangeNotifierProvider<CartItem>.value(
                        value: cart.fetchedCartItems[i],
                        child: CartProductItem(
                          id: cart.fetchedCartItems.values
                              .toList()[i]
                              .productId,
                          productId: cart.fetchedCartItems.keys.toList()[i],
                          price: cart.fetchedCartItems.values.toList()[i].price,
                          imagePath: cart.fetchedCartItems.values
                              .toList()[i]
                              .imagePath,
                          quantity:
                              cart.fetchedCartItems.values.toList()[i].quantity,
                          title: cart.fetchedCartItems.values.toList()[i].title,
                        ),
                      ),
                    ),
                  ),
                ),
                CheckOutCartProducts(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return Form(
                          key: _formKey,
                          child: AlertDialog(
                            content: Column(
                                  mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return "Location Field Can't Be Empty";
                                    else
                                      return null;
                                  },
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_on_rounded),
                                    hintText: "Home address",
                                  ),
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return "Phone Number Field Can't Be Empty";
                                    else
                                      return null;
                                  },
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.call),
                                    hintText: "Phone",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    order.addOrder(
                                      cart.totalAmountCartProducts,
                                      cart.fetchedCartItems.values.toList(),
                                      addressController.text,
                                      userEmail,phoneNumberController.text,
                                    );
                                    cart.clearAllItemsFromCart(userEmail);
                                    Provider.of<Orders>(context, listen: false)
                                        .fetchOrders(userEmail);
                                    Navigator.of(ctx).pop(true);
                                    Alert(
                                      style: AlertStyle(
                                        titleStyle: TextStyle(fontWeight: FontWeight.bold),
                                        descStyle: TextStyle(fontSize: 16)
                                      ),
                                        context: context,
                                        type: AlertType.success,
                                        title: "Great choice",
                                        desc:
                                            "Ordered successfully\nYour order is under processing now",
                                        buttons: [
                                          DialogButton(
                                              width: 120,
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              }),
                                        ]).show();
                                  } else
                                    return;
                                },
                                child: Text("Order Now"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pinkAccent,
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class IfCartIsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_rounded,
            size: 50,
            color: Colors.pinkAccent,
          ),
          SizedBox(height: 20),
          Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Be sure you fill your cart\nwith something you like",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
