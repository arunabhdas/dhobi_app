import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                subtitle: Text(
                  'Laundry Order',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                title: Text(
                  '11/21/2020',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black54,
                ),
              ),
              BrandDivider(),
              ListTile(
                subtitle: Text(
                  'Laundry Order, Dry Cleaning',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black54,
                ),
                title: Text(
                  '10/08/2020',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
              BrandDivider(),
              ListTile(
                subtitle: Text(
                  'Polishing',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple[900],
                  ),
                ),
                title: Text(
                  '22/05/2019',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black54,
                ),
              ),
              BrandDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
