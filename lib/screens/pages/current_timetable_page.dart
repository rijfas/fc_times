import 'package:flutter/material.dart';

import 'package:fc_times/components/subject_tile.dart';
import 'package:fc_times/models/fc_timetable_structure.dart';
import 'package:fc_times/utils/load_string_list.dart';
import 'package:fc_times/components/expandable_notification_card.dart';

class CurrentTimetablePage extends StatefulWidget {
  final DateTime currentDay = DateTime.now();
  @override
  _CurrentTimetablePageState createState() => _CurrentTimetablePageState();
}

class _CurrentTimetablePageState extends State<CurrentTimetablePage>
    with AutomaticKeepAliveClientMixin {
  List<String> _data = [];
  @override
  void initState() {
    super.initState();
    loadStringList('${widget.currentDay.weekday - 1}').then(updateData);
  }

  void updateData(List<String> data) {
    setState(() {
      this._data = data;
    });
  }

  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size screen = MediaQuery.of(context).size;
    if (widget.currentDay.weekday < 6)
      return Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ExpandableNotificationCard(
                    screen: screen,
                    currentDay: widget.currentDay,
                  ),
                  SizedBox(
                    height: screen.height * 0.05,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        if (this._data.isEmpty) {
                          return Center(child: Container());
                        } else {
                          return SubjectTile(
                            hourId: i + 1,
                            subject: this._data[i],
                            startTime: getStartTime(i),
                            isCurrentHour: isCurrentHour(i),
                          );
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      );
    else
      return Center(
        child: Container(
            child: Image.asset(
          'assets/images/holiday.png',
          fit: BoxFit.fitHeight,
          width: screen.width * 0.4,
          height: screen.width * 0.4,
        )),
      );
  }
}
