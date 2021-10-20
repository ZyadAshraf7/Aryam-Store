import 'package:bolt_ecommerce/provider/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderItem with ChangeNotifier {
  String id;
  double amount;
  List<CartItem> products;
  DateTime dateTime;
  String address;
  String phoneNumber;

  OrderItem({this.id, this.amount, this.products, this.dateTime, this.address,this.phoneNumber});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future addOrder(double total, List<CartItem> cartProducts, String address,
      String userEmail,String phoneNumber) {
    final timeNow = DateTime.now();
    _orders.insert(
      0,
      OrderItem(
        id: timeNow.toString(),
        amount: total,
        products: cartProducts,
        dateTime: timeNow,
        address: address,
        phoneNumber: phoneNumber,
      ),
    );
    print("Added To Orders");
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("orders");
    return collectionRef.doc(userEmail).collection("user orders").doc().set({
          'amount':total,
          'date time':timeNow.toIso8601String(),
          'address':address,
          'phone number':phoneNumber,
          'products':cartProducts.map((cartProduct) => {
            'id':cartProduct.productId,
            'title':cartProduct.title,
            'price':cartProduct.price,
            'quantity':cartProduct.quantity,
          }).toList(),

    });
  }

 Future fetchOrders(String userEmail) async {
   var snapshot = await FirebaseFirestore.instance.collection("orders").doc(
       userEmail).collection("user orders").get();
   final List<OrderItem> loadedOrders = [];
   if(snapshot.docs==null)return ;
   for (var doc in snapshot.docs) {
     final extractedData = doc.data();

     //final extractedData = snapshot.docs as Map<String, dynamic>;
     if (extractedData == null) {
       return;
     }

    if(!loadedOrders.contains({extractedData.keys.toString()}))
       loadedOrders.add(OrderItem(
         id: extractedData.keys.toString(),
         amount: extractedData['amount'],
         dateTime: DateTime.parse(extractedData['date time']),
         address: extractedData['address'],
         phoneNumber:extractedData['phone number'] ,
         products: (extractedData['products'] as List<dynamic>).map((prod) =>
             CartItem(
               productId: prod['id'],
               price: prod['price'],
               quantity: prod['quantity'],
               title: prod['title'],
             )).toList(),
       ));
    _orders=loadedOrders;
     print(_orders);
   }
 }


 void clearOrdersListLocally(){
    _orders=[];
    notifyListeners();
 }
}
