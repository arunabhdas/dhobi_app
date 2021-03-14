import 'package:firebase_database/firebase_database.dart';

class OurUser {
  String fullName;
  String email;
  String phone;
  String id;
  String city;
  String streetAddress;
  String addressDetail;

  OurUser(
      {this.email,
      this.fullName,
      this.phone,
      this.id,
      this.city,
      this.streetAddress,
      this.addressDetail});

  OurUser.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
    city = snapshot.value['address_details']['city'];
    streetAddress = snapshot.value['address_details']['street_address'];
    addressDetail = snapshot.value['address_details']['address_detail'];
  }
}
