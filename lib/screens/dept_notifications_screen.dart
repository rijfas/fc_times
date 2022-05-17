import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/components/error_display.dart';
import 'package:fc_times/utils/launch_if_can.dart';
import 'package:fc_times/components/rounded_number.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class DeptNotificationsScreen extends StatefulWidget {
  static const name = 'dept_notifications_screen';
  @override
  _DeptNotificationsScreenState createState() =>
      _DeptNotificationsScreenState();
}

Future<http.Response> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String dept = prefs.getString('selected_dept_name');
  http.Response response =
      await http.get('${kDataUrl}dept_notifications/$dept.json');
  return response;
}

class _DeptNotificationsScreenState extends State<DeptNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dept. Notifications'),
      ),
      body: FutureBuilder(
          future: getData(),
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
                              trailing: (decoded['data'][i]['isLink'])
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.open_in_new,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () async {
                                        launchIfCan(decoded['data'][i]['link']);
                                      })
                                  : Container(),
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
                  } else if (snapshot.data.statusCode == 404) {
                    return Container(
                      child: Center(
                        child: Text('Your dept. is not registered'),
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
