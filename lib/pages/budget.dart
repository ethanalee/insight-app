import 'package:flutter/material.dart';
import 'package:hackathon_demo/pages/balance.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/services.dart';

class BudgetWidget extends StatefulWidget {
  BudgetWidget({Key key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => new _SettingsWidgetState();
}

class _SettingsWidgetState extends State<BudgetWidget> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  List _cities = [
    "University of Waterloo",
    "Wilfrid Laurier University",
    "University of Toronto",
    "McGill University",
    "Conestoga College"
  ];

  List _programs = [
    "Computer Science",
    "Biology",
    "Mechanical Engineering",
    "Management Engineering",
    "Optometry"
  ];

  Map _costs = {
    "Computer Science": "12000",
    "Biology": "6000",
    "Mechanical Engineering": "10000",
    "Management Engineering": "13000",
    "Optometry": "20000"
  };

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  List<DropdownMenuItem<String>> _dropDownMenuPrograms;
  String _currentProgram;
  String _currentCost;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    _dropDownMenuPrograms = getDropDownPrograms();
    _currentProgram = _dropDownMenuPrograms[0].value;
    _currentCost = '\$0';
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownPrograms() {
    List<DropdownMenuItem<String>> items = new List();
    for (String program in _programs) {
      items.add(new DropdownMenuItem(value: program, child: new Text(program)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double transportation = 0;

    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Tuition Costs", () => 5);
    dataMap.putIfAbsent("Transportation Costs", () => transportation);
    dataMap.putIfAbsent("Groceries", () => 2);
    dataMap.putIfAbsent("Left Over Savings", () => 2);

    TextEditingController controller = TextEditingController();

    controller.addListener(() {
      print("Second text field: ${controller.text}");
      transportation = double.parse(controller.text);
    });

    return new Scaffold(
        appBar: AppBar(
          title: Text('Set Your Budget'),
          backgroundColor: Color.fromRGBO(73, 159, 104, 1),
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
                    chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
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
                      controller: controller,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.attach_money),
                        labelText: 'Your Savings',
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.number,
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
                      autofocus: true,
                      keyboardType: TextInputType.number,
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.directions_bike,
                                        color: Colors.grey, size: 40),
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.directions_bus,
                                        color: Colors.grey, size: 40),
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.directions_car,
                                        color: Colors.grey, size: 40),
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 32.0),
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
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey, size: 40),
                                  )
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                                      'Average',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.blur_circular,
                                        color: Colors.grey, size: 40),
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_back_ios,
                                        color: Colors.grey, size: 40),
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  transportation = 6;
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Balance(cost: _currentCost)),
                            );
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          color: Colors.white,
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

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  void changedDropDownProgram(String selectedProgram) {
    setState(() {
      _currentProgram = selectedProgram;
      _currentCost = _costs[_currentProgram];
    });
  }
}
