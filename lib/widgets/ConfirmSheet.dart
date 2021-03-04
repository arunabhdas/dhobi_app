import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:flutter/material.dart';

class ConfirmSheet extends StatelessWidget {
  final String title;
  final Function onPressed;

  ConfirmSheet({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 15,
          spreadRadius: 5,
          offset: Offset(0.7, 0.7),
        ),
      ]),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.purple[900],
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Expanded(
                child: LargeButton(
                  title: 'Confirm',
                  color: Colors.purple[900],
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
