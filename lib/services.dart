import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/objects/account.dart';
import 'package:flutter_app/wysemanClient.dart';

class Services {
  //Tally functions
  static Future<int> getUserTallies(var userId) async {
    Future f = Future.delayed(const Duration(milliseconds: 120), () {
      print('returning 10');
      return 10;
    });
    return f;
  }

  static Future<int> createNewTally(var tally) async {
    Future f = Future.delayed(const Duration(microseconds: 90), () {
      return 0;
    });
    return f;
  }

  // send 0 to deny, 1 to accept
  static Future<int> respondToTally(int response) async {
    Future f = Future.delayed(const Duration(microseconds: 90), () {
      return 0;
    });
    return f;
  }

  //User functions
  static Future<Account> getUserData(var userId) async {
    Future f = Future.delayed(const Duration(microseconds: 120), () {
      return new Account('John Doe', 'John', 'Doe', 'JohnDoe@gmail.com');
    });
    return f;
  }

  static void connectToServer() {}

  static void apiCall() {
    String ticket =
        '{"token":"44a90116f65684b038818dbaae819cb1","expires":"2021-04-08T22:53:57.000Z","host":"mychips0","port":54320}';

    Map<String, dynamic> data = jsonDecode(ticket);
    print(data['host']);
    Client c = new Client();
    WysemanCredential cred = new WysemanCredential();
    cred.host = '54.203.5.62';
    cred.port = 8000;
    cred.token = data['token'];

    c.connect(cred, null);
  }
}
