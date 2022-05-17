import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LogoIcon extends StatelessWidget {
  LogoIcon({this.width = 40.0, this.height = 40.0});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/rajagate_icon.svg',
            width: this.width,
            height: this.height,
          ),
          onPressed: null),
    );
  }
}
