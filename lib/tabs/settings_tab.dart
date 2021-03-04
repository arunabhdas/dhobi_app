import 'dart:io';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/screens/change_password_screen.dart';
import 'package:dhobi_app/screens/login_page.dart';
import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:dhobi_app/widgets/ConfirmSheet.dart';
import 'package:dhobi_app/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  File newProfilePic;
  String imageLink =
      'https://firebasestorage.googleapis.com/v0/b/dhobiapp-ba6df.appspot.com/o/${currentUserInfo.id}%2FProfilePic?alt=media&token=$accessToken';
  var pic = AssetImage('images/profilePic.png');
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage() async {
    var tempImage = await picker.getImage(source: ImageSource.gallery);
    if (tempImage != null) {
      newProfilePic = File(tempImage.path);
      print(newProfilePic.path);
      try {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              ProgressDialog(status: 'Loading..'),
        );
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('${currentUserInfo.id}/ProfilePic');
        await ref.putFile(newProfilePic);
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
    (context as Element).rebuild();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Text('Sign Out'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => ConfirmSheet(
                      title: 'Sign Out?',
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Account',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                          getImage();
                          setState(() {
                            imageLink =
                                'https://firebasestorage.googleapis.com/v0/b/dhobiapp-ba6df.appspot.com/o/${currentUserInfo.id}%2FProfilePic?alt=media&token=$accessToken';
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(
                            Icons.edit,
                            size: 15.0,
                            color: Colors.purple[900],
                          ),
                        ),
                      ),
                    ),
                    radius: 70.0,
                    //This is the user Profile, clicking this opens the user profile, add gesture detector
                    backgroundImage: NetworkImage(imageLink),
                  ),
                ),
              ),
              SizedBox(height: 25),
              BrandDivider(),
              ListTile(
                subtitle: Text(
                  '${currentUserInfo.fullName}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                title: Text(
                  'Name',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              BrandDivider(),
              ListTile(
                subtitle: Text(
                  '${currentUserInfo.phone}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                title: Text(
                  'Phone Number',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              BrandDivider(),
              ListTile(
                subtitle: Text(
                  '${currentUserInfo.email}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                title: Text(
                  'Email Address',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              BrandDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                child: ListTile(
                  subtitle: Text(
                    '**********',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                  title: Text(
                    'Password',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black54,
                  ),
                ),
              ),
              BrandDivider(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
