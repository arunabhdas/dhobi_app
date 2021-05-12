import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhobi_app/datamodels/OrderDetails.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:dhobi_app/widgets/ourDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderDetails thisOrder;
  OrderDetailsScreen({this.thisOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Order Details',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.share_sharp,
              color: Colors.purple[900],
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text(thisOrder.id,
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Status: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text('${thisOrder.status.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Placed At: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text(
                            '${DateFormat('EEEE, MMMM d, y, h:m:s a').format(DateTime.parse(thisOrder.createdAt))}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order For: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text('${thisOrder.userFullName}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Number: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text('${thisOrder.userPhone}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Date: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text(
                            '${DateFormat('EEEE, MMMM d, y').format(DateTime.parse(thisOrder.pickupDate))}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Date: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text(
                            '${DateFormat('EEEE, MMMM d, y').format(DateTime.parse(thisOrder.deliveryDate))}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Address: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text('${thisOrder.userAddress}, ${thisOrder.userCity}',
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method: ',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.purple[900]),
                        ),
                        Text('${thisOrder.paymentMethod}'.split(' ')[0],
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.grey[900])),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  'Order Instruction: ',
                  style: TextStyle(fontSize: 18.0, color: Colors.purple[900]),
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Driver Instruction: ',
                  style: TextStyle(fontSize: 18.0, color: Colors.purple[900]),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LargeButton(
                        title: 'Dismiss',
                        color: Colors.purple[900],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    (thisOrder.status == 'waiting')
                        ? Expanded(
                            child: LargeButton(
                              title: 'Cancel Order',
                              color: Colors.redAccent[700],
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return OurDialog(
                                        title: 'Confirm Cancel The Order',
                                        buttonText: 'CONFIRM',
                                        onTapped: () {
                                          DocumentReference dbRef =
                                              FirebaseFirestore.instance
                                                  .collection('laundryRequest')
                                                  .doc('${thisOrder.id}');
                                          dbRef.update({'status': 'canceled'});
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
