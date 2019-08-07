import "package:flutter/material.dart";
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Balance extends StatelessWidget {
  final String cost;
  Balance({this.cost});

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  final _chartSize = const Size(400.0, 400.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Daily Spending'),
        backgroundColor: Color.fromRGBO(73, 159, 104, 1),
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
                new AnimatedCircularChart(
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
                          66.67,
                          Colors.blueGrey[600],
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: '1/3',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(height: 8, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Transportation'),
                        height: 100,
                        width: 160,
                      ),
                    ),
                    Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Transportations'),
                        height: 100,
                        width: 160,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Transportation'),
                        height: 100,
                        width: 160,
                      ),
                    ),
                    Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Transportations'),
                        height: 100,
                        width: 160,
                      ),
                    )
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
                        color: Color.fromRGBO(48, 209, 88, 1),
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
}
