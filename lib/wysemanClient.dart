import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:http/http.dart' as http;

class WysmenCredential {
  String host;
  int port;
  String token;
  String key;
  int keyLength;
}

class Client {
  String host;
  int port;
  int keyLength;
  File ca;
  IOWebSocketChannel ws;

  void connect(WysmenCredential credential, var openCB) {
    print('connect called');
    this.host = credential.host;
    this.port = credential.port;
    String token = credential.token;
    String key = credential.key;
    int keyLength = credential.keyLength != null ? credential.keyLength : 2048;
    var rand = new Random();

    if (token != null) {
      print('has token');
      final keyGen = RSAKeyGenerator();

      var secureRandom = new FortunaRandom();
      var random = new Random.secure();

      List<int> seeds = [];
      for (int i = 0; i < 32; i++) {
        seeds.add(random.nextInt(255));
      }

      secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));

      keyGen.init(ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.parse('65537'), keyLength, 64),
          secureRandom));

      var keyPair = keyGen.generateKeyPair();

      print('key pairs genereated');
      String authString =
          'token=' + token + '&pub=' + keyPair.publicKey.toString();
    } else if (key != null) {
      //implement later
    } else {
      //throw error
    }

    String origin = "https://" + this.host + ":" + this.port.toString();
    String endpoint = "/clientinfo";

    print('making call to ${origin + endpoint}');
    HttpClient client = new HttpClient();
    try {
      client
          .getUrl(Uri.parse(origin + endpoint))
          .then((HttpClientRequest request) {
        request.headers.add('user-agent', 'Wyseman Websocket Client API');
        request.headers.add('cookie', rand.nextInt(99999).toString());
        print('headers set');
        print(request.headers);
        return request.close();
      }).then((HttpClientResponse response) {
        print('received response');
        print(response);
      });
    } catch (error) {
      print('there was an error');
      print(error);
    }
  }
}
