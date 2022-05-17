import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/utils/load_screen_lag_fix.dart';
import 'package:fc_times/screens/welcome_screen.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoadingScreen extends StatefulWidget {
  static const name = 'loading_screen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _firstRun;
  double _opc = 0.0;

  void changeOpc() {
    setState(() {
      this._opc = 1.0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeOpc());
    checkFirstRun();
  }

  void checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = (prefs.getBool('first_run')) ?? true;
    setState(() {
      this._firstRun = isFirstRun;
    });
  }

  toWelcomeScreen() {
    Navigator.popAndPushNamed(context, WelcomeScreen.name);
  }

  toTimetableScreen() async {
    var page = await buildTimeTableAsync();
    var route = MaterialPageRoute(builder: (_) => page);
    Navigator.pushReplacement(context, route);
  }

  @override
  void dispose() {
    if (!_firstRun)
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    SystemChrome.setEnabledSystemUIOverlays([]);
    return GestureDetector(
      onTap: () {
        if (_firstRun != null) {
          if (_firstRun)
            toWelcomeScreen();
          else
            toTimetableScreen();
        }
      },
      child: Scaffold(
        backgroundColor: kCardColorDark,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screen.width * 0.6,
                    height: screen.width * 0.6,
                    child: FlareActor(
                      'assets/flares/rajagate.flr',
                      animation: 'rajagate',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    kAppName,
                    style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: screen.height * 0.028),
                  ),
                ],
              ),
              (_firstRun == null)
                  ? SpinKitDualRing(
                      color: kPrimaryColor,
                      size: kLoadingIconSize,
                    )
                  : SpinKitRipple(
                      color: kPrimaryColor,
                      size: screen.width * 0.15,
                    ),
              AnimatedOpacity(
                curve: Curves.easeInQuint,
                duration: const Duration(seconds: 4),
                opacity: _opc,
                child: Text('Tap to continue'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
