import 'package:flutter/material.dart';

abstract class AppTextstyles {
  static const overline = TextStyle(fontSize: 12, color: Colors.grey);
  static const heading1 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const heading2 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static final heading3 = TextStyle(fontSize: 16, color: Colors.grey.shade600);
  static const bodyBold = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const bodyBig = TextStyle(fontSize: 20);
  static const subHeading = TextStyle(fontSize: 14, color: Colors.grey);
}
