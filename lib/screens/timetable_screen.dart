import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fc_times/components/logo_icon.dart';
import 'package:fc_times/screens/pages/current_timetable_page.dart';
import 'package:fc_times/screens/pages/full_timetable_page.dart';
import 'package:fc_times/screens/pages/utils_page.dart';
import 'package:fc_times/screens/pages/settings_page.dart';
import 'package:fc_times/constants.dart';

class TimeTableScreen extends StatefulWidget {
  static const name = 'timetable_page';

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  List<Widget> _pages = [
    CurrentTimetablePage(),
    FullTimeTablePage(),
    UtilsPage(),
    SettingsPage(),
  ];
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoIcon(),
            Text(
              kAppName,
              style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: screen.height * 0.025),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        animationDuration: const Duration(milliseconds: 150),
        color: kPrimaryColor,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: kPrimaryColor,
        height: MediaQuery.of(context).size.height * 0.08,
        items: [
          Icon(Icons.home),
          Icon(Icons.book),
          Icon(Icons.dashboard),
          Icon(Icons.settings)
        ],
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
