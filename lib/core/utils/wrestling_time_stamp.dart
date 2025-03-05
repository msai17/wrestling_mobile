import 'package:intl/intl.dart';

class WrestlingTimeStamp {


  static String timeAgo(String dateAdded) {
    DateTime d = DateTime.parse("$dateAdded+09:00");
    Duration diff = DateTime.now().difference(d);
    if (diff.inSeconds < 30) return "только что";
    if (diff.inMinutes == 0) return "${diff.inSeconds} ceк. назад";
    if (diff.inHours == 0) return "${diff.inMinutes} мин. назад";
    if (diff.inDays == 0) return "${diff.inHours} час. назад";
    if (diff.inDays <= 30) return "${diff.inDays} дн. назад";
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(d);
  }

}