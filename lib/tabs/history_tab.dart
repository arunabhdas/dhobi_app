import 'package:dhobi_app/datamodels/OrderDetails.dart';
import 'package:dhobi_app/global_variables.dart';
import 'package:dhobi_app/widgets/BrandDivider.dart';
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
            value['UserPhone']);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          //todo: need to refactor this code into another widget
          child: (_list.length == 0)
              ? Text('Loading...')
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(_list[index].key);
                          },
                          child: ListTile(
                            subtitle: Text(
                              '${_list[index].userAddress}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple[900],
                              ),
                            ),
                            title: Text(
                              '${_list[index].createdAt}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            ),
                            trailing: Text(
                              '${_list[index].status}'.split(' ')[0],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            ),
                          ),
                        ),
                        (_list.length != 0) ? BrandDivider() : Container(),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
