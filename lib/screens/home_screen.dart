import 'package:bolt_ecommerce/category_items_list.dart';
import 'package:bolt_ecommerce/screens/all_products_screen.dart';
import 'package:bolt_ecommerce/screens/fetch_data_screen.dart';
import 'package:bolt_ecommerce/widgets/category_items.dart';
import 'package:bolt_ecommerce/widgets/category_title_row.dart';
import 'package:bolt_ecommerce/widgets/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBox(),
            SizedBox(height: 14),
            CategoryTitleRow(title: "Categories",pressed: (){},),
            SizedBox(height: 14),
            Categories(categoryItems: items),
            SizedBox(height: 14),
            CategoryTitleRow(title: "Featured",pressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AllProductsScreen()));
            },),
            SizedBox(height: 14),
            FeaturedProductsFetched(),
            SizedBox(height: 14),
            CategoryTitleRow(title:"Best Sell",pressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AllProductsScreen()));
            },),
            SizedBox(height: 14),
            BestSellProductsFetched(),
            SizedBox(height: 14),
            CategoryTitleRow(title:"Trendy",pressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AllProductsScreen()));
            },),
            SizedBox(height: 14),
            TrendProductsFetched(),
          ],
        ),
      ),
    );
  }
}

