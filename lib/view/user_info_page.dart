import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'scanner_page.dart';

class UserInfoPage extends StatefulWidget {
  final bool registering;
  UserInfoPage(this.registering, {Key key}): super(key: key);
  @override
  UserInfoPageState createState() => new UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Information")),
      body: buildPage(),
      drawer: MainDrawer(),
    );
  }

  Widget buildPage() {
    return (Container(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: 128,
                ),
                Container(
                    child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Display Name",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Phone",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      Row(
                        children: [
                          Switch(
                              value: showContact,
                              onChanged: (value) {
                                setState(() {
                                  showContact = !showContact;
                                });
                              }),
                          Text("Display Contact Info Publicly?  "),
                          Text(showContact ? "Yes" : "No")
                        ],
                      ),
                      MaterialButton(
                          onPressed: () {
                            //TODO: Instead of jumping into scanner if registering, give the option for them to connect to a bot for their first tally.
                            widget.registering ?
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                    Scanner()))
                              : Navigator.pop(context);
                          },
                          child: Text(widget.registering ? "Continue" : "Save Changes",
                              style: TextStyle(fontSize: 20)),
                          color: Colors.blue,
                          textColor: Colors.white,
                          elevation: 5,
                          height: 50,
                          minWidth: (MediaQuery.of(context).size.width))
                    ],
                  ),
                ))
              ],
            ))));
  }
}
