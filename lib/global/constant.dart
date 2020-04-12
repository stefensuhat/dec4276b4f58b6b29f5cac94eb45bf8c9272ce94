/*
kulina - constant
created by: stefensuhat at 10 Apr 2020 22.29
*/
import 'package:intl/intl.dart';

const String homePage = '/';
const String cartPage = '/carts';

// default spacing
double spacing(value) => value * 8.0;

String getDate(String format, DateTime value) {
  return DateFormat(format, 'id_ID').format(value);
}
