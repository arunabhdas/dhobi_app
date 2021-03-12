import 'package:dhobi_app/screens/custom_order_screen.dart';
import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateTime tommorowDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      (DateTime.now().weekday != 5)
          ? DateTime.now().day + 1
          : DateTime.now().day + 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Schedule Your Order',
          style: TextStyle(fontSize: 20, color: Colors.purple[900]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Text(
              'Standard One Day Service',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.purple[900],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: 275,
              decoration: BoxDecoration(
                  color: Colors.purple[900],
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'One Touch',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ' Pickup from the Door',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: 275,
              decoration: BoxDecoration(
                  color: Colors.purple[900],
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'One Touch',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ' Knock on The Door',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text('With One Tap, Your Order Will Be:'),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 330,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        'Picked up At:',
                        style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('EEEE, MMMM d').format(tommorowDate)}',
                            style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                          ),
                          Text(
                            'between 8 PM to 10 PM',
                            style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(children: [
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                  ]),
                  TableRow(children: [
                    Text(
                      'and Delivered At:',
                      style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('EEEE, MMMM d').format(tommorowDate.add((tommorowDate.weekday != 5) ? Duration(days: 1) : Duration(days: 2)))}',
                          style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                        ),
                        Text(
                          'between 8 PM to 10 PM',
                          style: TextStyle(fontFamily: 'Ubuntu-Bold'),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 30),
            LargeButton(
              title: ' or Create a Custom Order',
              color: Colors.purple[900],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomOrderScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
