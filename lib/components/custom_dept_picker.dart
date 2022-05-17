import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/utils/get_sem.dart';

class CustomDeptPicker extends StatefulWidget {
  CustomDeptPicker({
    @required this.selectedDept,
    @required this.data,
    @required this.deptCallback,
  });
  final List<String> data;
  final int selectedDept;
  final Function deptCallback;
  @override
  _CustomDeptPickerState createState() => _CustomDeptPickerState();
}

class _CustomDeptPickerState extends State<CustomDeptPicker> {
  int selectedRadio;

  void changeSelection(int val) {
    setState(() {
      selectedRadio = val;
    });
    widget.deptCallback(val);
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = widget.selectedDept;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.data.length,
          itemBuilder: (context, i) {
            return RadioListTile(
                activeColor: kPrimaryColor,
                title: Text(
                    widget.data[i].substring(0, widget.data[i].length - 1)),
                subtitle: Text(getSem(widget.data[i])),
                value: i,
                groupValue: selectedRadio,
                onChanged: (val) => changeSelection(val));
          }),
    );
  }
}
