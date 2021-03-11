import 'package:dhobi_app/datamodels/OurUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

User currentFirebaseUser;
OurUser currentUserInfo;

Reference profilePicRef;
