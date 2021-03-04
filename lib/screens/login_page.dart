import 'package:connectivity/connectivity.dart';
import 'package:dhobi_app/screens/forgot_password_screen.dart';
import 'package:dhobi_app/screens/main_screen.dart';
import 'package:dhobi_app/screens/registration_page.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:dhobi_app/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Logging You In'),
    );
    User user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      Navigator.pop(context);
      FirebaseAuthException thisEx = ex;
      showSnackBar(thisEx.message);
    }))
        .user;

    if (user != null) {
      //verify login
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('/users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) => {
            if (snapshot != null)
              {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainPage.id,
                  (route) => false,
                )
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    'images/logo.png',
                    height: 300.0,
                    width: 300.0,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Welcome Back, Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Brand-Bold',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: () async {
                                showSnackBar(await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword())));
                              },
                              child: Text('Forgot Password?'),
                            ),
                          ],
                        ),
                        LargeButton(
                          onPressed: () async {
                            var connectivityResult =
                                await Connectivity().checkConnectivity();
                            if (connectivityResult !=
                                    ConnectivityResult.mobile &&
                                connectivityResult != ConnectivityResult.wifi) {
                              showSnackBar('No Internet Connection');
                            }
                            if (!emailController.text.contains('@')) {
                              showSnackBar('Please Enter a Valid Email');
                              return;
                            }

                            if (passwordController.text.length < 8) {
                              showSnackBar('Please Enter a Password');
                              return;
                            }
                            login();
                          },
                          color: Colors.purple[900],
                          title: 'LOGIN',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegistrationPage.id);
                          },
                          child: Text('Sign Up?'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
