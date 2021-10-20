
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  String productId;
  String title;
  String imagePath;
  int price;
  int quantity;

  CartItem({this.productId, this.title,this.imagePath, this.price, this.quantity});
}

class Cart with ChangeNotifier {

  Map<String,CartItem> _fetchedCartItems = {};

  Map<String, CartItem> get fetchedCartItems {
    return {..._fetchedCartItems};
  }

  Future fetchCartItems(String userEmail)async{


      var snapshot = await FirebaseFirestore.instance
          .collection("usersCartItems")
          .doc(userEmail)
          .collection("cartProducts")
          .get();
      for (var doc in snapshot.docs) {
        var data = doc.data();
        if (_fetchedCartItems.containsKey(data['id'])) {
          _fetchedCartItems.update(data['id'], (existingProduct) =>
              CartItem(
                productId: existingProduct.productId,
                title: existingProduct.title,
                imagePath: existingProduct.imagePath,
                price: existingProduct.price,
                quantity: existingProduct.quantity,
              ));
        } else {
          _fetchedCartItems.putIfAbsent(data['id'], () =>
              CartItem(
                productId: DateTime.now().toString(),
                title: data['title'],
                imagePath: data['imagePath'],
                price: data['price'],
                quantity: 1,
              ));
        }
      }

      //print(fetchedCartItems.length);
      // return _fetchedCartItems;
      notifyListeners();

  }


  Future addToCart(String title, int price, String imagePath, String userEmail,String productId)  {
      CollectionReference collectionRef = FirebaseFirestore.instance.collection(
          "usersCartItems");
      return collectionRef.doc(userEmail).collection("cartProducts").doc(
          productId).set({
        'id':productId,
        'title': title,
        'price': price,
        'imagePath': imagePath,
        'quantity':1,
      }).then((value) => print("Added To Cart"));

  }

  incrementItemQuantity(String productId,String userEmail,int quantity){
    FirebaseFirestore.instance.collection(
        "usersCartItems").doc(userEmail).collection("cartProducts").doc(productId).update(
      {
        'quantity':quantity+1,
      }
    );

    _fetchedCartItems.update(
        productId,
            (existingProduct) =>
            CartItem(
              productId: existingProduct.productId,
              title: existingProduct.title,
              imagePath: existingProduct.imagePath,
              price: existingProduct.price,
              quantity: existingProduct.quantity + 1,
            ));
    notifyListeners();
  }

  decrementItemQuantity(String productId,String userEmail,int quantity){
    FirebaseFirestore.instance.collection(
        "usersCartItems").doc(userEmail).collection("cartProducts").doc(productId).update(
        {
          'quantity':quantity-1,
        }
    );
    _fetchedCartItems.update(
        productId,
            (existingProduct) =>
            CartItem(
              productId: existingProduct.productId,
              title: existingProduct.title,
              imagePath: existingProduct.imagePath,
              price: existingProduct.price,
              quantity: existingProduct.quantity - 1,
            ));
        notifyListeners();
    }

    // REMOVE SINGLE ITEM FROM CART
  void removeItemFromCart(String id,String userEmail) {
    FirebaseFirestore.instance.collection(
        "usersCartItems").doc(userEmail).collection("cartProducts").doc(id).delete();
    _fetchedCartItems.remove(id);
    notifyListeners();
  }
  void clearAllItemsFromCart(String userEmail) {
    FirebaseFirestore.instance.collection(
        "usersCartItems").doc(userEmail).collection("cartProducts").get().then((snapshot) {
          for(DocumentSnapshot ds in snapshot.docs ){
            ds.reference.delete();
          }
    });
    _fetchedCartItems.clear();
    notifyListeners();
  }
  void clearCartListLocally(){
    _fetchedCartItems={};
    notifyListeners();
  }
  // TOTAL PRICE OF CART PRODUCTS
  double get totalAmountCartProducts {
    var total = 0.0;
    _fetchedCartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

}

