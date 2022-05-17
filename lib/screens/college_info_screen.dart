import 'package:flutter/material.dart';

import 'package:fc_times/components/useful_link_tile.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/utils/launch_if_can.dart';

class CollegeInfoScreen extends StatelessWidget {
  static const name = 'college_info_screen';
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('College Info'),
      ),
      body: Container(
        padding: EdgeInsets.all(screen.width * 0.025),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UsefulLinkTile(
                title: 'College Website',
                subtitle: 'goto farookcollege website',
                iconData: Icons.account_balance,
                url: 'https://farookcollege.ac.in',
              ),
              Divider(),
              UsefulLinkTile(
                iconData: Icons.school,
                title: 'Examinations',
                subtitle: 'goto fcexams website',
                url: 'https://fcexams.in',
              ),
              Divider(),
              UsefulLinkTile(
                iconData: Icons.account_box,
                title: 'Student login',
                subtitle: 'student login in fcexams',
                url: 'https://fcexams.in/studenthome.php',
              ),
              Divider(),
              UsefulLinkTile(
                iconData: Icons.notifications,
                title: 'Exam notifications',
                subtitle: 'SEE exam noifications and timetables',
                url: 'https://fcexams.in/examinationtimetable.php',
              ),
              Divider(),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/emblem.jpeg'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Farook College',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        '(Autonomous)',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'FAROOK COLLEGE PO\nKOZHIKODE - 673 632',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () => launchIfCan('tel:04952440660'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            SizedBox(width: 10.0),
                            Text('0495-2440660')
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () =>
                            launchIfCan('mailto:mail@farookcollege.ac.in'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              color: kPrimaryColor,
                            ),
                            SizedBox(width: 10.0),
                            Text('mail@farookcollege.ac.in')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
