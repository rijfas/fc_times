import 'package:flutter/material.dart';
import 'package:fc_times/screens/timetable_screen.dart';

Future<Widget> buildTimeTableAsync() async {
  return Future.microtask(() {
    return TimeTableScreen();
  });
}
