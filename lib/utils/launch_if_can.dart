import 'package:url_launcher/url_launcher.dart';

void launchIfCan(String url) async {
  if (await canLaunch(url)) await launch(url);
}
