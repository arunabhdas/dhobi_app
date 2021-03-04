import 'package:firebase_database/firebase_database.dart';

class OurUser {
  String fullName;
  String email;
  String phone;
  String id;

  OurUser({this.email, this.fullName, this.phone, this.id});

  OurUser.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
  }
}
