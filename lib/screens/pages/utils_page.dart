import 'package:flutter/material.dart';

import 'package:fc_times/screens/assignments_screen.dart';
import 'package:fc_times/screens/college_info_screen.dart';
import 'package:fc_times/screens/dept_notifications_screen.dart';
import 'package:fc_times/screens/exam_notifications_screen.dart';
import 'package:fc_times/screens/room_finder_screen.dart';
import 'package:fc_times/screens/od_marker_screen.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/components/notification_card_row.dart';
import 'package:fc_times/components/utils_icon.dart';

class UtilsPage extends StatefulWidget {
  @override
  _UtilsPageState createState() => _UtilsPageState();
}

class _UtilsPageState extends State<UtilsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size screen = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: NotificationCardRow(screen: screen),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListTileTheme(
                      iconColor: kPrimaryColor,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.verified_user,
                                    title: 'OD Marker',
                                    onTap: () => Navigator.pushNamed(
                                        context, OdMarkerScreen.name),
                                  ),
                                ),
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.edit,
                                    title: 'Assignments',
                                    onTap: () => Navigator.pushNamed(
                                        context, AssignmentsScreen.name),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.description,
                                    title: 'Exams',
                                    onTap: () => Navigator.pushNamed(
                                        context, ExamNotificationsScreen.name),
                                  ),
                                ),
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.school,
                                    title: 'Dept. Notifications',
                                    onTap: () => Navigator.pushNamed(
                                        context, DeptNotificationsScreen.name),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.room,
                                    title: 'Room Locater',
                                    onTap: () => Navigator.pushNamed(
                                        context, RoomFinderScreen.name),
                                  ),
                                ),
                                Expanded(
                                  child: UtilsIcon(
                                    screen: screen,
                                    icon: Icons.info,
                                    title: 'College Info',
                                    onTap: () => Navigator.pushNamed(
                                        context, CollegeInfoScreen.name),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
