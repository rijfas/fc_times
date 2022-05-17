import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:fc_times/components/rounded_button.dart';
import 'package:fc_times/screens/dept_select_screen.dart';
import 'package:fc_times/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const name = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: screen.width,
            height: screen.height,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(screen.height * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          kAppName.toUpperCase(),
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screen.height * 0.05),
                        ),
                      ),
                      Text(
                        'Farook College Timetable',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        FadeAnimatedTextKit(
                            totalRepeatCount: 2,
                            repeatForever: false,
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screen.height * 0.05,
                            ),
                            text: [
                              'TIMETABLE',
                              'NOTIFICATIONS',
                              'OD MARKER',
                              'ASSIGNMENTS',
                              'EXAMS',
                              'AND MORE...!',
                            ])
                      ],
                    ),
                  ),
                  Center(
                    child: RoundedButton(
                        title: 'Get Started',
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, DeptSelectScreen.name);
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
