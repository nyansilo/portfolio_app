import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Tools {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static List<Color> multiColors = [
    Colors.purple,
    Colors.amber,
    Colors.green,
    Colors.blue,
  ];

}

String dateFormatter(String dateString){

  var parsedDate = DateTime.parse(dateString);

  final formattedDate = formatDate(parsedDate, [dd, ' ', M, ' ', yyyy, ' ', HH, ':', nn]);

  return formattedDate;

}