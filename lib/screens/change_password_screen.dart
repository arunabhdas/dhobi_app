import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/widgets/largeButton.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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

  var newPasswordController = TextEditingController();
  var newPasswordConfirmController = TextEditingController();
  var oldPasswordController = TextEditingController();

  void reAuthandChangePassword(String password, String newPassword) async {
    try {
      EmailAuthCredential credential = EmailAuthProvider.credential(
          email: currentUserInfo.email, password: oldPasswordController.text);

      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential);
      print(credential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message);
      return;
    }
    User user = FirebaseAuth.instance.currentUser;
    user.updatePassword(newPassword).then((_) async {
      Navigator.pop(context);
      //todo: provide message
      showSnackBar("Successfully changed password");
      // Navigator.pushNamed(context, LoginPage.id);
      // await FirebaseAuth.instance.signOut();
    }).catchError((error) {
      showSnackBar("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Change Password',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
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
                    controller: newPasswordController,
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
                  TextField(
                    controller: newPasswordConfirmController,
                    obscureText: true,
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: LargeButton(
                color: Colors.purple[900],
                title: 'Confirm',
                onPressed: () {
                  if (newPasswordController.text !=
                      newPasswordConfirmController.text) {
                    showSnackBar('Passwords Do Not Match');
                    return;
                  }
                  reAuthandChangePassword(
                      oldPasswordController.text, newPasswordController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
