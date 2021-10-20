import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/orders.dart';
import 'package:bolt_ecommerce/provider/products.dart';
import 'package:bolt_ecommerce/screens/fetched_details_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:bolt_ecommerce/widgets/product_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FeaturedProductsFetched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentUserEmail=UserSimplePreference.getEmail();
    print("Email:  ${UserSimplePreference.getEmail()}");
    final products = Provider.of<Products>(context, listen: false);
    print("all product length: ${products.allItems.length}");
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: products.featuredProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          print(products.featuredProducts.length);
          return ProductCardWidget(
            function: () {
              Navigator.of(context).pushNamed(FetchedDetailsScreen.routeName,
                  arguments: products.featuredProducts[i].id);
              print(products.featuredProducts[i].id);
            },
            title: products.featuredProducts[i].title,
            imagePath: "${products.featuredProducts[i].imagePath}",
            price: products.featuredProducts[i].price,
          );
        },
      ),
    );
  }
}
class BestSellProductsFetched extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: products.bestSellProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          print(products.bestSellProducts.length);
          return ProductCardWidget(
            function: () {
              Navigator.of(context).pushNamed(FetchedDetailsScreen.routeName,
                  arguments: products.bestSellProducts[i].id);
              print(products.bestSellProducts[i].id);
            },
            title: products.bestSellProducts[i].title,
            imagePath: "${products.bestSellProducts[i].imagePath}",
            price: products.bestSellProducts[i].price,
          );
        },
      ),
    );
  }
}

class TrendProductsFetched extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: products.trendProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          print(products.trendProducts.length);
          return ProductCardWidget(
            function: () {
              Navigator.of(context).pushNamed(FetchedDetailsScreen.routeName,
                  arguments: products.trendProducts[i].id);
              print(products.trendProducts[i].id);
            },
            title: products.trendProducts[i].title,
            imagePath: "${products.trendProducts[i].imagePath}",
            price: products.trendProducts[i].price,
          );
        },
      ),
    );
  }
}