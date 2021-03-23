import 'package:dhobi_app/datamodels/OrderDetails.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/widgets/ListTileHistory.dart';
import 'package:dhobi_app/screens/OrderDetailsScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('laundryRequest');

  List<OrderDetails> _list = [];

  @override
  void initState() {
    super.initState();
    pullFromDB();
  }

  void pullFromDB() {
    dbRef
        .orderByChild('userId')
        .equalTo(currentUserInfo.id)
        .once()
        .then((DataSnapshot snapshot) {
      var data = snapshot.value;
      _list.clear();
      data.forEach((key, value) {
        OrderDetails orderDetails = OrderDetails(
            key,
            value['created_at'],
            value['deliveryDate'],
            value['driver_instruction'],
            value['instruction'],
            value['paymentMethod'],
            value['pickupDate'],
            value['status'],
            value['userAddress'],
            value['userAddressDetail'],
            value['userId'],
            value['userCity'],
            value['userFullName'],
            value['userPhone']);
        _list.add(orderDetails);
        _list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      });
      setState(() {});
    });
  }

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
        padding: EdgeInsets.all(16.0),
        //todo: need to refactor this code into another widget
        child: (_list.length == 0)
            ? Center(
                child: Text('Looks Like You Haven\'t Tried Our Service Yet'))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (_, index) {
                  return ListTileHistory(
                    list: _list,
                    index: index,
                    onTapped: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OrderDetailsScreen(thisOrder: _list[index]);
                      }));
                    },
                  );
                },
              ),
      ),
    );
  }
}
