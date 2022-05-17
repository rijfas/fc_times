import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> loadStringList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList(key) ?? <String>[];
  return data;
}
