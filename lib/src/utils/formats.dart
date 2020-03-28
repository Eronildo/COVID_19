import 'package:intl/intl.dart';

class Formats {
  static NumberFormat f = NumberFormat('###,###', 'en_US');
  static DateFormat d = DateFormat.yMd().add_jm();
}