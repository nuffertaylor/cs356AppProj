import 'package:flutter_app/objects/debits_credits.dart';
import 'package:random_color/random_color.dart';
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

  List<Map<String, double>> getUserPieChart() {
    return dc.getUserDebitsCredits();
  }

  List<Color> getPieChartColors(listOfDataMap) {
    RandomColor rc = RandomColor();
    List<Color> colorList = [];

    for (int i = 0; i < listOfDataMap.length; i++)
      for (int j = 0; j < listOfDataMap[j]; j++)
        if(i == 0)
          colorList.add(getRandomColor(positiveColors));
        else if (i == 1)
          colorList.add(getRandomColor(negativeColors));
        else if (i == 2)
          colorList.add(getRandomColor(neutralColors));
        else
          throw Exception("list of data was longer than expected");
    return colorList;
  }

  Color getRandomColor(list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}