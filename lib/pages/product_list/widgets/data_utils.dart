import 'package:intl/intl.dart';

class DataUtils {
  static final oCcy = NumberFormat('#,###', 'ko_KR'); //intl
  static String calcToWon(int price) {
    return "${oCcy.format(price)}원";
  }
}
