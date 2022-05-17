import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:fc_times/screens/timetable_screen.dart';
import 'package:fc_times/components/custom_dept_picker.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/components/custom_dialogs.dart';
import 'package:fc_times/components/error_display.dart';
import 'package:fc_times/components/rounded_button.dart';
import 'package:fc_times/utils/launch_if_can.dart';

class DeptSelectScreen extends StatefulWidget {
  static const name = 'dept_select_screen';

  @override
  _DeptSelectScreenState createState() => _DeptSelectScreenState();
}

class _DeptSelectScreenState extends State<DeptSelectScreen> {
  String selectedDept = "";
  int selectedDeptNumber;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.selectedDeptNumber = prefs.getInt('selected_dept_number') ?? 0;
      showCustomDialog(context, 'Select your department');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onSelected: (_) => launchIfCan(kTimetableUrl),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 1,
                          child: Center(
                            child: Text(
                              'Add your timetable',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                    ])
          ],
          title: Text('Select Your Department'),
        ),
        body: Stack(children: <Widget>[
          FutureBuilder(
              future: http.get("${kDataUrl}departments.json"),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(
                      color: kPrimaryColor,
                      size: kLoadingIconSize,
                    );
                  default:
                    if (snapshot.hasError)
                      return GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: ErrorDisplay(
                          screen: screen,
                        ),
                      );
                    else {
                      var decoded = jsonDecode(snapshot.data.body);
                      this.selectedDept = decoded[decoded.keys.toList()[0]];
                      return CustomDeptPicker(
                        selectedDept: selectedDeptNumber,
                        data: decoded.keys.toList(),
                        deptCallback: (val) {
                          this.selectedDept =
                              decoded[decoded.keys.toList()[val]];
                          this.selectedDeptNumber = val;
                        },
                      );
                    }
                }
              }),
          Positioned(
            right: screen.width * 0.2,
            left: screen.width * 0.2,
            bottom: screen.height * 0.03,
            child: RoundedButton(
                title: 'Save',
                onPressed: () async {
                  if (this.selectedDept.isEmpty)
                    showCustomError(context, 'Select a department');
                  else {
                    try {
                      showCustomLoading(context);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      http.Response response = await http
                          .get("${kDataUrl}timetables/$selectedDept.json");
                      if (response.statusCode == 200) {
                        var decoded = jsonDecode(response.body);
                        for (int i = 0; i < 5; i++) {
                          List<String> current =
                              List<String>.from(decoded[i.toString()]);
                          prefs.setStringList(i.toString(), current);
                          current.clear();
                        }
                        prefs.setString('selected_dept_name',
                            this.selectedDept.replaceFirst(RegExp(r'_\d'), ''));
                        prefs.setInt(
                            'selected_dept_number', this.selectedDeptNumber);
                        prefs.setBool('first_run', false).then((value) =>
                            Navigator.pushNamedAndRemoveUntil(context,
                                TimeTableScreen.name, (route) => false));
                      } else {
                        closeLastDialog(context);
                        showCustomError(
                            context, 'Network Error ${response.statusCode}');
                      }
                    } catch (e) {
                      closeLastDialog(context);
                      showCustomError(context, 'Network Error');
                    }
                  }
                }),
          )
        ]));
  }
}
