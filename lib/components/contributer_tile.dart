import 'package:flutter/material.dart';

import 'package:fc_times/components/default_rounded_card.dart';

class ContributerTile extends StatelessWidget {
  ContributerTile({this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return DefaultRoundedCard(
      screen: MediaQuery.of(context).size,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.grey,
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('CS 2019-22')
          ],
        ),
      ),
    );
  }
}
