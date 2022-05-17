class Time {
  int hour;
  int minute;
  Time(this.hour, this.minute);

  Time.fromDateTime(DateTime dateTime) {
    this.hour = dateTime.hour;
    this.minute = dateTime.minute;
  }

  Time.now() {
    this.hour = DateTime.now().hour;
    this.minute = DateTime.now().minute;
  }

  Time operator +(Time next) {
    Time result;
    if (this.hour + next.hour < 24) {
      if (this.minute + next.minute < 60) {
        result = Time(this.hour + next.hour, this.minute + next.minute);
      } else {
        result =
            Time(this.hour + next.hour + 1, this.minute + next.minute - 60);
      }
    } else {
      if (this.minute + next.minute < 60) {
        result = Time(this.hour + next.hour - 24, this.minute + next.minute);
      } else {
        result =
            Time(this.hour + next.hour - 23, this.minute + next.minute - 60);
      }
    }

    return result;
  }

  bool operator <=(Time next) {
    if (this.hour < next.hour)
      return true;
    else if (this.hour == next.hour && this.minute < next.minute)
      return true;
    else
      return false;
  }

  bool operator >=(Time next) {
    if (this.hour > next.hour)
      return true;
    else if (this.hour == next.hour && this.minute >= next.minute)
      return true;
    else
      return false;
  }

  @override
  String toString() {
    if (this.minute < 10)
      return '${this.hour.toString()}:0${this.minute.toString()}';
    else
      return '${this.hour.toString()}:${this.minute.toString()}';
  }
}
