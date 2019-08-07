import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:hackathon_demo/pages/purchase.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List purchases = MapSampleState.getPurchases();
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  Set mapMarkers = MapSampleState.getMarkers();

  static Set getMarkers () {
    List marks = MapSampleState.getPurchases();
    Set<Marker> result = {};
    for (var i = 0; i < marks.length; i++) {
      result.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(marks[i].location.toString()),
        position: marks[i].location,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      )
    );
    }
    return result;
  }

  static const LatLng _center = const LatLng(43.451566, -80.498145);
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
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
        picture: "http://www.wem.ca/media/2672/indigo-web-logo.png"
      ),
      Purchase(
        title: "Starbucks \$35.45",
        level: "High",
        indicatorValue: 0.9,
        price: 20,
        place: "Kitchener",
        location: LatLng(43.415233, -80.514852),
        picture: "https://diylogodesigns.com/wp-content/uploads/2018/09/Starbucks_Coffee_Logo.png-768x768.png"
      ),
      Purchase(
        title: "Balzac\'s \$4.57",
        level: "Low",
        indicatorValue: 0.1,
        price: 20,
        place: "Kitchener",
        location: LatLng(43.451172, -80.498411),
        picture: 'https://www.upexpress.com/Content/Images/AboutUP/Partners/Balzac/balzacs_desktop.png'
      ),
      Purchase(
        title: "McDonalds \$5.00",
        level: "Low",
        indicatorValue: 0.33,
        price: 20,
        place: "Kitchener",
        location: LatLng(43.483483, -80.525143),
        picture: 'https://i.ya-webdesign.com/images/mcdonalds-png-8.png'
      ),
      Purchase(
        title: "Tim Hortons \$11.00",
        level: "Low",
        indicatorValue: 0.33,
        price: 20,
        place: "Kitchener",
        location: LatLng(43.483855, -80.526044),
        picture: 'https://cdn.freebiesupply.com/logos/large/2x/tim-hortons-2-logo-black-and-white.png'
      ),
      Purchase(
        title: "Walmart \$22.00",
        level: "Low",
        indicatorValue: 0.45,
        price: 20,
        place: "Kitchener",
        location: LatLng(43.470158, -80.516069),
        picture: 'http://www.logospng.com/images/170/scott-paper-towels-logo-170466.png'
      ),
      Purchase(
        title: "Target \$75.00",
        level: "High",
        indicatorValue: 0.8,
        price: 20,
        place: 'Kitchener',
        location: LatLng(43.470158, -80.516069),
        picture: 'https://banner2.kisspng.com/20180925/zut/kisspng-logo-symbol-target-corporation-brand-image-the-mall-at-prince-georges-directory-hyattsvil-5baaa2811f72e8.8465358615379093771288.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    ListTile makeListTile(Purchase purchase) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage(purchase.picture),
                backgroundColor: Colors.transparent,
              )
      ),
      title: Text(
        purchase.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: purchase.indicatorValue,
                    valueColor: purchase.indicatorValue > 0.5 ? AlwaysStoppedAnimation(Color.fromRGBO(180,101,74,1)) : AlwaysStoppedAnimation(Colors.green))  ,
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(purchase.level,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        _goToPurchase(purchase.location);
      });


    Card makeCard(Purchase purchase) => Card(
      shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(100.0),
                     ),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(21,122,110,1)),
        child: makeListTile(purchase),
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text('Heat Map'),
        backgroundColor: Color.fromRGBO(73,159,104,1),
      ),
      body: Column(
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: 400.0,
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
                  ),
                ),
            ),
            ButtonTheme(
              minWidth: 394.0,
              height: 50.0,
              child: RaisedButton(
              onPressed: () {
                _goHome(_center);
              },
              child: const Text(
                'Return to Overview',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Color.fromRGBO(48,209,88,1),
              elevation: 9.0,
            ),
            ),
            Expanded(child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: purchases.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(purchases[index]);
                },
              ),
            )
          ],
        )
    );
  }

  // void refresh() async {
  //   final center = await getUserLocation();

  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
  // }

  // Future<LatLng> getUserLocation() async {
  //   var currentLocation = <String, double>{};
  //   final location = Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //     final lat = currentLocation["latitude"];
  //     final lng = currentLocation["longitude"];
  //     final center = LatLng(lat, lng);
  //     print(center);
  //     return center;
  //   } on Exception {
  //     currentLocation = null;
  //     return null;
  //   }
  // }

  Future<void> _goToPurchase(location) async {
    print(location);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 20)));
  }

  Future<void> _goHome(location) async {
    print(location);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 11)));
  }


}