import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({this.day, this.subjects, this.color, this.textColor});
  final String day;
  final List<String> subjects;
  final Color color;
  final Color textColor;

  List<Widget> subjectText(String day, List<String> subjects) {
    List<Widget> display = [
      Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          day,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: textColor),
        ),
      ),
      SizedBox(height: 40.0),
    ];
    for (int i = 0; i < 5; i++) {
      display.add(Divider(
        height: 30.0,
      ));
      display.add(
        Text(subjects[i],
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: textColor)),
      );
    }
    display.add(Divider(
      height: 30.0,
    ));
    return display;
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: Card(
              color: color,
              elevation: 6.0,
              margin: EdgeInsets.symmetric(
                  vertical: screen.height * 0.04,
                  horizontal: screen.width * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: this.subjectText(day, subjects),
              ))),
        ),
      ],
    );
  }
}
