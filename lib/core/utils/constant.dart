import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }
enum EndIcon { Cart, Clear, Nothing, Confirming, Borrowing, Done }

String url = 'http://kamera-api.000webhostapp.com';
String linkApi = '$url/api/';

class Styles {
  static Color darkPurple = Color(0xFF665CA9);
  static Color coolWhite = Color(0xFFEBEDF4);
}
