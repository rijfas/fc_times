import 'package:flutter/material.dart';

import 'package:fc_times/components/rotating_icon_button.dart';
import 'package:fc_times/utils/get_notifications.dart';
import 'package:fc_times/constants.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExpandableNotificationCard extends StatefulWidget {
  ExpandableNotificationCard({
    @required this.screen,
    @required this.currentDay,
  });
  final Size screen;
  final DateTime currentDay;
  @override
  _ExpandableNotificationCardState createState() =>
      _ExpandableNotificationCardState();
}

class _ExpandableNotificationCardState
    extends State<ExpandableNotificationCard> {
  bool notificationVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 0.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Today\'s TimeTable',
                style: TextStyle(
                  fontSize: widget.screen.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${kDays[widget.currentDay.weekday - 1]}, ${widget.currentDay.day} ${kMonths[widget.currentDay.month - 1]}',
                style: TextStyle(
                    fontSize: widget.screen.height * 0.025,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(
                height: 10.0,
              ),
              if (notificationVisibility)
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: snapshot.data,
                      );
                    } else
                      return Center(
                        child: SpinKitFadingCircle(
                          color: kPrimaryColor,
                          size: kLoadingIconSize,
                        ),
                      );
                  },
                  future: getNotifications(context, notificationVisibility),
                ),
              Center(
                child: RotatingIconButton(
                    screen: widget.screen,
                    onTap: () {
                      setState(
                        () {
                          (notificationVisibility)
                              ? notificationVisibility = false
                              : notificationVisibility = true;
                        },
                      );
                    },
                    isExpanded: notificationVisibility),
              )
            ],
          ),
        ),
      ),
    );
  }
}
