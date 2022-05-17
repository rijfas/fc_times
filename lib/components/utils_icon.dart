import 'package:flutter/material.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/components/default_rounded_card.dart';

class UtilsIcon extends StatelessWidget {
  const UtilsIcon({
    @required this.screen,
    @required this.icon,
    @required this.title,
    @required this.onTap,
  });

  final Size screen;
  final IconData icon;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultRoundedCard(
        child: RawMaterialButton(
          onPressed: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(title)
              ],
            ),
          ),
        ),
        screen: screen);
  }
}
