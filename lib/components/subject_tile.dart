import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';

class SubjectTile extends StatelessWidget {
  SubjectTile({
    @required this.hourId,
    @required this.subject,
    @required this.startTime,
    @required this.isCurrentHour,
  });

  final int hourId;
  final String subject;
  final String startTime;
  final bool isCurrentHour;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[6],
        color: isCurrentHour ? kPrimaryColor : kCardColorDark,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.hourId.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screen.height * 0.025,
                color: isCurrentHour ? Colors.black87 : Colors.white,
              ),
            ),
            Text(this.subject,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screen.height * 0.023,
                  color: isCurrentHour ? Colors.black : Colors.white,
                )),
            Text(this.startTime,
                style: TextStyle(
                  fontSize: screen.height * 0.021,
                  color: isCurrentHour ? Colors.black : Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
