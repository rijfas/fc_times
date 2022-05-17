String getSem(String sem) {
  String semInt = sem.split(" ").last;
  switch (semInt) {
    case '1':
      return '1st Sem';
      break;
    case '2':
      return '2nd Sem';
      break;
    case '3':
      return '3rd Sem';
      break;
    default:
      return '${semInt}th Sem';
      break;
  }
}
