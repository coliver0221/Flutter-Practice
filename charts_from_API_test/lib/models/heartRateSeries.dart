import 'package:flutter/foundation.dart';

/// Define heartrate data
class HeartRateSeries {
  final DateTime time;
  final int heartRate;
  // final charts.Color barColor;

  HeartRateSeries({
    @required this.time,
    this.heartRate,
    // @required this.barColor
  });
}