import 'package:dhobi_app/datamodels/OrderDetails.dart';
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
    dbRef.once().then((DataSnapshot snapshot) {
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
        print(orderDetails.pickupDate);
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
          //TODO: shows everyone's order, need to show user order only.
          child: (_list.length == 0)
              ? Text('No Data')
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      subtitle: Text(
                        '${_list[index].userAddress}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple[900],
                        ),
                      ),
                      title: Text(
                        '${_list[index].createdAt}',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      trailing: Text(
                        '${_list[index].status}'.split(' ')[0],
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    );
                    //return Text(_list[index].status);
                  },
                ),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     ListTile(
          //       subtitle: Text(
          //         'Laundry Order',
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: Colors.purple[900],
          //         ),
          //       ),
          //       title: Text(
          //         '11/21/2020',
          //         style: TextStyle(color: Colors.black54, fontSize: 13),
          //       ),
          //       trailing: Icon(
          //         Icons.arrow_forward_ios_sharp,
          //         color: Colors.black54,
          //       ),
          //     ),
          //     BrandDivider(),
          //     ListTile(
          //       subtitle: Text(
          //         'Laundry Order, Dry Cleaning',
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: Colors.purple[900],
          //         ),
          //       ),
          //       trailing: Icon(
          //         Icons.arrow_forward_ios_sharp,
          //         color: Colors.black54,
          //       ),
          //       title: Text(
          //         '10/08/2020',
          //         style: TextStyle(color: Colors.black54, fontSize: 13),
          //       ),
          //     ),
          //     BrandDivider(),
          //     ListTile(
          //       subtitle: Text(
          //         'Polishing',
          //         style: TextStyle(
          //           fontSize: 20,
          //           color: Colors.purple[900],
          //         ),
          //       ),
          //       title: Text(
          //         '22/05/2019',
          //         style: TextStyle(color: Colors.black54, fontSize: 13),
          //       ),
          //       trailing: Icon(
          //         Icons.arrow_forward_ios_sharp,
          //         color: Colors.black54,
          //       ),
          //     ),
          //     BrandDivider(),
          //   ],
          // ),
        ),
      ),
    );
  }
}
