import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hackathon_demo/env.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  final _chartSize = const Size(400.0, 400.0);

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;

  bool _position = true;
  bool _onTapToClose = false;
  bool _swipe = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;

  @override
  void initState() {
    super.initState();
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Set Your Budget'),
          backgroundColor: Color.fromRGBO(73, 159, 104, 1),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map'))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Insight'),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(73, 159, 104, 1),
                ),
              ),
              ListTile(
                leading: new Icon(Icons.announcement),
                title: Text('Onboarding Screen'),
                onTap: () {
                  Navigator.pushNamed(context, '/budget');
                },
              ),
              ListTile(
                leading: new Icon(Icons.map),
                title: Text('Map View'),
                onTap: () {
                  Navigator.pushNamed(context, '/heatmap');
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: Column(children: <Widget>[
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
        ])));
  }
}
