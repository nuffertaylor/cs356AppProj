import 'package:flutter/material.dart';
import 'package:flutter_app/view/main_drawer_view.dart';
import 'package:flutter_app/objects/wallet.dart';
import 'package:flutter_app/objects/singletons.dart';

class WalletPage extends StatefulWidget {

  @override
  WalletPageState createState() => new WalletPageState();
}

class WalletPageState extends State<WalletPage> {

  List<Wallet> walletList = UserWallets().walletList;

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
    return Dismissible(
      key: ValueKey(w),
      onDismissed: (DismissDirection direction) =>
        setState(()=> walletList.remove(w)),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) =>
            AlertDialog(
              title: Text("Confirm"),
              content: Text("Are you sure you want to delete " + w.name + "?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),),
                ]
            ),
        );
      },
      child:ListTile(
        leading: Image.asset("assets/" + w.source + "Small.png"),
        title: Text(w.name),
        trailing: Text(w.amount.toStringAsFixed(2) + "\t" + w.balanceType),
      )
    );
  }

  Widget buildButton() {
    var maxButtonWidth = (MediaQuery.of(context).size.width) / 1.75;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: MaterialButton(
                onPressed: ()=>
                  showDialog(context: context, //barrierDismissible: false,
                      builder: (BuildContext context) => addNewWalletDialog()),
                child: const Text("ADD A WALLET",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                color: Colors.white,
                textColor: Theme.of(context).primaryColor,
                elevation: 5,
                height: 50,
                minWidth: maxButtonWidth)));
  }

  Widget addNewWalletDialog() {
    return AlertDialog(
      title: Text("Where are you adding a wallet from?"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // GestureDetector(
              //   onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WebViewPage())), child:
              Padding(padding: EdgeInsets.all(10), child: Image.asset("assets/coinbase.png")),
              // ),
              Padding(padding: EdgeInsets.all(10), child: Image.asset("assets/cryptocom.png")),
              Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.center, child:
                Text("Other", style: TextStyle(),)))
            ]
          )
        )
    );
  }
}
