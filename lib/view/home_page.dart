import 'package:flutter/material.dart';
import 'package:flutter_app/objects/singletons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'main_drawer_view.dart';
import 'tally_search_page.dart';
import 'scanner_page.dart';
import '../presenter/home_presenter.dart';

//TODO: Observer and notifier for when someone else pays/requests payment to you
// ignore: must_be_immutable
class MyChips extends StatelessWidget {
  var presenter = new HomePresenter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff53ab77),
          accentColor: Color(0xfff3a43e),
          primaryColorDark: Color(0xff5c6060),
          scaffoldBackgroundColor: Color(0xfff5f6fb),
          fontFamily: 'Quicksand'
        ),
        //TODO: What to do for the user's first time
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  PieChartWidget createState() => PieChartWidget();
}

class PieChartWidget extends State<HomePage> {
  var presenter = new HomePresenter();
  UserInfo userInfo = UserInfo();
  double userBalance;
  Map<String, double> dataMap;
  List<Color> colorList;

  void getUserChartData() {
    if (userInfo.userBalance == null) {
      userInfo.userBalance = presenter.getUserBalance();
      userInfo.dataMap = presenter.getUserPieChart();
      userInfo.colorList = presenter.getPieChartColors(userInfo.dataMap);
    }
    userBalance = userInfo.userBalance;
    dataMap = userInfo.dataMap;
    colorList = userInfo.colorList;
  }

  @override
  Widget build(BuildContext context) {
    getUserChartData();
    return new Scaffold(
      appBar: AppBar(title: Text("Crypto Home")),
      body: Stack(children: [
        Center(
            child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 2500),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 1.2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.top,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
          ),
        )),
        buildButtons(),
        Column(children:[
          Padding(padding: const EdgeInsets.only(top: 26, bottom: 5),
              child: Text("Balance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text("The balance represents the total current \$USD representation of your combined wallet cryptocurrency values.")
                          );
                        });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("\$$userBalance", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500))
                      ]),),
        ]),
        ]),
      drawer: MainDrawer(),
    );
  }

  Widget buildButtons() {
    var maxButtonWidth = (MediaQuery.of(context).size.width) / 2.25;
    return Container(
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Scanner()));
                        },
                      child: Row(children: [
                        Text('SCAN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Icon(Icons.qr_code)
                      ]),
                      color: Colors.white,
                      textColor: Theme.of(context).primaryColor,
                      elevation: 5,
                      height: 50,
                      minWidth: maxButtonWidth))),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(name: "tally-search-page"),
                                builder: (BuildContext context) =>
                                    TallySearchPage(1)));
                        },
                      child:
                      const Text('Pay/Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      textColor: Theme.of(context).primaryColor,
                      elevation: 5,
                      height: 50,
                      minWidth: maxButtonWidth)))
        ]));
  }
}
