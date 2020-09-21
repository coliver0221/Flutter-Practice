import 'package:flutter/material.dart';
import 'package:real_time_chart_test/heartRateSeries.dart';

class HeartRateData extends ChangeNotifier {
  List<HeartRateSeries> _data = [];

  List<HeartRateSeries> get data => _data;

  void pushData (HeartRateSeries series) {
    _data.add(series);
    if(_data.length > 10) {
      _data.removeAt(0);
    }

    notifyListeners();
  }
}