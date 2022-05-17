import 'package:flutter/material.dart';
import 'package:fc_times/constants.dart';

class DefaultRoundedCard extends StatelessWidget {
  DefaultRoundedCard({@required this.child, @required this.screen});
  final Widget child;
  final Size screen;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      margin: EdgeInsets.all(screen.width * 0.025),
      color: kCardColorDark,
      child: child,
    );
  }
}
