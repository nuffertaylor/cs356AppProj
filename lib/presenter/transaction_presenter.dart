import 'package:flutter_app/DAOs/transaction_dao.dart';
import 'package:flutter_app/objects/singletons.dart';
import 'package:flutter_app/objects/wallet.dart';

class TransactionPresenter {

  var dao = new TransactionDao();
  List<Wallet> walletList = UserWallets().walletList;

  bool sendPayment(transaction) {
    print(transaction);
    dao.sendPayment(transaction);
    return true;
  }

  bool requestPayment(transaction) {
    print(transaction);
    dao.requestPayment(transaction);
    return false;
  }

  bool declinePayment(transaction) {
    dao.declineTransaction(transaction);
    return true;
  }

  bool cancelRequest(transaction) {
    dao.cancelRequest(transaction);
    return true;
  }

  List<String> getWalletList() {
    List<String> wallets = [];
    walletList.forEach((element) {wallets.add(element.name);});
    return wallets;
  }

}