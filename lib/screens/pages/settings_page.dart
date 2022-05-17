import 'package:flutter/material.dart';

import 'package:fc_times/components/default_rounded_card.dart';
import 'package:fc_times/components/logo_icon.dart';
import 'package:fc_times/screens/credits_screen.dart';

import 'package:fc_times/utils/launch_if_can.dart';

import 'package:fc_times/screens/dept_select_screen.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/components/custom_dialogs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
      child: DefaultRoundedCard(
        screen: screen,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: ListTileTheme(
              iconColor: kPrimaryColor,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.add_circle,
                    ),
                    title: Text('Add Department'),
                    subtitle: Text(
                        'add or request change in your department timetable'),
                    onTap: () => launchIfCan(kTimetableUrl),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.swap_horizontal_circle,
                    ),
                    title: Text('Change Department'),
                    subtitle: Text('select from available departments'),
                    onTap: () {
                      Navigator.pushNamed(context, DeptSelectScreen.name);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.cloud_download,
                    ),
                    title: Text('Check For Updates'),
                    subtitle: Text('current version : $kAppVersion'),
                    onTap: () async {
                      try {
                        showCustomLoading(context);
                        http.Response response =
                            await http.get('${kDataUrl}current_version.json');
                        if (response.statusCode == 200) {
                          var decoded = jsonDecode(response.body);
                          Map<String, String> decodedMap =
                              Map<String, String>.from(decoded);
                          String latestVersion = decodedMap.keys.toList()[0];
                          closeLastDialog(context);
                          if (latestVersion != kAppVersion) {
                            Alert(
                                style: AlertStyle(
                                    alertBorder: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    isCloseButton: false,
                                    backgroundColor: kCardColorDark,
                                    titleStyle: TextStyle(color: Colors.white),
                                    descStyle: TextStyle(color: Colors.white)),
                                context: context,
                                title: 'New Update Available',
                                buttons: [
                                  DialogButton(
                                      color: kPrimaryColor,
                                      child: Text(
                                        'Download',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      onPressed: () async {
                                        await launch(decoded[latestVersion]);
                                      }),
                                  DialogButton(
                                      color: kPrimaryColor,
                                      child: Text(
                                        'Later',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ]).show();
                          } else {
                            showCustomDialog(
                                context, 'No updates are available');
                          }
                        } else {
                          closeLastDialog(context);
                          showCustomDialog(
                              context, 'Network Error ${response.statusCode}');
                        }
                      } catch (e) {
                        closeLastDialog(context);
                        showCustomError(context, 'Network Error');
                      }
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.bug_report,
                    ),
                    title: Text('Report Bug'),
                    subtitle: Text('report bugs '),
                    onTap: () => launchIfCan(
                        'mailto:$kFeedbackMail?subject=FC%20TIMES%20Feedback%20Version%20$kAppVersion'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                    ),
                    title: Text('Credits'),
                    subtitle: Text('credits and acknowledgments'),
                    onTap: () {
                      Navigator.pushNamed(context, CreditsScreen.name);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.help,
                    ),
                    title: Text('About Us'),
                    subtitle: Text('about and licenses'),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationName: kAppName,
                          applicationVersion: kAppVersion,
                          applicationIcon: LogoIcon(),
                          applicationLegalese: '2020 © rijfas');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
