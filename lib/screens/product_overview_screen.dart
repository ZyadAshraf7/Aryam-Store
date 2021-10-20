import 'package:bolt_ecommerce/application_root.dart';
import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/screens/cart_screen.dart';
import 'package:bolt_ecommerce/screens/home_screen.dart';
import 'package:bolt_ecommerce/screens/orders_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/widgets/badge.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    IndexedStack(
      index: _currentIndex,
      children: [
        HomeScreen(),
        OrdersScreen(),
        CartScreen(),
      ],
    );
    final tabs = [
      HomeScreen(),
      OrdersScreen(),
      CartScreen(),
    ];
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.storeAlt, color: Colors.pinkAccent),
              SizedBox(
                width: 10,
              ),
              Text(
                "Aryam's Store",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(context: context, builder: (ctx){
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout ?"),
                  actions: [
                    TextButton(onPressed: ()async{
                      Navigator.of(context).pop(true);

                      Authentication currentUser =
                      Provider.of<Authentication>(context,listen: false);
                      String _retString = await currentUser.signOut();
                      if (_retString == "success") {
                        cart.clearCartListLocally();
                        order.clearOrdersListLocally();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) => AppRoot()),
                                (route) => false);
                      }
                    }, child: Text("Yes")),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop(true);
                    }, child: Text("No")),

                  ],
                );
              });

            },
            icon: Icon(Icons.login_rounded,color: Colors.black54,),
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //showElevation: true,

        iconSize: 28,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.explore_rounded,
            ),
            title: Text("Home"),
            textAlign: TextAlign.center,
            activeColor: Colors.pinkAccent,
            inactiveColor: Colors.grey
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.receipt_long_rounded,
            ),
            title: Text("Orders"),
            textAlign: TextAlign.center,
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.grey
          ),
          BottomNavyBarItem(
            icon: cart.fetchedCartItems.isEmpty
                ? Icon(
                    Icons.shopping_bag_rounded,
                  )
                : Badge(
                    child: Icon(
                      Icons.shopping_bag_rounded,
                    ),
                  ),
            title: Text("Cart"),
            textAlign: TextAlign.center,
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.grey
          ),
        ],
      ),
    );
  }
}
