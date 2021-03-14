import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomOrderScreen extends StatefulWidget {
  @override
  _CustomOrderScreenState createState() => _CustomOrderScreenState();
}

class _CustomOrderScreenState extends State<CustomOrderScreen> {
  TextEditingController instructionFieldController = TextEditingController();
  TextEditingController driverFieldController = TextEditingController();
  String buttonText = 'Select Date';

  DateTime selectedPickupDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 1
          : DateTime.now().day + 2);

  DateTime nextDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 1
          : DateTime.now().day + 2);

  _selectDate(BuildContext context) async {
    return buildMaterialDatePicker(context);
  }

  void createLaundryRequest() {}

  /// Material Picker
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      selectableDayPredicate: (date) {
        // Disable weekend days to select from the calendar
        if (date.weekday == 6 || date.isBefore(nextDate)) {
          //date.month < DateTime.now().month) {
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

  void openDateChanger() {
    _selectDate(context);
    setState(() {
      buttonText = 'Change Date';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black45,
          backgroundColor: Colors.white,
          title: Text(
            'Place Your Order',
            style: TextStyle(fontSize: 20, color: Colors.purple[900]),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Container(height: 10, width: 200, child: BrandDivider()),
                    TextButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.local_laundry_service_sharp,
                          color: Colors.purple[900]),
                      label: Text(
                        "Select Pickup Date",
                        style: TextStyle(color: Colors.purple[900]),
                      ),
                    ),
                    Container(height: 10, width: 200, child: BrandDivider()),
                    SizedBox(
                      height: 20,
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
                    Text(
                      'And Delivered On:',
                      style: TextStyle(
                          color: Colors.purple[900],
                          fontSize: 15,
                          fontFamily: 'Ubuntu'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${DateFormat('EEEE, MMMM d').format(selectedPickupDate.add((selectedPickupDate.weekday != 5) ? Duration(days: 1) : Duration(days: 2)))}',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Colors.purple[900],
                      ),
                    ),
                    SizedBox(height: 25),
                    // Text(
                    //   '**Pickup and Delivery will be anytime between 8AM to 10PM, Laundry Will Be Delivered next Business Day',
                    //   style: TextStyle(
                    //       color: Colors.purple[900],
                    //       fontSize: 12,
                    //       fontFamily: 'Ubuntu'),
                    // ),
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
                        // print(selectedPickupDate);
                        // print(selectedPickupDate.add(
                        //     (selectedPickupDate.weekday != 5)
                        //         ? Duration(days: 1)
                        //         : Duration(days: 2)));
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
