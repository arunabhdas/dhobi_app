import 'package:dhobi_app/datamodels/OurUser.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HelperMethods {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    String userId = currentFirebaseUser.uid;

    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$userId');
    userRef.once().then((DataSnapshot snapshot) {
      currentUserInfo =
          snapshot.value != null ? OurUser.fromSnapshot(snapshot) : null;
      profilePicRef = FirebaseStorage.instance
          .ref()
          .child('${currentUserInfo.id}/ProfilePic');
    });
  }
}
