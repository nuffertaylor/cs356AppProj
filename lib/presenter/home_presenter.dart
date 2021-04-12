import 'package:flutter_app/objects/debits_credits.dart';
import 'package:flutter/material.dart';
import "dart:math";

class HomePresenter {
  var dc = new DebitsCredits();
  final List<Color> positiveColors = [Color(0xff05386b), Color(0xff379683), Color(0xff5cdb95), Color(0xff8ee4af)];
  final List<Color> negativeColors = [Color(0xfffc4445), Color(0xff8ee4af), Color(0xffedf5e1), Color(0xff950740)];
  final List<Color> neutralColors = [Color(0xffedf5e1)];
  double getUserBalance() {
    return dc.getUserBalance();
  }

  Map<String, double> getUserPieChart() {
    return dc.getUserDebitsCredits();
  }

  List<Color> getPieChartColors(dataMap) {
    List<Color> creditColors = [Color(0xff53ab77), Color(0xff42f593), Color(0xff42f5e6), Color(0xff4293f5), Color(0xffec42f5)];
    List<Color> debitColors = [Color(0xfff3a43e), Color(0xffdaf542), Color(0xfff5da42), Color(0xfff5a442), Color(0xfff56342)];
    int numCredits = 0;
    int numDebits = 0;
    List<Color> colorList = [];
    for (String name in dataMap.keys.toList()) {
      if (name.indexOf('C', 1) == 1) {
        colorList.add(creditColors[numCredits]);
        numCredits = incrementNumber(numCredits);
      }
      else {
        colorList.add(debitColors[numDebits]);
        numDebits = incrementNumber(numDebits);
      }
    }
    return colorList;
  }

  int incrementNumber(int number) {
    if (number >= 5)
      return 0;
    return ++number;
  }

  Color getRandomColor(list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}