import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

/// Define the data schema
class SubscriberSeries {
  final DateTime time;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries({
    @required this.time,
    @required this.subscribers,
    @required this.barColor
  });
}