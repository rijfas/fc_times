import 'package:fc_times/components/default_rounded_card.dart';
import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/components/contributer_tile.dart';
import 'package:fc_times/utils/launch_if_can.dart';

class CreditsScreen extends StatelessWidget {
  static const name = 'credits_screen';
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: ListTileTheme(
        iconColor: Colors.grey[300],
        child: ListView(
          children: <Widget>[
            DefaultRoundedCard(
              screen: screen,
              child: Padding(
                padding: EdgeInsets.all(screen.width * 0.05),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person_pin,
                      size: screen.width * 0.3,
                      color: kPrimaryColor,
                    ),
                    Text(
                      'Developed By Rijfas',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text('Bsc. Computer Science 2019 - 22'),
                    SizedBox(height: 10.0),
                    Text('Farook College(Autonomous)'),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () => launchIfCan('https://wa.me/919447931967'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 10.0),
                          Text('+919447931967')
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () => launchIfCan('mailto:rijfas01@gmail.com'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mail,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 10.0),
                          Text('rijfas01@gmail.com')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.developer_mode,
                color: kPrimaryColor,
              ),
              title: Text(
                'Beta Testers',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ContributerTile(
              name: 'Adil Ayyoob',
            ),
            ContributerTile(
              name: 'Harshal Babu',
            ),
            ContributerTile(
              name: 'Unnikrishnan',
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.equalizer,
                color: kPrimaryColor,
              ),
              title: Text(
                'External analysis',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ContributerTile(
              name: 'Faiz Arif',
            ),
            ContributerTile(
              name: 'Junaid',
            ),
            ContributerTile(
              name: 'Harikrishnan',
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
