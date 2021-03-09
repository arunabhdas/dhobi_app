import 'package:dhobi_app/datamodels/OurUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

User currentFirebaseUser;
OurUser currentUserInfo;

String accessToken = '469959c5-d3e2-46d5-a31c-0fb5ef65d8e5';

Reference profilePicRef =
    FirebaseStorage.instance.ref().child('${currentUserInfo.id}/ProfilePic');
