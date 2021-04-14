import 'dart:math';

class DebitsCredits {
  double getUserBalance() {
    return 41.24;
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Map<String, double> getUserDebitsCredits()
  {
    //TODO: fetch data dynamically
    return {
      "BCH": 1,
      "ETH": 1,
      "BTC": 2,
      "XMR": 1,
    };
  }
}