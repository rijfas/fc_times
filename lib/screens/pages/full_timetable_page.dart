import 'package:flutter/material.dart';

import 'package:fc_times/constants.dart';
import 'package:fc_times/components/subject_card.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FullTimeTablePage extends StatefulWidget {
  final int currentDay = DateTime.now().weekday;
  @override
  _FullTimeTablePageState createState() => _FullTimeTablePageState();
}

class _FullTimeTablePageState extends State<FullTimeTablePage>
    with AutomaticKeepAliveClientMixin {
  List<List<String>> _data = [];

  Future<List<List<String>>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<String>> data = [];
    for (int i = 0; i < 5; i++) data.add(prefs.getStringList(i.toString()));
    return data;
  }

  @override
  void initState() {
    super.initState();
    getData().then(updateData);
  }

  void updateData(List<List<String>> data) {
    setState(() {
      this._data = data;
    });
  }

  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (this._data.isEmpty)
      return Container();
    else
      return Swiper(
        scrollDirection: Axis.vertical,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height,
        itemCount: 5,
        itemBuilder: (context, i) => SubjectCard(
          day: kDays[i],
          subjects: this._data[i],
          color: ((widget.currentDay - 1) == i)
              ? kPrimaryColor
              : Theme.of(context).cardColor,
          textColor:
              ((widget.currentDay - 1) == i) ? Colors.black87 : Colors.white,
        ),
        layout: SwiperLayout.TINDER,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: kCardColorDark, activeColor: kPrimaryColor)),
      );
  }
}
