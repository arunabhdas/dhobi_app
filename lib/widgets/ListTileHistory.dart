import 'package:dhobi_app/widgets/BrandDivider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTileHistory extends StatelessWidget {
  final String pickupDate;
  final String status;
  final String createdAt;
  final Function onTapped;
  ListTileHistory(
      {this.pickupDate, this.status, this.createdAt, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapped,
          child: ListTile(
            subtitle: Text(
              '${DateFormat('EEEE, MMMM d').format(DateTime.parse(pickupDate))}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.purple[900],
              ),
            ),
            title: Text(
              'Order Placed : ' + '$createdAt.'.split(' ')[0],
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            trailing: (status != 'canceled')
                ? Text(
                    '${status.toUpperCase()}'.split(' ')[0],
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Ubunty-Bold',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Text(
                    '${status.toUpperCase()}'.split(' ')[0],
                    style: TextStyle(
                        color: Colors.deepOrangeAccent[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Ubuntu-Regular'),
                  ),
          ),
        ),
        BrandDivider(),
      ],
    );
  }
}
