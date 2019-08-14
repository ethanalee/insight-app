import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackathon_demo/pages/purchase.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List purchases = MapSampleState.getPurchases();
  Completer<GoogleMapController> _controller = Completer();

  Set mapMarkers = MapSampleState.getMarkers();

  static BitmapDescriptor myIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'images/Launcher/icon.png')
        .then((onValue) {
      myIcon = onValue;
    });
  }

  static Set getMarkers() {
    List marks = MapSampleState.getPurchases();
    Set<Marker> result = {};
    for (var i = 0; i < marks.length; i++) {
      result.add(Marker(
        markerId: MarkerId(marks[i].location.toString()),
        position: marks[i].location,
        infoWindow: InfoWindow(
          title: marks[i].title,
          snippet: marks[i].level,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    return result;
  }

  static const LatLng _center = const LatLng(43.451566, -80.498145);
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  static List getPurchases() {
    return [
      Purchase(
          title: "Indigo \$5.00",
          level: "Low",
          indicatorValue: 0.33,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.392511, -80.320878),
          picture: "images/indigo.png"),
      Purchase(
          title: "Starbucks \$35.45",
          level: "High",
          indicatorValue: 0.9,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.415233, -80.514852),
          picture: "images/starbuckslogo.png"),
      Purchase(
          title: "Balzac\'s \$4.57",
          level: "Low",
          indicatorValue: 0.1,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.451172, -80.498411),
          picture: 'images/balzac.png'),
      Purchase(
          title: "McDonalds \$5.00",
          level: "Low",
          indicatorValue: 0.33,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.483483, -80.525143),
          picture: 'images/mcdonalds.png'),
      Purchase(
          title: "Tim Hortons \$11.00",
          level: "Low",
          indicatorValue: 0.33,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.483855, -80.526044),
          picture: 'images/tims.png'),
      Purchase(
          title: "Walmart \$22.00",
          level: "Low",
          indicatorValue: 0.45,
          price: 20,
          place: "Kitchener",
          location: LatLng(43.470158, -80.516069),
          picture: 'images/walmart.png'),
      Purchase(
        title: "Target \$75.00",
        level: "High",
        indicatorValue: 0.8,
        price: 20,
        place: 'Kitchener',
        location: LatLng(43.470158, -80.516069),
        picture: 'images/target.jpg',
      ),
    ];
  }

  //states for buttons
  bool toggleReminder = false;

  @override
  Widget build(BuildContext context) {
    ExpansionTile expandedTile(Purchase purchase) => ExpansionTile(
          onExpansionChanged: null,
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.transparent,
                child: Image.asset(purchase.picture),
              )),
          title: Text(purchase.title,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          trailing: Icon(Icons.toll, color: Colors.white),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 60),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () => {
                      setState(() => {this.toggleReminder = !toggleReminder}),
                      showSlidedownView(context, purchase)
                    },
                    color: toggleReminder ? Colors.red : Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () => {
                      setState(() => {
                            _goToPurchase(purchase.location),
                            this.showNotification(context, purchase)
                          })
                    },
                    color: Color.fromRGBO(5, 56, 107, 1),
                  ),
                ),
                InkWell(
                  onTap: () => showSlideupView(context),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Match',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        );

    Card makeCard(Purchase purchase) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(55, 150, 131, 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: expandedTile(purchase),
            ),
          ),
        );

    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SizedBox(
              height: 400.0,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: mapMarkers,
                  onCameraMove: _onCameraMove,
                  padding: const EdgeInsets.all(8.0),
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Daily Spending Remaining: \$5',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                color: Color.fromRGBO(55, 150, 131, 1)),
            Positioned(
              left: 340,
              top: 330,
              child: FloatingActionButton(
                child: Icon(Icons.person_pin_circle,
                    size: 36, color: Colors.white),
                onPressed: () => {
                  _goHome(_center),
                },
                backgroundColor: Color.fromRGBO(5, 56, 107, 1),
              ),
            )
          ],
        ),
        Card(
          child: Container(
            width: 392,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              child: Text('Recent Purchases',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                      fontSize: 20)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: purchases.length,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(purchases[index]);
            },
          ),
        )
      ],
    );
  }

  Future<void> _goToPurchase(location) async {
    print(location);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 20)));
  }

  Future<void> _goHome(location) async {
    print(location);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 11)));
  }

  void showNotification(BuildContext context, Purchase purchase) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        builder: (context) {
          return new GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  alignment: Alignment.topCenter,
                  height: 500,
                  width: 420,
                  child: Card(
                      elevation: 4,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Spending Alert',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Flexible(
                                        fit: FlexFit.loose, child: Container()),
                                    Icon(Icons.cancel, color: Colors.grey)
                                  ],
                                ),
                              ),
                              Container(
                                height: 200,
                                width: 420,
                                child: Image.asset(
                                  'images/starbucks.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('👀'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                    'We see you\'re close to Starbucks!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                    'You\'ve spent \$35.45 here the past two weeks. You have \$5.00 left in your spendable. Maybe hold off today?'),
                              ),
                              Flexible(fit: FlexFit.loose, child: Container()),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, bottom: 20),
                                child: Container(
                                    width: 420,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Special Offers',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0),
                                                  child: Text(
                                                    'Mcdonald\'s \$1.00 Drink Days',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Flexible(
                                                fit: FlexFit.loose,
                                                child: Container()),
                                            InkWell(
                                              onTap: () => {
                                                _goToPurchase(
                                                    getPurchases()[3].location),
                                                Navigator.pop(context)
                                              },
                                              child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      border: Border.all(
                                                          color: Colors.white)),
                                                  child: Icon(
                                                    Icons.play_circle_outline,
                                                    color: Colors.white,
                                                    size: 40,
                                                  )),
                                            )
                                          ],
                                        ))),
                              )
                            ],
                          )
                        ],
                      ))));
        });
  }

  void showSlidedownView(BuildContext context, Purchase purchase) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        builder: (context) {
          return new GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                alignment: Alignment.topCenter,
                height: 100,
                width: 500,
                child: Card(
                  child: Container(
                      width: 500,
                      child: this.toggleReminder
                          ? Column(
                              children: <Widget>[
                                Text('Location Reminder Toggled Off',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                Text(purchase.title),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                Text('Location Reminder Toggled On',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                Text(purchase.title),
                              ],
                            )),
                )),
          );
        });
  }

  void showSlideupView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        builder: (context) {
          return new GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                height: 500,
                width: 420,
                child: Card(
                    elevation: 4,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(children: <Widget>[
                              Container(
                                height: 200,
                                width: 420,
                                child: Image.asset('images/vancouver.jpg',
                                    fit: BoxFit.cover),
                              ),
                              Positioned(
                                left: 10,
                                top: 150,
                                child: Text('Vancouver Trip',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 30),
                              child: Text(
                                'Contribute \$5.00 to Goal',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8),
                              child: Text('January 2020'),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 12),
                                child: Text(
                                  '90\%',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.blueGrey[500],
                                  ),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 140),
                              child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey[300],
                                  value: 0.9,
                                  valueColor: AlwaysStoppedAnimation(
                                      Color.fromRGBO(180, 101, 74, 1))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 290, top: 40),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(children: <Widget>[
                                  Icon(Icons.close, color: Colors.white),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Close',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )
                                ]),
                                onPressed: () => Navigator.pop(context),
                                color: Colors.grey[500],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          left: 300,
                          top: 175,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  '\$5.00',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ]),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.red,
                          ),
                        )
                      ],
                    ))),
          );
        });
  }
}
