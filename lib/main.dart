import 'package:flutter/material.dart';

import 'package:fc_times/screens/dept_select_screen.dart';
import 'package:fc_times/screens/welcome_screen.dart';
import 'package:fc_times/screens/loading_screen.dart';
import 'package:fc_times/screens/timetable_screen.dart';
import 'package:fc_times/screens/credits_screen.dart';
import 'package:fc_times/screens/od_marker_screen.dart';
import 'package:fc_times/screens/college_info_screen.dart';
import 'package:fc_times/screens/dept_notifications_screen.dart';
import 'package:fc_times/screens/assignments_screen.dart';
import 'package:fc_times/screens/exam_notifications_screen.dart';
import 'package:fc_times/screens/room_finder_screen.dart';
import 'package:fc_times/constants.dart';

import 'package:flutter/services.dart';

void main() => runApp(TimeTableApp());

class TimeTableApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'FC TIMES',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            color: kCardColorDark,
          ),
          scaffoldBackgroundColor: kScaffoldColorDark,
          primaryColor: kScaffoldColorDark,
          cardColor: kCardColorDark,
          iconTheme: IconThemeData(color: kCardColorDark),
          dialogTheme: DialogTheme(
            backgroundColor: kScaffoldColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          colorScheme: ColorScheme.dark(
            onBackground: kCardColorDark,
            primary: kPrimaryColor,
            surface: kPrimaryColor,
          ),
        ),
        initialRoute: LoadingScreen.name,
        routes: {
          LoadingScreen.name: (context) => LoadingScreen(),
          TimeTableScreen.name: (context) => TimeTableScreen(),
          WelcomeScreen.name: (context) => WelcomeScreen(),
          DeptSelectScreen.name: (context) => DeptSelectScreen(),
          OdMarkerScreen.name: (context) => OdMarkerScreen(),
          CreditsScreen.name: (context) => CreditsScreen(),
          CollegeInfoScreen.name: (context) => CollegeInfoScreen(),
          DeptNotificationsScreen.name: (context) => DeptNotificationsScreen(),
          AssignmentsScreen.name: (context) => AssignmentsScreen(),
          ExamNotificationsScreen.name: (context) => ExamNotificationsScreen(),
          RoomFinderScreen.name: (context) => RoomFinderScreen(),
        });
  }
}
