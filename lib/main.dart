import 'package:flutter/material.dart';
import 'package:hackathon_demo/pages/map.dart';
import 'package:hackathon_demo/pages/home.dart';
import 'package:hackathon_demo/pages/heat_map.dart';
import 'package:hackathon_demo/pages/budget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Welcome Page'),
        '/map': (context) => GetLocationPage(),
        '/heatmap': (context) => MapSample(),
        '/budget': (context) => BudgetWidget(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
