import 'dart:io';
import 'dart:ui';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/screens/add_address.dart';
import 'package:dhobi_app/screens/change_password_screen.dart';
import 'package:dhobi_app/screens/login_page.dart';
import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:dhobi_app/widgets/firebaseStroageImage.dart';
import 'package:dhobi_app/widgets/ourDialog.dart';
import 'package:dhobi_app/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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

  File newProfilePic;
  bool isChanged;
  File _imageFile;
  String imageLink;
  User user = FirebaseAuth.instance.currentUser;

  var pic = AssetImage('images/profilePic.png');
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      //wrapped inside a if to prevent runtime error, test on a real device.
      File tempImage = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: pickedImage.path,
        maxWidth: 500,
        maxHeight: 500,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressFormat: ImageCompressFormat.png,
        compressQuality: 50,
      );
      _imageFile = tempImage;
      if (tempImage != null) {
        setState(() {
          newProfilePic = File(tempImage.path);
        });
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
          setState(() {
            isChanged = true;
          });
        } catch (e) {
          print(e);
        }
      } else {
        return;
      }
      (context as Element).rebuild();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Text('Sign Out',
                    style: TextStyle(color: Colors.purple[900])),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OurDialog(
                          title: 'Are You Sure You Want To Sign Out',
                          buttonText: 'Sign Out',
                          onTapped: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, LoginPage.id);
                            profilePicRef = null;
                          },
                        );
                      });
                },
              ),
            ),
          )
        ],
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'My Account',
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
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OurDialog(
                            title: 'Change Profile Picture',
                            buttonText: 'Select Photo',
                            onTapped: () {
                              getImage();
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: isChanged == true
                          ? Image.file(File(_imageFile.path))
                          : FirebaseStorageImage(
                              reference: profilePicRef,
                              placeholderImage:
                                  AssetImage('images/spinner.gif'),
                              errorWidget: Container(),
                            ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/noProfilePic.png')),
                      color: Colors.purple[900],
                      shape: BoxShape.circle,
                    ),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddAddress(editingAddress: false)));
                  setState(() {});
                },
                child: ListTile(
                  subtitle: Text(
                    '${currentUserInfo.streetAddress}, ${currentUserInfo.city}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple[900],
                    ),
                  ),
                  title: Text(
                    'Address',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.black54,
                  ),
                ),
              ),
              BrandDivider(),
              ListTile(
                trailing: !user.emailVerified
                    ? GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'VERIFY',
                            style: TextStyle(
                                color: Colors.deepOrangeAccent[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Ubuntu-Regular'),
                          ),
                        ),
                        onTap: () async {
                          await user.sendEmailVerification();
                          showSnackBar('Check your Email for Verification');
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          'VERIFIED',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Ubuntu-Regular'),
                        ),
                      ),
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
