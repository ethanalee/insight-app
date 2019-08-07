
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Purchase {
  String title;
  String level;
  double indicatorValue;
  int price;
  String place;
  LatLng location;
  String picture;
  double scale;

  Purchase(
      {this.title, this.level, this.indicatorValue, this.price, this.place, this.location, this.picture, this.scale});
}