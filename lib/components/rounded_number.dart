import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';

class RoundedNumber extends StatelessWidget {
  const RoundedNumber({@required this.screen, @required this.number});

  final Size screen;
  final int number;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: screen.height * 0.02,
      backgroundColor: kPrimaryColor,
      child: Text(
        (number + 1).toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
