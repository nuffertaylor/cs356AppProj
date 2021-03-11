import 'package:flutter/material.dart';
import 'package:flutter_app/objects/singletons.dart';
import 'package:pie_chart/pie_chart.dart';
import 'main_drawer_view.dart';
import 'tally_search_page.dart';
import 'sign_in_page.dart';
import 'scanner_page.dart';
import '../presenter/home_presenter.dart';

//TODO: Observer and notifier for when someone else pays/requests payment to you
// ignore: must_be_immutable
class MyChips extends StatelessWidget {
  var presenter = new HomePresenter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xff53ab77)),
        //TODO: Determine if a user is logged in already, if so go to HomePage instead of Login page
        home: SignInPage());
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

  //TODO: How do we choose the colors for the pie chart? Needs to be dynamic as number of colors could be
  // List<Color> colorList = [Colors.red, Colors.orange,Colors.green,Colors.greenAccent];
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
      appBar: AppBar(title: Text("MyCHIPs home")),
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
        Padding(
          padding: const EdgeInsets.all(15),
          child: Align(
            alignment: Alignment.topCenter,
            child: prependChipLogoToStr(userBalance.toString(), 50)
          ))
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
                        Text('SCAN', style: TextStyle(fontSize: 20)),
                        Icon(Icons.qr_code)
                      ]),
                      color: Colors.blue,
                      textColor: Colors.white,
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
                                builder: (BuildContext context) =>
                                    TallySearchPage(1)));
                        },
                      child:
                      const Text('Pay/Request', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                      height: 50,
                      minWidth: maxButtonWidth)))
        ]));
  }
}

//TODO: figure out how to resize chipLogo to match size of text
RichText prependChipLogoToStr(String txt, [double size = 12, Color color = Colors.black]) {
  return RichText(text: TextSpan(
    children: [
      WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Image.asset('assets/chip.png')),),
      TextSpan(text: txt, style: TextStyle(fontSize: size, color: color))
    ]));
}
