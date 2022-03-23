class FormatDate {
  static formatDate(String date) {
    DateTime? datemsg;
    var annee = int.parse(date.substring(0, 4));
    var mois = int.parse(date.substring(5, 7));
    var jour = int.parse(date.substring(8, 10));
    var heur = int.parse(date.substring(11, 13));
    var min = int.parse(date.substring(14, 16));
    var sec = int.parse(date.substring(17, 19));
    datemsg = DateTime(annee, mois, jour, heur, min, sec);
    var datenow = DateTime.now();
    var different = datenow.difference(datemsg);
    if (different.inDays > 8) {
      return min < 9 ? '$heur:0$min' : '$heur:$min';
    } else if ((different.inDays / 7).floor() >= 1) {
      return "1 semaine";
    } else if (different.inDays >= 2) {
      return '${different.inDays} jours';
    } else if (different.inDays >= 1) {
      return 'hier';
    } else if (different.inHours >= 2) {
      return '${different.inHours} heurs';
    } else if (different.inHours >= 1) {
      return '1 heur';
    } else if (different.inMinutes >= 2) {
      return '${different.inMinutes} min';
    } else if (different.inMinutes >= 1) {
      return '1 min';
    } else if (different.inSeconds >= 3) {
      return '${different.inSeconds} sec';
    } else {
      return 'Maintenant';
    }
  }
}
