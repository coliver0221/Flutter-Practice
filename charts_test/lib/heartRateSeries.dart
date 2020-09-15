import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

/// Define heartrate data
class HeartRateSeries {
  final DateTime time;
  final int heartRate;
  final charts.Color barColor;

  HeartRateSeries({
    @required this.time,
    @required this.heartRate,
    @required this.barColor
  });
}