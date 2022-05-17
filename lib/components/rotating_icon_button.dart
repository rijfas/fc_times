import 'package:flutter/material.dart';
import 'package:fc_times/constants.dart';

class RotatingIconButton extends StatelessWidget {
  RotatingIconButton({
    @required this.screen,
    @required this.onTap,
    @required this.isExpanded,
  });
  final Size screen;
  final Function onTap;
  final List<IconData> icons = [Icons.expand_more, Icons.expand_less];
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      icon: Icon(
        icons[isExpanded ? (1) : 0],
        size: screen.height * 0.05,
        color: kPrimaryColor,
      ),
    );
  }
}
