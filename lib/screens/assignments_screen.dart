import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/components/custom_dialogs.dart';
import 'package:fc_times/models/assignment_core.dart';
import 'package:fc_times/components/rounded_button.dart';
import 'package:fc_times/utils/load_string_list.dart';
import 'package:fc_times/components/rounded_number.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AssignmentsScreen extends StatefulWidget {
  static const name = 'assignments_screen';

  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  List<String> _data = [];

  void updateData(List<String> data) async {
    setState(() {
      this._data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadStringList('assignment_data').then((value) => updateData(value));
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
        actions: [
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () =>
                  showCustomDialog(context, 'Press and hold to delete'))
        ],
      ),
      body: Container(
        child: ListView.separated(
          itemBuilder: (context, i) => GestureDetector(
              onLongPress: () => showCustomWarning(
                    context: context,
                    onOkPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        _data.remove(_data[i]);
                      });
                      prefs
                          .setStringList('assignment_data', _data)
                          .then((value) => Navigator.pop(context));
                    },
                    onCancelPressed: () => Navigator.pop(context),
                    title:
                        'Delete ${Assignment.fromJson(_data[i]).title} Assigment?',
                    content: '${Assignment.fromJson(_data[i]).subTitle}',
                  ),
              child: assignmentTile(screen, Assignment.fromJson(_data[i]), i)),
          separatorBuilder: (context, i) => Divider(),
          itemCount: _data.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String title;
          String subTitle;
          DateTime dueDate;

          dueDate = await showDatePicker(
            context: context,
            helpText: 'Select due date',
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030),
          );
          if (dueDate != null) {
            await showModalBottomSheet(
                backgroundColor: kCardColorDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                isScrollControlled: true,
                isDismissible: false,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                              ),
                              hintText: 'Subject',
                            ),
                            onChanged: (value) => title = value,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                              ),
                              hintText: 'Assignment',
                            ),
                            onChanged: (value) => subTitle = value,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        RoundedButton(
                            title: 'Save',
                            onPressed: () {
                              if (title != null && subTitle != null)
                                Navigator.pop(context);
                            }),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  );
                });
            if (title != null && subTitle != null) {
              Assignment assignment = Assignment(
                title: title,
                subTitle: subTitle,
                dueDate:
                    '${dueDate.day}/${dueDate.month}/${dueDate.year % 2000}',
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                this._data.add(assignment.getJson());
              });
              prefs.setStringList('assignment_data', _data);
            }
          }
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          color: kCardColorDark,
        ),
      ),
    );
  }
}

Widget assignmentTile(Size screen, Assignment assignment, int id) {
  return ListTile(
    leading: RoundedNumber(screen: screen, number: id),
    title: Text(assignment.title),
    subtitle: Text(assignment.subTitle),
    trailing: Text(assignment.dueDate),
  );
}
