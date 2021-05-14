import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhobi_app/datamodels/OrderDetails.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/screens/OrderDetailsScreen.dart';
import 'package:dhobi_app/widgets/ListTileHistory.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  Query laundryRef = FirebaseFirestore.instance
      .collection('laundryRequest')
      .where("userId", isEqualTo: currentUserInfo.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Order History',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        //todo: need to refactor this code into another widget
        child: StreamBuilder(
          stream:
              laundryRef.orderBy("pickupDate", descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ListTileHistory(
                  pickupDate: snapshot.data.docs[index]['pickupDate'],
                  createdAt: snapshot.data.docs[index]['created_at'],
                  status: snapshot.data.docs[index]['status'],
                  onTapped: () {
                    OrderDetails orderDetails = OrderDetails(
                        snapshot.data.docs[index].id,
                        snapshot.data.docs[index]['created_at'],
                        snapshot.data.docs[index]['deliveryDate'],
                        snapshot.data.docs[index]['driver_instruction'],
                        snapshot.data.docs[index]['instruction'],
                        snapshot.data.docs[index]['paymentMethod'],
                        snapshot.data.docs[index]['pickupDate'],
                        snapshot.data.docs[index]['status'],
                        snapshot.data.docs[index]['userAddress'],
                        snapshot.data.docs[index]['userAddressDetail'],
                        snapshot.data.docs[index]['userId'],
                        snapshot.data.docs[index]['userCity'],
                        snapshot.data.docs[index]['userFullName'],
                        snapshot.data.docs[index]['userPhone']);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OrderDetailsScreen(thisOrder: orderDetails);
                    }));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
