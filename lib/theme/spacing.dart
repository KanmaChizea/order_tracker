import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const screenPadding = kIsWeb
      ? EdgeInsets.symmetric(vertical: 40, horizontal: 100)
      : EdgeInsets.all(24);
  static space(double size) => SizedBox(height: size, width: size);
}
