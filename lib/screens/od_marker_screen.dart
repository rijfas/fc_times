import 'package:flutter/material.dart';

import 'package:fc_times/components/custom_dialogs.dart';
import 'package:fc_times/utils/load_string_list.dart';
import 'package:fc_times/constants.dart';
import 'package:fc_times/utils/get_hour.dart';
import 'package:fc_times/components/rounded_number.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OdMarkerScreen extends StatefulWidget {
  static final name = 'od_marker_screen';

  @override
  _OdMarkerScreenState createState() => _OdMarkerScreenState();
}

class _OdMarkerScreenState extends State<OdMarkerScreen> {
  List<String> _data = [];

  void updateData(List<String> data) async {
    setState(() {
      this._data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadStringList('od_data').then((value) => updateData(value));
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('OD Marker'),
        actions: <Widget>[
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onSelected: (_) => showCustomWarning(
                  context: context,
                  title: 'Clear OD records?',
                  content: 'This will clear all OD records',
                  onOkPressed: () async {
                    setState(
                      () {
                        _data.clear();
                      },
                    );
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs
                        .remove('od_data')
                        .then((value) => Navigator.pop(context));
                  },
                  onCancelPressed: () {
                    Navigator.pop(context);
                  }),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: Center(
                          child: Text(
                            'Clear OD records',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                  ])
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: (_data ?? []).length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: RoundedNumber(
                screen: screen,
                number: i,
              ),
              title: Text(_data[i].split(',')[1]),
              subtitle: Text(
                  '${DateTime.parse(_data[i].split(',')[0]).day}, ${kMonths[DateTime.parse(_data[i].split(',')[0]).month - 1]} ${DateTime.parse(_data[i].split(',')[0]).year}'),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onTap: () => showCustomWarning(
                    context: context,
                    onOkPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        _data.remove(_data[i]);
                      });
                      prefs
                          .setStringList('od_data', _data)
                          .then((value) => Navigator.pop(context));
                    },
                    onCancelPressed: () => Navigator.pop(context),
                    title: 'Delete OD record?',
                    content:
                        '${_data[i].split(' ')[0].split(',')[0]} ${_data[i].split(',')[1]}'),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime pickedDate;
          int hour;
          pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2030),
          );
          if (pickedDate != null &&
              (pickedDate.weekday == 6 || pickedDate.weekday == 7))
            showCustomError(context, 'Not a working day!');
          else if (pickedDate != null) {
            hour = await showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                backgroundColor: kCardColorDark,
                context: context,
                isDismissible: false,
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                          child: Text('Select Hour',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Expanded(
                          child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, i) => ListTile(
                          onTap: () => Navigator.pop(context, i + 1),
                          leading: Icon(
                            kNumberIcons[i],
                            color: kPrimaryColor,
                          ),
                          title: Text(getHour(i + 1)),
                        ),
                      ))
                    ],
                  );
                });
            String selected = pickedDate.toString().split(' ')[0] +
                ',' +
                kDays[pickedDate.weekday - 1] +
                ' ' +
                getHour(hour);
            if (!_data.contains(selected)) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                if (hour != null && pickedDate != null)
                  this._data.add(selected);
              });
              prefs.setStringList('od_data', _data);
            } else
              showCustomError(context, 'Record Already Exists');
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
