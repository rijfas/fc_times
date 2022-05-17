import 'package:fc_times/utils/launch_if_can.dart';
import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';

class UsefulLinkTile extends StatelessWidget {
  UsefulLinkTile({
    @required this.title,
    @required this.subtitle,
    @required this.iconData,
    @required this.url,
  });
  final String title;
  final String subtitle;
  final IconData iconData;
  final String url;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, color: kPrimaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
      onTap: () => launchIfCan(url),
    );
  }
}
