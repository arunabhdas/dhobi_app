import 'package:dhobi_app/widgets/largeButton.dart';
import 'package:flutter/material.dart';

class OurDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final Function onTapped;

  OurDialog({Key key, this.title, this.buttonText, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 200,
                  height: 45,
                  child: LargeButton(
                    title: buttonText,
                    color: Colors.purple[900],
                    onPressed: onTapped,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
