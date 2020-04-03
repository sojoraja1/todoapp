import 'package:intl/intl.dart';


String dateformat(){


  var now = DateTime.now();

  var format = DateFormat("EEE,MMM d,''yy");
  String formatter = format.format(now);

  return formatter;
}