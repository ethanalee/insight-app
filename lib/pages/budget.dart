import 'package:flutter/material.dart';
import 'package:hackathon_demo/main.dart';
import 'package:hackathon_demo/my_flutter_app_icons.dart';
import 'package:hackathon_demo/pages/balance.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

class BudgetWidget extends StatefulWidget {
  BudgetWidget({Key key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => new _SettingsWidgetState();
}

class _SettingsWidgetState extends State<BudgetWidget> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  TextEditingController savingsController = TextEditingController();
  TextEditingController tuitionController = TextEditingController();

  Map<String, double> dataMap = new Map();
  List<bool> buttons = [false, false, false];
  List<bool> groceryButtons = [false, false, false];

  @override
  void initState() {
    super.initState();

    savingsController.addListener(() {});
    tuitionController.addListener(() {});

    dataMap.putIfAbsent("Tuition Costs", () => 5000);
    dataMap.putIfAbsent("Transportation Costs", () => 5000);
    dataMap.putIfAbsent("Groceries", () => 5000);
    dataMap.putIfAbsent("Left Over Savings", () => 5000);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Set Your Budget', style: TextStyle(color: Colors.black)),
          backgroundColor: Color.fromRGBO(92, 219, 149, 1),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PieChart(
                    dataMap: dataMap,
                    legendFontColor: Colors.blueGrey[900],
                    legendFontSize: 14.0,
                    legendFontWeight: FontWeight.w500,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 16.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    chartValuesColor: Colors.white,
                    showLegends: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(height: 20, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      controller: savingsController,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.attach_money),
                        labelText: 'Your Savings',
                      ),
                      keyboardType: TextInputType.number,
                      onEditingComplete: () => {
                        setState(() {
                          dataMap["Left Over Savings"] =
                              double.parse(savingsController.text);
                        })
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.bookmark_border),
                        labelText: 'Your Tuition Costs',
                      ),
                      controller: tuitionController,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () => {
                        setState(() {
                          dataMap["Tuition Costs"] =
                              double.parse(tuitionController.text);
                        })
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.directions_run, color: Colors.grey[500]),
                        SizedBox(
                          width: 16,
                        ),
                        Text('Transportation',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Bike',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: buttons[0]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.directions_bike,
                                        color: buttons[0]
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 40),
                                  ),
                                ],
                              ),
                              color: buttons[0]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Transportation Costs"] = 200;
                                  buttons[0] = true;
                                  buttons[1] = false;
                                  buttons[2] = false;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Bus',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: buttons[1]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(MyFlutterApp.transport,
                                        color: buttons[1]
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 40),
                                  ),
                                ],
                              ),
                              color: buttons[1]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Transportation Costs"] = 1000;
                                  buttons[0] = false;
                                  buttons[1] = true;
                                  buttons[2] = false;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Car',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: buttons[2]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.directions_car,
                                        color: buttons[2]
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 40),
                                  ),
                                ],
                              ),
                              color: buttons[2]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Transportation Costs"] = 1000;
                                  buttons[0] = false;
                                  buttons[1] = false;
                                  buttons[2] = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart, color: Colors.grey[500]),
                        SizedBox(
                          width: 16,
                        ),
                        Text('Groceries',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Less',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: groceryButtons[0]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(MyFlutterApp.food__2_,
                                        color: groceryButtons[0]
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 40),
                                  )
                                ],
                              ),
                              color: groceryButtons[0]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Groceries"] = 4000;
                                  groceryButtons[0] = true;
                                  groceryButtons[1] = false;
                                  groceryButtons[2] = false;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Mid',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: groceryButtons[1]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Tab(
                                        icon: Icon(MyFlutterApp.fast_food,
                                            color: groceryButtons[1]
                                                ? Colors.white
                                                : Colors.grey,
                                            size: 40)),
                                  ),
                                ],
                              ),
                              color: groceryButtons[1]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Groceries"] = 5000;
                                  groceryButtons[0] = false;
                                  groceryButtons[1] = true;
                                  groceryButtons[2] = false;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Plus',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: groceryButtons[2]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(MyFlutterApp.food,
                                        color: groceryButtons[2]
                                            ? Colors.white
                                            : Colors.grey,
                                        size: 40),
                                  ),
                                ],
                              ),
                              color: groceryButtons[2]
                                  ? Color.fromRGBO(5, 150, 131, 1)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  dataMap["Groceries"] = 7000;
                                  groceryButtons[0] = false;
                                  groceryButtons[1] = false;
                                  groceryButtons[2] = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Flexible(fit: FlexFit.loose, child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonTheme(
                        minWidth: 394.0,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey),
                        ),
                        child: RaisedButton(
                          onPressed: activeButton()
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Balance(cost: {
                                              "tuition": double.parse(
                                                  this.tuitionController.text),
                                              "savings": double.parse(
                                                  this.savingsController.text),
                                              "transportation": dataMap[
                                                  "Transportation Costs"],
                                              "groceries": dataMap["Groceries"]
                                            })),
                                  );
                                }
                              : () => {null},
                          child: new Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 20,
                                color: activeButton()
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          color: activeButton()
                              ? Color.fromRGBO(5, 56, 107, 1)
                              : Colors.white,
                          elevation: 3.0,
                        )),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }

  bool activeButton() {
    if (this.tuitionController.text != "" &&
        this.savingsController.text != "" &&
        !(eq(this.buttons, [false, false, false])) &&
        !(eq(this.groceryButtons, [false, false, false]))) {
      return true;
    }
    return false;
  }

  Function eq = const ListEquality().equals;
}
