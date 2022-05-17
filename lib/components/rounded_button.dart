import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.title, @required this.onPressed});
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      padding: EdgeInsets.symmetric(
          horizontal: screen.width * 0.2, vertical: screen.height * 0.025),
      color: kPrimaryColor,
      onPressed: this.onPressed,
      child: Text(
        this.title,
        style: TextStyle(
            fontSize: screen.height * 0.025,
            fontWeight: FontWeight.w800,
            color: Colors.white),
      ),
    );
  }
}
