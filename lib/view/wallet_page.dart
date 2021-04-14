import 'package:flutter/material.dart';
import 'package:flutter_app/view/main_drawer_view.dart';
import 'package:flutter_app/objects/wallet.dart';

class WalletPage extends StatefulWidget {

  @override
  WalletPageState createState() => new WalletPageState();
}

class WalletPageState extends State<WalletPage> {

  List<Wallet> walletList = [Wallet("first wallet", "coinbase", 1364.23, "BTC"), Wallet("doge coin only", "cryptocom", 435.11, "DOGE")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallets")
      ),
      drawer: MainDrawer(),
      body: buildBody()
    );
  }

  Widget buildBody() {
    return Stack(children:[
      buildWallets(),
      buildButton()
    ]);
  }

  Widget buildWallets(){
    return ListView.builder(
        padding:
        const EdgeInsets.only(top: 16, right: 16, bottom: 75, left: 16),
        itemCount: (walletList.length * 2),
        itemBuilder: (context, item) {
          if(item==0)
            return buildRow(walletList[0]);
          if(item.isOdd) return Divider();
          else return buildRow(walletList[item ~/ 2]);
        }
    );

  }

  Widget buildRow(Wallet w){
    return ListTile(
      leading: Image.asset("assets/" + w.source + "Small.png"),
      title: Text(w.name),
      trailing: Text(w.amount.toStringAsFixed(2) + "\t" + w.balanceType),
    );
  }

  Widget buildButton() {
    var maxButtonWidth = (MediaQuery.of(context).size.width) / 1.75;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: MaterialButton(
                onPressed: () {},
                child: const Text("ADD A WALLET",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                color: Colors.white,
                textColor: Theme.of(context).primaryColor,
                elevation: 5,
                height: 50,
                minWidth: maxButtonWidth)));
  }
}
