import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteLocation {
  const RouteLocation._();
  static String get splash => '/';
  static String get home => '/home';
  static String get cart => '/cart';
   static String get detail => '/detail';
}
