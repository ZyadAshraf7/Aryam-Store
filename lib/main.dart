import 'package:bolt_ecommerce/application_root.dart';
import 'package:bolt_ecommerce/models/product.dart';
import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/provider/products.dart';
import 'package:bolt_ecommerce/screens/cart_screen.dart';
import 'package:bolt_ecommerce/screens/fetched_details_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreference.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Product()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: CartItem()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: OrderItem()),
        ChangeNotifierProvider.value(value: Authentication()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Ubutnu',
          ),
          debugShowCheckedModeBanner: false,
          home: AppRoot(),
          routes: {
            CartScreen.routeName: (ctx) => CartScreen(),
            FetchedDetailsScreen.routeName: (ctx) => FetchedDetailsScreen()
          },
        ),

    );
  }
}
