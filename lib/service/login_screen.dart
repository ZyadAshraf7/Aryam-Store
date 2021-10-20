import 'package:bolt_ecommerce/screens/product_overview_screen.dart';
import 'package:bolt_ecommerce/screens/splash_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/service/signup_screen.dart';
import 'package:bolt_ecommerce/user_simple_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _loginUser(String email, String password, BuildContext context) async {
    Authentication currentUser =
        Provider.of<Authentication>(context, listen: false);
    try {
      if (await currentUser.loginFunction(email, password, context)) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => SplashScreenLoading()),
            (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  var _secured = true;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final currentUser = Provider.of<Authentication>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    "assets/images/aryam.png",
                    fit: BoxFit.cover,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "Email field can not be empty";
                        else if (!value.contains('@'))
                          return "Please enter a valid email";
                        else
                          return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600),
                          prefixIcon: Icon(Icons.alternate_email)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return "Password can not be empty";
                        else
                          return null;
                      },
                      obscureText: _secured,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w600),
                        prefixIcon: Icon(Icons.enhanced_encryption_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_rounded),
                          onPressed: () {
                            setState(() {
                              _secured = !_secured;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState.validate())
                        _loginUser(emailController.text,
                            passwordController.text, context);
                      await UserSimplePreference.setEmail(emailController.text);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style:
                              TextStyle(fontSize: 20, color: Colors.pinkAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
