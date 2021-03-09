import 'package:dhobi_app/datamodels/OurUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

User currentFirebaseUser;
OurUser currentUserInfo;

Reference profilePicRef =
    FirebaseStorage.instance.ref().child('${currentUserInfo.id}/ProfilePic');

final kSmall = TextStyle(fontSize: 15, color: Colors.deepPurple[900]);
