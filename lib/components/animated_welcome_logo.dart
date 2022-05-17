import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AnimatedWelcomeLogo extends StatefulWidget {
  AnimatedWelcomeLogo(
      {@required this.screenWidth, @required this.screenHeight});
  final double screenWidth;
  final double screenHeight;
  @override
  _AnimatedWelcomeLogoState createState() => _AnimatedWelcomeLogoState();
}

class _AnimatedWelcomeLogoState extends State<AnimatedWelcomeLogo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => animate());
  }

  double _width = 0.0;
  double _height = 0.0;
  void animate() {
    setState(() {
      this._width = widget.screenWidth;
      this._height = widget.screenHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: _width,
      height: _height,
      duration: const Duration(milliseconds: 500),
      child: SvgPicture.asset(
        'assets/images/welcome_screen.svg',
        width: widget.screenWidth * 0.8,
        height: widget.screenHeight * 0.6,
      ),
    );
  }
}
