import 'package:bolt_ecommerce/constants.dart';
import 'package:bolt_ecommerce/provider/products.dart';
import 'package:bolt_ecommerce/screens/fetched_details_screen.dart';
import 'package:bolt_ecommerce/widgets/all_products_design_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class AllProductsScreen extends StatelessWidget {
  static const routeName = "/allProductsScreen";

  @override
  Widget build(BuildContext context) {

    final products =  Provider.of<Products>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          primary: false,
          shrinkWrap: true,
          itemCount: products.allItems.length,
          itemBuilder: (context, i) {
            return AllProductDesign(
              function: () {
                Navigator.of(context).pushNamed(FetchedDetailsScreen.routeName,
                    arguments: products.allItems[i].id);
                print(products.allItems[i].id);
              },
              title: products.allItems[i].title,
              imagePath: "${products.allItems[i].imagePath}",
              price: products.allItems[i].price,
            );
          },
          staggeredTileBuilder: (int i) => new StaggeredTile.fit(2),
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
      ),
    );
  }
}


