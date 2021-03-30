import 'dart:async';

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

  // return 0 if successful anything else otherwise
  static Future<int> saveNewAccount(Account account) async {
    Future f = Future.delayed(const Duration(microseconds: 120), () {
      return 0;
    });
    return f;
  }

  static void connectToServer() {
    // pass in { host, port, user, token, key }
    // if there is a token create an rsa keypair with that token
    // if there is a key 'Buffer' the key in Hex format - Do we need buffers?
    //    create a key from that buffer in 'der' format
    // else, reject the connection

    // origin = https://host:port - endpoint is userinfo
    // headers = {"user-agent": UserAgent, cookie: Math.random()}
    // fetch(clientUrl, headers)
    //      if we have a key
    //          create a message using info returned
    //          create a 'signer' with SHA256
    //          update signer with message
    //          sign the signer with some crypto stuff
    //          create auth query string
    //      create query string
    //      connect to web socket
    //      create websocket on and error methods
    //
    //      callback of some sort

    //Creating an RSA keypair

    // var buff = new ByteBuffer();

    // var keyParams = new RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);

    // var secureRandom = new FortunaRandom();
    // var random = new Random.secure();

    // List<int> seeds = [];
    // for (int i = 0; i < 32; i++) {
    //   seeds.add(random.nextInt(255));
    // }

    // secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    // var params = new ParametersWithRandom(keyParams, secureRandom);

    // var keyGenerator = new KeyGenerator("RSA");
    // var key = keyGenerator.init(params);

    // //reading in a file
    // var caLocation = 'c://users/2ndteela/downloads/ca.txt';
    // var file = File(caLocation);

    // // connecting to websocket
    // var url = new Uri(host: 'https://54.203.5.62', port: 54320);
    // final channel = IOWebSocketChannel.connect(url);

    // channel.stream.listen((event) {
    //   channel.sink.add('recieved');
    //   channel.sink.close(status.goingAway);
    // });
  }

  static String apiCall() {
    Client c = new Client();
    WysmenCredential cred = new WysmenCredential();
    cred.host = "54.203.5.62";
    cred.port = 54320;
    cred.token = '/keys.json';

    c.connect(cred, null);
  }
}
