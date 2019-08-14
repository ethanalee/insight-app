import "package:flutter/material.dart";
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/services.dart';

class Balance extends StatefulWidget {
  final Map<String, double> cost;
  Balance({this.cost});

  @override
  _BalanceState createState() => new _BalanceState();
}

class _BalanceState extends State<Balance> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  TextEditingController dateController = TextEditingController();

  double date = 1;

  final _chartSize = const Size(300.0, 300.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Total Daily Spending',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromRGBO(142, 228, 175, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 5,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    AnimatedCircularChart(
                      key: _chartKey,
                      size: _chartSize,
                      initialChartData: <CircularStackEntry>[
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(
                              33.33,
                              Colors.blue[400],
                              rankKey: 'completed',
                            ),
                            new CircularSegmentEntry(
                              44.67,
                              Colors.blueGrey[600],
                              rankKey: 'remaining',
                            ),
                            new CircularSegmentEntry(
                              12.00,
                              Colors.green[400],
                              rankKey: 'transportation',
                            ),
                            new CircularSegmentEntry(
                              10.00,
                              Colors.red[400],
                              rankKey: 'groceries',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      holeLabel: '\$' + (total() / date).toString(),
                      labelStyle: new TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Positioned(
                        left: 40,
                        top: 250,
                        child: Icon(Icons.bookmark_border,
                            color: Colors.blueGrey[600], size: 40)),
                    Positioned(
                        left: 5,
                        top: 60,
                        child: Icon(Icons.attach_money,
                            color: Colors.green[400], size: 40)),
                    Positioned(
                        left: 50,
                        top: 0,
                        child: Icon(Icons.directions_run,
                            color: Colors.red[400], size: 40)),
                    Positioned(
                        left: 260,
                        top: 60,
                        child: Icon(Icons.shopping_cart,
                            color: Colors.blue[400], size: 40))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(height: 8, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.timer),
                      labelText: 'Estimated Study Period',
                    ),
                    controller: dateController,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () => {
                      setState(() {
                        date = double.parse(this.dateController.text);
                      })
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border: Border.all(
                              color: Colors.blueGrey[600], width: 2)),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Tuition Costs',
                              style: TextStyle(
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('\$' + widget.cost["tuition"].toString(),
                                style: TextStyle(
                                    color: Colors.blueGrey[600],
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.bookmark_border,
                                color: Colors.blueGrey[600])
                          ],
                        ),
                        height: 100,
                        width: 160,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border: Border.all(color: Colors.red[400], width: 2)),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Tramsportation Costs',
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '\$' + widget.cost["transportation"].toString(),
                                style: TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.directions_run, color: Colors.red[400])
                          ],
                        ),
                        height: 100,
                        width: 160,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border:
                              Border.all(color: Colors.green[400], width: 2)),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Left Over Savings',
                              style: TextStyle(
                                  color: Colors.green[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('\$' + total().toString(),
                                style: TextStyle(
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.attach_money, color: Colors.green[400])
                          ],
                        ),
                        height: 100,
                        width: 160,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                          border:
                              Border.all(color: Colors.blue[400], width: 2)),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Groceries',
                              style: TextStyle(
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('\$' + widget.cost["groceries"].toString(),
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.shopping_cart, color: Colors.blue[400])
                          ],
                        ),
                        height: 100,
                        width: 160,
                      ),
                    ),
                  ],
                ),
                Flexible(child: new Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                      minWidth: 394.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text(
                          'Let\'s Go!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Color.fromRGBO(5, 56, 107, 1),
                        elevation: 9.0,
                      )),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  num total() {
    return num.parse((widget.cost["savings"] -
            (widget.cost["transportation"] +
                widget.cost["tuition"] +
                widget.cost["groceries"]))
        .toStringAsFixed(2));
  }
}
