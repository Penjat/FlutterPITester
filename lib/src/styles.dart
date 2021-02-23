import 'package:flutter/material.dart';

class PiStyles {
  static TextStyle correctDigitsStyle = TextStyle(fontSize: 20.0, color: Colors.white60, fontWeight: FontWeight.bold);
  static TextStyle mainTitle = TextStyle(fontSize: 25.0, color: Colors.white70, fontWeight: FontWeight.bold);
  static TextStyle staticTitle = TextStyle(fontSize: 20.0, color: Colors.white38);
  static TextStyle dynamicField = TextStyle(fontSize: 20.0, color: Colors.deepPurple);
  static TextStyle keyPadTextStyle = TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);

  static Color keyColor = Colors.purpleAccent;
  static Color appBarColor = Colors.black12;
  static Color flashDigitColor = Colors.deepPurpleAccent;

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  primary: Colors.black, // background
  onPrimary: Colors.deepPurpleAccent, // foreground
  );
}