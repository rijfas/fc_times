import 'package:fc_times/screens/exam_notifications_screen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fc_times/utils/check_plural.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/screens/assignments_screen.dart';
import 'package:fc_times/screens/dept_notifications_screen.dart';
import 'package:fc_times/utils/load_string_list.dart';

enum RemoteNotificationType { important, department, exam }
enum LocalNotificationType { assignment }
Future<List<Widget>> getNotifications(
    BuildContext context, bool notificationsVisibility) async {
  List<Widget> notifications = <Widget>[
    await getLocalNotification(LocalNotificationType.assignment, context),
    await getRemoteNotification(RemoteNotificationType.department, context),
    await getRemoteNotification(RemoteNotificationType.exam, context),
    await getRemoteNotification(RemoteNotificationType.important, context),
  ];
  while (notifications.indexOf(null) != -1) {
    notifications.remove(null);
  }

  if (notifications.length == 0)
    notifications.add(Text('No new notifications'));
  return notifications;
}

Future<Widget> getRemoteNotification(
    RemoteNotificationType remoteNotificationType, BuildContext context) async {
  switch (remoteNotificationType) {
    case RemoteNotificationType.department:
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String dept = prefs.getString('selected_dept_name');
      try {
        http.Response response =
            await http.get('${kDataUrl}dept_notifications/$dept.json');
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.body);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${decoded['length']} notification${checkPlural(decoded['length'])} from your department'),
              IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: kPrimaryColor,
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, DeptNotificationsScreen.name))
            ],
          );
        }
      } catch (e) {}
      break;
    case RemoteNotificationType.important:
      try {
        http.Response response =
            await http.get('${kDataUrl}important_notification.json');
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.body);
          if (decoded['show'])
            return Text(
              decoded['data'],
              style: TextStyle(color: Colors.red),
            );
        }
      } catch (e) {}
      break;
    case RemoteNotificationType.exam:
      try {
        http.Response response =
            await http.get('${kDataUrl}exam_notifications.json');
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.body);
          if (decoded['length'] > 0)
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${decoded['length']} exam notification${checkPlural(decoded['length'])}'),
                IconButton(
                    icon: Icon(
                      Icons.open_in_new,
                      color: kPrimaryColor,
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, ExamNotificationsScreen.name))
              ],
            );
        }
      } catch (e) {}
      break;
  }
  return null;
}

Future<Widget> getLocalNotification(
    LocalNotificationType localNotificationType, BuildContext context) async {
  switch (localNotificationType) {
    case LocalNotificationType.assignment:
      int assignments =
          await loadStringList('assignment_data').then((value) => value.length);
      assignments ??= 0;
      if (assignments > 0)
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (Text(
                '$assignments assignment${checkPlural(assignments)} pending')),
            IconButton(
                icon: Icon(
                  Icons.open_in_new,
                  color: kPrimaryColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AssignmentsScreen.name))
          ],
        );
  }
  return null;
}
