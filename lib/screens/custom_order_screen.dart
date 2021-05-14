import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:dhobi_app/widgets/ourDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomOrderScreen extends StatefulWidget {
  @override
  _CustomOrderScreenState createState() => _CustomOrderScreenState();
}

class _CustomOrderScreenState extends State<CustomOrderScreen> {
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

  TextEditingController instructionFieldController = TextEditingController();
  TextEditingController driverFieldController = TextEditingController();
  String buttonText = 'Select Date';

  DateTime selectedPickupDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 1
          : DateTime.now().day + 2);

  DateTime selectedDeliveryDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 2
          : DateTime.now().day + 3);

  DateTime nextDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 1
          : DateTime.now().day + 2);

  _selectDate(BuildContext context) async {
    return buildMaterialDatePicker(context);
  }

  _selectPickupDate(BuildContext context) async {
    return buildMaterialDeliveryDatePicker(context);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void createLaundryRequest() {
    CollectionReference laundryRef =
        FirebaseFirestore.instance.collection('laundryRequest');
    laundryRef
        .add({
          'created_at': DateTime.now().toString(),
          'pickupDate': selectedPickupDate.toString(),
          'deliveryDate': selectedDeliveryDate.toString(),
          'userId': currentUserInfo.id,
          'userFullName': currentUserInfo.fullName,
          'userPhone': currentUserInfo.phone,
          'userAddress': currentUserInfo.streetAddress,
          'userCity': currentUserInfo.city,
          'userAddressDetail': currentUserInfo.addressDetail,
          'driver_instruction': driverFieldController.text,
          'instruction': instructionFieldController.text,
          'paymentMethod': 'CoD',
          'status': 'waiting'
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed : $error"));
  }

  /// Material Picker
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: 'Select Pickup Date',
      context: context,
      selectableDayPredicate: (date) {
        if (date.weekday == 6 || date.isBefore(nextDate)) {
          return false;
        }
        return true;
      },
      initialDate: selectedPickupDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedPickupDate)
      setState(() {
        selectedPickupDate = picked;
      });
  }

  /// Material Picker
  buildMaterialDeliveryDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      helpText: 'Select Delivery Date',
      context: context,
      selectableDayPredicate: (date) {
        if (date.weekday == 6 ||
            date.isBefore(nextDate.add(Duration(days: 1)))) {
          return false;
        }
        return true;
      },
      initialDate: selectedDeliveryDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedPickupDate)
      setState(() {
        selectedDeliveryDate = picked;
      });
  }

  void openDateChanger() {
    _selectDate(context);
  }

  void openPickupDateChanger() {
    _selectPickupDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black45,
          backgroundColor: Colors.white,
          title: Text(
            'Place Your Order',
            style: TextStyle(fontSize: 20, color: Colors.purple[900]),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25),
                  Container(height: 10, width: 200, child: BrandDivider()),
                  TextButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.calendar_today_sharp,
                        color: Colors.purple[900]),
                    label: Text(
                      "Select Pickup Date",
                      style: TextStyle(color: Colors.purple[900]),
                    ),
                  ),
                  Container(height: 10, width: 200, child: BrandDivider()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Laundry Will Be Picked Up On:',
                    style: TextStyle(
                      color: Colors.purple[900],
                      fontSize: 15,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${DateFormat('EEEE, MMMM d').format(selectedPickupDate)}",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: Colors.purple[900],
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(height: 10, width: 200, child: BrandDivider()),
                  TextButton.icon(
                    onPressed: () => _selectPickupDate(context),
                    icon: Icon(Icons.calendar_today_sharp,
                        color: Colors.purple[900]),
                    label: Text(
                      "Select Delivery Date",
                      style: TextStyle(color: Colors.purple[900]),
                    ),
                  ),
                  Container(height: 10, width: 200, child: BrandDivider()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'And Delivered On:',
                    style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 15,
                        fontFamily: 'Ubuntu'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${DateFormat('EEEE, MMMM d').format(selectedDeliveryDate)}',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: Colors.purple[900],
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: instructionFieldController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: 'Any Instructions',
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
                    controller: driverFieldController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: 'Any Instructions for the Driver',
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
                  SizedBox(
                    height: 25,
                  ),
                  LargeButton(
                      title: 'PLACE ORDER',
                      color: Colors.purple[900],
                      onPressed: () {
                        if (selectedDeliveryDate.isBefore(
                            selectedPickupDate.add(Duration(days: 1)))) {
                          showSnackBar('Invalid Date Range');
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return OurDialog(
                              title:
                                  'Your Order Will Be Picked Up At: ${DateFormat('EEEE, MMMM d').format(selectedPickupDate)} \n\n And Delivered At \n${DateFormat('EEEE, MMMM d').format(selectedPickupDate.add((selectedPickupDate.weekday != 5) ? Duration(days: 1) : Duration(days: 2)))}',
                              buttonText: 'Place Order',
                              onTapped: () {
                                if (selectedDeliveryDate.isBefore(
                                    selectedPickupDate
                                        .add(Duration(days: 1)))) {
                                  showSnackBar('Invalid Date Range');
                                }
                                createLaundryRequest();
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      }),
                ],
              )),
        ),
      ),
    );
  }
}
