String getHour(int i) {
  switch (i) {
    case 1:
      return '${i}st Hour';
    case 2:
      return '${i}nd Hour';
    case 3:
      return '${i}rd Hour';
    default:
      return '${i}th Hour';
  }
}
