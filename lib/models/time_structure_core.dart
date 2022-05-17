import 'package:fc_times/models/time_core.dart';

class Hour {
  Hour(this.startTime, this.endTime);
  Time startTime;
  Time endTime;
}

class TimeStructure {
  int numberOfHours;
  Time startTime;
  Time hourDuration;
  List<Hour> structure;

  TimeStructure({int numberOfHours, Time startTime, Time hourDuration}) {
    this.numberOfHours = numberOfHours;
    this.startTime = startTime;
    this.hourDuration = hourDuration;
    this.structure = [];
    for (int i = 0; i < this.numberOfHours; i++, startTime += hourDuration)
      this.structure.add(Hour(startTime, startTime + hourDuration));
  }

  int getCurrentHour() {
    Time currentTime = Time.now();
    for (int i = 0; i < this.numberOfHours; i++) {
      if (currentTime >= this.structure[i].startTime &&
          currentTime <= this.structure[i].endTime) return i;
    }
    return -1;
  }

  String getHourStartTime(int i) {
    return this.structure[i].startTime.toString();
  }

  bool isCurrentHour(int i) {
    if (this.getCurrentHour() == i)
      return true;
    else
      return false;
  }
}
