import 'package:bolt_ecommerce/screens/splash_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/service/login_screen.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  loggedIn,
  notLoggedIn,
}

class AppRoot extends StatefulWidget {
  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  AuthStatus authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    String user = UserSimplePreference.getEmail();
    if(user!=''||user!=null){
      setState(() {
        authStatus = AuthStatus.loggedIn;
      });
      if(user==null||user==''){
        setState(() {
          authStatus = AuthStatus.notLoggedIn;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;
      case AuthStatus.loggedIn:
        retVal = SplashScreenLoading();
        break;
    }
    return retVal;
  }
}
