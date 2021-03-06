import 'package:flutter/material.dart';

class LargeOutlineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  LargeOutlineButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Brand-Bold',
            ),
          ),
        ),
      ),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(color: color)),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}
