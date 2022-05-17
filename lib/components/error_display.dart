import 'package:flutter/material.dart';
import 'package:fc_times/constants.dart';

class ErrorDisplay extends StatelessWidget {
  ErrorDisplay({
    @required this.screen,
    this.logoSize = 0.1,
    this.spacing = 0.05,
  });
  final Size screen;

  final double logoSize;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.cloud_off,
            color: Colors.grey,
            size: screen.height * logoSize,
          ),
          SizedBox(
            height: screen.height * spacing,
          ),
          Text(
            'Oops!',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey),
          ),
          SizedBox(
            height: screen.height * 0.025,
          ),
          Text(
            'Check your network connection and try again',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: screen.height * 0.025,
          ),
          Text(
            'Retry',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
