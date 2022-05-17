import 'package:fc_times/components/default_rounded_card.dart';
import 'package:fc_times/components/error_display.dart';
import 'package:fc_times/utils/launch_if_can.dart';
import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'dart:convert';

class NotificationCardRow extends StatefulWidget {
  const NotificationCardRow({
    @required this.screen,
  });

  final Size screen;

  @override
  _NotificationCardRowState createState() => _NotificationCardRowState();
}

class _NotificationCardRowState extends State<NotificationCardRow> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get('${kDataUrl}notifications.json'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return DefaultRoundedCard(
                screen: widget.screen,
                child: Center(
                  child: SpinKitFadingCircle(
                    color: kPrimaryColor,
                    size: kLoadingIconSize,
                  ),
                ),
              );
              break;
            default:
              if (snapshot.hasError)
                return GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: DefaultRoundedCard(
                    screen: widget.screen,
                    child: ErrorDisplay(
                      screen: widget.screen,
                      logoSize: 0.03,
                      spacing: 0.01,
                    ),
                  ),
                );
              else {
                var decoded = jsonDecode(snapshot.data.body);
                return Swiper(
                  viewportFraction: 0.8,
                  autoplayDisableOnInteraction: true,
                  itemBuilder: (context, i) => DefaultRoundedCard(
                    screen: widget.screen,
                    child: RawMaterialButton(
                      splashColor: (decoded['data'][i]['isLink'])
                          ? Theme.of(context).splashColor
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () async {
                        if (decoded['data'][i]['isLink'])
                          launchIfCan(decoded['data'][i]['link']);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    decoded['data'][i]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: kDefaultFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.screen.height * 0.03,
                                    ),
                                  ),
                                ),
                                Divider(),
                                Center(
                                  child: Text(
                                    decoded['data'][i]['body'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: kDefaultFontFamily,
                                      fontSize: widget.screen.height * 0.02,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: decoded['length'],
                  autoplay: true,
                );
              }
          }
        });
  }
}
