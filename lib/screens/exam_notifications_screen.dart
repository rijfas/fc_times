import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/components/error_display.dart';
import 'package:fc_times/utils/launch_if_can.dart';
import 'package:fc_times/components/rounded_number.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:convert';

class ExamNotificationsScreen extends StatefulWidget {
  static const name = 'exam_notifications_screen';
  @override
  _ExamNotificationsScreenState createState() =>
      _ExamNotificationsScreenState();
}

class _ExamNotificationsScreenState extends State<ExamNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Notifications'),
      ),
      body: FutureBuilder(
          future: http.get('${kDataUrl}exam_notifications.json'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SpinKitFadingCircle(
                  color: kPrimaryColor,
                  size: kLoadingIconSize,
                );
                break;
              default:
                if (snapshot.hasError)
                  return GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: ErrorDisplay(
                      screen: screen,
                      logoSize: 0.03,
                      spacing: 0.01,
                    ),
                  );
                else {
                  if (snapshot.data.statusCode == 200) {
                    var decoded = jsonDecode(snapshot.data.body);
                    if (decoded['length'] != 0)
                      return ListView.separated(
                          itemBuilder: (context, i) {
                            return ListTile(
                              leading: RoundedNumber(screen: screen, number: i),
                              title: Text(decoded['data'][i]['title']),
                              subtitle: Text(decoded['data'][i]['body']),
                              trailing: Visibility(
                                visible: decoded['data'][i]['isLink'],
                                child: Visibility(
                                  visible: decoded['data'][i]['isLink'],
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.open_in_new,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        if (decoded['data'][i]['isLink'])
                                          launchIfCan(
                                              decoded['data'][i]['link']);
                                      }),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, _) => Divider(),
                          itemCount: decoded['length']);
                    else
                      return Container(
                        child: Center(
                          child: Text('No new notifications'),
                        ),
                      );
                  } else {
                    return Container(
                      child: Center(
                        child: Text('Unknown Error'),
                      ),
                    );
                  }
                }
            }
          }),
    );
  }
}
