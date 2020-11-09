import 'package:intl/intl.dart';

class DateFormatter {
  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = DateTime.now().subtract(
      Duration(minutes: 1),
    );
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Baru Saja';
    }

    String roughTimeString = DateFormat.Hm().format(dateTime);
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    String roughDayString = DateFormat.MMMd().format(dateTime);
    DateTime yesterday = now.subtract(
      Duration(days: 1),
    );
    if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return roughDayString;
    }

    return '${DateFormat.MMMd().format(dateTime)}';
  }
}
