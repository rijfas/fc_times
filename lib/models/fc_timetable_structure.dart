import 'package:fc_times/models/time_structure_core.dart';
import 'package:fc_times/models/time_core.dart';

TimeStructure fcDefault = TimeStructure(
    startTime: Time(8, 30), hourDuration: Time(1, 0), numberOfHours: 5);
TimeStructure fcFriday = TimeStructure(
    startTime: Time(8, 30), hourDuration: Time(0, 50), numberOfHours: 5);

String getStartTime(int hour) {
  int currentDay = DateTime.now().weekday;
  if (currentDay < 5)
    return fcDefault.getHourStartTime(hour);
  else
    return fcFriday.getHourStartTime(hour);
}

bool isCurrentHour(int hour) {
  int currentDay = DateTime.now().weekday;
  if (currentDay < 5)
    return fcDefault.isCurrentHour(hour);
  else
    return fcFriday.isCurrentHour(hour);
}
