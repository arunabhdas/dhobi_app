import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black45,
          backgroundColor: Colors.white,
          title: Text(
            'About Us',
            style: TextStyle(fontSize: 20, color: Colors.purple[900]),
          ),
        ),
        body: Container());
  }
}
