import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:bolt_ecommerce/provider/products.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:bolt_ecommerce/widgets/select_sizes.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchedDetailsScreen extends StatelessWidget {

  static const routeName='fetched-details-screen';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product=Provider.of<Products>(context).findProductById(productId);
    final cart=Provider.of<Cart>(context,listen: false);
    final userEmail=UserSimplePreference.getEmail();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 400,
                width: double.infinity,
                child: Carousel(
                  images: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: Hero(
                          tag: product.title,
                          child: Image.network(
                            product.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: Image.network(
                          product.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: Image.network(
                          product.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  dotBgColor: Colors.transparent,
                  dotIncreasedColor: Colors.blueAccent,
                  dotPosition: DotPosition.bottomLeft,
                  autoplay: false,
                ),
              ),
              SizedBox(height: 14),
              Text(
                product.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 14),
              Text(
                "\$${product.price}",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 14),
              Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "${product.rate}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    if (product.rate >= 4.7)
                      Text(
                        "Excellent",
                        style: TextStyle(fontSize: 24),
                      )
                    else if (product.rate < 4.7)
                      Text(
                        "Very Good",
                        style: TextStyle(fontSize: 24),
                      )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 5),
              Text(
                "Description",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 18),
              Text(
                product.description,
                style: TextStyle(fontSize: 18),
              ),
              /*SizedBox(height: 14),
              Divider(
                thickness: 2,
              ),
              Center(
                child: Text(
                  "Select Size",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SelectedSizes(),*/
              SizedBox(height: 14),
              Divider(
                height: 0,
                thickness: 2,
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: (){
                  cart.addToCart(product.title, product.price.toInt(), product.imagePath,userEmail,product.id);
                  cart.fetchCartItems(userEmail);
                  print(cart.fetchedCartItems);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product is added to the cart"),duration: Duration(seconds: 1),));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10,top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueAccent,
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: Text("Add To Cart",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
