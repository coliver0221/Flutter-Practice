import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_test/barChart.dart';
import 'package:charts_test/heartRateSeries.dart';
import 'package:charts_test/lineChart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomePage(),
      },    
    );
  }
}

class HomePage extends StatelessWidget {
  /// create heart rate data
  final List<HeartRateSeries> heartRateData = [
    HeartRateSeries(
      time: DateTime.parse("20200915T15:00:00"),
      heartRate: 90,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T16:00:00"),
      heartRate: 86,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T17:00:00"),
      heartRate: 97,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T18:00:00"),
      heartRate: 86,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T19:00:00"),
      heartRate: 83,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T20:00:00"),
      heartRate: 81,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
    HeartRateSeries(
      time: DateTime.parse("20200915T21:00:00"),
      heartRate: 84,
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Charts Testing')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: MyBarChart(data: heartRateData)),
            Expanded(child: MyLineChart(data: heartRateData)),
          ],
        ),
      ),
    );
  }
}
