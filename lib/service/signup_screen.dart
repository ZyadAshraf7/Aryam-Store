import 'package:bolt_ecommerce/screens/product_overview_screen.dart';
import 'package:bolt_ecommerce/service/authentication.dart';
import 'package:bolt_ecommerce/service/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  void _signupUser(String email, String password, BuildContext context) async {
    Authentication currentUser =
        Provider.of<Authentication>(context, listen: false);
    try {
      if (await currentUser.signUpFunction(email, password)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  var _secured = true;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                "Welcome Again",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Create Account",
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
                      controller: usernameController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Username field can't be empty";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Email field can't be empty";
                        else if (!value.contains('@'))
                          return "Please enter a valid email";
                        else
                          return null;
                      },
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
                      obscureText: _secured,
                      controller: passwordController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "Password field can't be empty";
                        else if (value.length < 6)
                          return "password is too short";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w600),
                        prefixIcon: Icon(Icons.enhanced_encryption_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_rounded),
                          onPressed: (){
                            setState(() {
                              _secured=!_secured;
                            });
                          },
                        )
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

                        try {
                          Alert(
                            context: context,
                            style: AlertStyle(
                              titleStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              descStyle: TextStyle(fontSize: 16),
                              isCloseButton: false,
                            ),
                            type: AlertType.success,
                            title: "Registiration Successfully",
                            desc: "You are in aryam's family now\nPlease login with your email and password",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: ()  {
                                   _signupUser(emailController.text,
                                      passwordController.text, context);
                                  Navigator.pop(context);
                                },
                                width: 120,
                              )
                            ],
                          ).show();
                        } catch (e) {
                          print(e);
                          print("Error in signup");
                        }
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
                        "Sign up",
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
                        "Already have an account ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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
