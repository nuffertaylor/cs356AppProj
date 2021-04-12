import 'dart:math';

class DebitsCredits {
  double getUserBalance() {
    var rng = new Random();
    return roundDouble(rng.nextInt(200) + rng.nextDouble(), 2);
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  //@return list with three entries, 1 is positive debits, 2 is negative credits, and 3 is neutral
  Map<String, double> getUserDebitsCredits()
  {
  //TODO: dynamic info here:
  //return the top four weightiest tally relationships
  //find this by summing up all transactions in all tally relationships (after a lift) and take absolute value
  //put the fifth in a separate other category with a neutral color to represent all other tallies
    return {
      "(D) House Mortgage": 1,
      "(D) Company Investments": 1,
      "(C) MyCHIPs Software Developer": 2,
      "(C) T-Shirt Sales": 1,
    };
  }
}