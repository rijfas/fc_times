import 'dart:convert';
import 'package:meta/meta.dart';

class Assignment {
  Assignment.fromJson(String encoded) {
    var decoded = jsonDecode(encoded);
    this.title = decoded['title'];
    this.subTitle = decoded['subTitle'];
    this.dueDate = decoded['dueDate'];
  }
  Assignment({
    @required this.title,
    @required this.subTitle,
    @required this.dueDate,
  });
  String title;
  String subTitle;
  String dueDate;
  String getJson() {
    return jsonEncode({
      'title': this.title,
      'subTitle': this.subTitle,
      'dueDate': this.dueDate,
    });
  }
}
