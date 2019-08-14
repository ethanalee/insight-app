import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:hackathon_demo/pages/heat_map.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  int _currentIndex = 0;

  final List<Widget> _children = [MainPage(), MapSample()];

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;

  bool _position = true;
  bool _onTapToClose = false;
  bool _swipe = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text(''),
            backgroundColor: Color.fromRGBO(92, 219, 149, 1),
            flexibleSpace: SafeArea(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'images/image.png',
                      height: 16,
                    ),
                  )
                ],
              ),
            )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('images/image.png', height: 8, width: 8),
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(92, 219, 149, 1),
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
        body: _children[_currentIndex]);
  }
}

class MainPage extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  final _chartSize = const Size(350.0, 350.0);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(children: <Widget>[
            AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: <CircularStackEntry>[
                new CircularStackEntry(
                  <CircularSegmentEntry>[
                    new CircularSegmentEntry(
                      50,
                      Colors.blue[400],
                      rankKey: 'completed',
                    ),
                    new CircularSegmentEntry(
                      50,
                      Colors.blueGrey[600],
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              chartType: CircularChartType.Radial,
              percentageValues: true,
              holeLabel: '50\%',
              labelStyle: new TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
            Positioned(
                left: 85,
                top: 130,
                child: Text('Daily Spending Left',
                    style:
                        TextStyle(fontSize: 20, color: Colors.blueGrey[600]))),
            Positioned(
                left: 145,
                top: 200,
                child: Text('\$5.00',
                    style:
                        TextStyle(fontSize: 20, color: Colors.blueGrey[600])))
          ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text('Your Savings Goals',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700])),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: ActiveCard(
            title: 'Trip to Africa',
            date: 'September 4',
            percentage: "20",
            dollar: "1500",
            imageUrl: 'images/africa.jpeg',
            bar: 0.2),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: ActiveCard(
          title: 'Trip to Europe',
          date: 'December 9',
          percentage: "70",
          dollar: "1200",
          bar: 0.7,
          imageUrl: 'images/europe.jpg',
        ),
      ),
    ]));
  }
}

class ActiveCard extends StatefulWidget {
  final String title;
  final String date;
  final String percentage;
  final String dollar;
  final String imageUrl;
  final double bar;

  const ActiveCard(
      {Key key,
      this.title,
      this.date,
      this.percentage,
      this.dollar,
      this.imageUrl,
      this.bar})
      : super(key: key);

  @override
  _ActiveCardState createState() => _ActiveCardState();
}

class _ActiveCardState extends State<ActiveCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              height: 128,
              width: 120,
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
                  child: Text(widget.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                  child: Text(
                    '\$' + widget.dollar,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Flexible(fit: FlexFit.loose, child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(width: 16.0, color: Colors.grey[500]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16),
                  child: Text(
                    widget.percentage + '\%',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 8,
                    child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[300],
                        value: widget.bar,
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromRGBO(180, 101, 74, 1))),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
