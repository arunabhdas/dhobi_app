import 'package:dhobi_app/datamodels/OurUser.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HelperMethods {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = FirebaseAuth.instance.currentUser;
    String userId = currentFirebaseUser.uid;

    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$userId');
    userRef.once().then((DataSnapshot snapshot) {
      currentUserInfo =
          snapshot.value != null ? OurUser.fromSnapshot(snapshot) : null;
    });
  }

  // static Future<void> downloadProfilePicture() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File downloadToFile = File('${appDocDir.path}/images/profilePic.png');
  //   print(appDocDir.path);
  //   try {
  //     await firebase_storage.FirebaseStorage.instance
  //         .ref('uploads/logo.png')
  //         .writeToFile(downloadToFile);
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   }
  // }
}
