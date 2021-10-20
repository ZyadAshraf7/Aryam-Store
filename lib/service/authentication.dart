import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  String _uid;
  String _email;

  String get getUid => _uid;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";
    try {
      User user = await auth.currentUser;
      _email = user.email;
      _uid = user.uid;
      retVal = "success";
    } catch (e) {
      print(e);
    }
    print("Email user: $_email");
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await auth.signOut();
      UserSimplePreference.setEmail('');
      UserSimplePreference.clear();
      _email = null;
      _uid = null;
      retVal = "success";
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return retVal;
  }

  Future<bool> signUpFunction(String email, String password) async {
    bool retVal = false;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        retVal = true;
      }
    } catch (e) {
      print(e.toString());
    }
    return retVal;
  }

  Future<bool> loginFunction(
      String email, String password, BuildContext context) async {
    bool retVal = false;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        UserSimplePreference.setEmail(userCredential.user.email);
        retVal = true;
      }
    } catch (e) {
      print(e.toString());
    }
    return retVal;
  }

}
