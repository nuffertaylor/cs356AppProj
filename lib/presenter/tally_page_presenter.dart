import 'package:flutter_app/DAOs/tally_page_dao.dart';
import 'package:flutter_app/objects/transaction.dart';
import 'dart:math';


class TallyPagePresenter {
  var dao = new TallyPageDao();

  List<Transaction> getUserTransactions([Transaction lastTransaction, int numToFetch = 10]) {
    return dao.getUserTransactions(lastTransaction, numToFetch);
  }

  String getRandomTransactionVal() {
    var rand = new Random();
    int num = rand.nextInt(3);
    switch(num) {
      case 0:
        return "BCH";
      case 1:
        return "ETH";
      case 2:
        return "BTC";
      case 3:
      default:
        return "XMR";
    }
  }
}