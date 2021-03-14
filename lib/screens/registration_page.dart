import 'package:connectivity/connectivity.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/screens/login_page.dart';
import 'package:dhobi_app/screens/registration_page_more_info.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:dhobi_app/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

  double logoHeight = 200;
  double spaceHeight1 = 40;
  double spaceHeight2 = 20;

  void registerUser() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Registering You'),
    );
    UserCredential user = await _auth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .catchError((e) {
      FirebaseAuthException thisE = e;
      showSnackBar(thisE.message);
      Navigator.pop(context);
    });
    if (user != null) {
      print('Hello');
      DatabaseReference newUserRef = FirebaseDatabase.instance
          .reference()
          .child('/users/${user.user.uid}');
      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': maskFormatter.getUnmaskedText(),
      };
      newUserRef.set(userMap);

      currentFirebaseUser = user.user;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegistrationMorePage()));
    }
  }

  void buttonPressed() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar('No Internet Connection');
    }
    if (fullNameController.text.length < 3) {
      showSnackBar('Please Provide a Valid Full Name');
      return;
    }
    if (!emailController.text.contains('@') &&
        !emailController.text.contains('.')) {
      showSnackBar('Please a Valid Email Address');
      return;
    }
    if (maskFormatter.getUnmaskedText().length != 10) {
      showSnackBar('Please a Valid Phone Number');
      return;
    }
    if (passwordController.text.length < 8) {
      showSnackBar('Please a Valid Password');
      return;
    }
    if (passwordController.text != passwordConfirmController.text) {
      showSnackBar('Passwords do Not Match');
      return;
    }

    registerUser();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {
            logoHeight = 200;
            spaceHeight1 = 0;
            spaceHeight2 = 30;
          });
        },
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
                      height: spaceHeight2,
                    ),
                    Image.asset(
                      'images/logo.png',
                      height: logoHeight,
                    ),
                    SizedBox(
                      height: spaceHeight1,
                    ),
                    Text(
                      'Create an Account',
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
                            onTap: () {
                              setState(() {
                                logoHeight = 0;
                              });
                            },
                            controller: fullNameController,
                            onEditingComplete: () => node.nextFocus(),
                            decoration: InputDecoration(
                              labelText: 'Full Name',
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
                            onTap: () {
                              setState(() {
                                logoHeight = 0;
                              });
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () => node.nextFocus(),
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
                            onTap: () {
                              setState(() {
                                logoHeight = 0;
                              });
                            },
                            inputFormatters: [maskFormatter],
                            keyboardType: TextInputType.phone,
                            onEditingComplete: () => node.nextFocus(),
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
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
                            onTap: () {
                              setState(() {
                                logoHeight = 0;
                              });
                            },
                            controller: passwordController,
                            obscureText: true,
                            onEditingComplete: () => node.nextFocus(),
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
                          TextField(
                            onTap: () {
                              setState(() {
                                logoHeight = 0;
                              });
                            },
                            controller: passwordConfirmController,
                            obscureText: true,
                            onEditingComplete: () async {
                              buttonPressed();
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
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
                            height: 40,
                          ),
                          LargeButton(
                            onPressed: () async {
                              buttonPressed();
                            },
                            color: Colors.purple[900],
                            title: 'REGISTER',
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, LoginPage.id);
                            },
                            child: Text('Already Have an Account, Log In'),
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
      ),
    );
  }
}
