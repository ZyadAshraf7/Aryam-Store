import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/provider/products.dart';
import 'package:bolt_ecommerce/screens/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import '../user_simple_preference.dart';

class SplashScreenLoading extends StatefulWidget {
  @override
  _SplashScreenLoadingState createState() => _SplashScreenLoadingState();
}

class _SplashScreenLoadingState extends State<SplashScreenLoading> {

  @override
  void didChangeDependencies() {
    Provider.of<Products>(context).loadFeatureProducts();
    Provider.of<Products>(context).loadBestSellProducts();
    Provider.of<Products>(context).loadAllProducts();
    Provider.of<Products>(context).loadTrendProducts();

    String currentUserEmail=UserSimplePreference.getEmail();
    Provider.of<Cart>(context,listen: false).fetchCartItems(currentUserEmail);
    Provider.of<Orders>(context).fetchOrders(currentUserEmail);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.pinkAccent,
      navigateAfterSeconds:ProductOverviewScreen(),
      seconds:10,
      title: Column(
        children: [
          FaIcon(FontAwesomeIcons.storeAlt,size: 80,color: Colors.white,),
          SizedBox(height: 100,),
          Text("Aryam Store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36,color: Colors.white),),
          SizedBox(height: 20,),
          Text("Be Yourself and Look Great Doing It.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)
        ],
      ),
      /*image: Image.asset('assets/images/splashscreen.jpg'),*/

      loaderIcon: SpinKitChasingDots(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
