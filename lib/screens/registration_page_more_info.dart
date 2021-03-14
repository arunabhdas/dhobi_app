import 'package:dhobi_app/screens/login_page.dart';
import 'package:dhobi_app/screens/main_page.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:dhobi_app/global_variables.dart';

class RegistrationMorePage extends StatefulWidget {
  @override
  _RegistrationMorePageState createState() => _RegistrationMorePageState();
}

class _RegistrationMorePageState extends State<RegistrationMorePage> {
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

  String _selectedLocation;

  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();

  void updateProfile(context) {
    String id = currentFirebaseUser.uid;

    DatabaseReference addressRef = FirebaseDatabase.instance
        .reference()
        .child('/users/$id/address_details');

    Map map = {
      'city': _selectedLocation,
      'street_address': addressController.text,
      'address_detail': addressDetailsController.text,
    };
    addressRef.set(map);
    Navigator.pushNamed(context, MainPage.id);
  }

  void buttonPress() {
    if (_selectedLocation == null) {
      showSnackBar('Please Select a City');
      return;
    }
    if (addressController.text.length < 7) {
      showSnackBar('Please Provide Your Location');
      return;
    }
    updateProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            shadowColor: Colors.black45,
            backgroundColor: Colors.white,
            title: Text(
              'Additional Details',
              style: TextStyle(fontSize: 20, color: Colors.purple[900]),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Choose A City: ',
                      style: TextStyle(color: Colors.purple[900], fontSize: 15),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton(
                      hint: Text('Select a City'),
                      value: _selectedLocation,
                      items: <String>['Kathmandu', 'Lalitpur', 'Bhaktapur']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_value) {
                        setState(() {
                          _selectedLocation = _value;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  controller: addressController,
                  onEditingComplete: () => node.nextFocus(),
                  decoration: InputDecoration(
                    labelText: 'Street Address',
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
                  controller: addressDetailsController,
                  maxLength: 150,
                  maxLines: 4,
                  minLines: 1,
                  onEditingComplete: () => node.nextFocus(),
                  decoration: InputDecoration(
                    labelText: 'Address Details (Optional)',
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
                LargeButton(
                  title: 'Lets GO!',
                  color: Colors.purple[900],
                  onPressed: () => buttonPress(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
