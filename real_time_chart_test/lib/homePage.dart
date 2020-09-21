import 'dart:async';
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chart_test/heartRateData.dart';
import 'package:real_time_chart_test/heartRateSeries.dart';
import 'package:real_time_chart_test/lineChart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var timer;

  void createHeartRateData () {
    var randomIntGenerater = Random();

    HeartRateSeries newSeries = HeartRateSeries(
      time: DateTime.now(),
      heartRate: randomIntGenerater.nextInt(40)+80, // generate random heart rate in [80, 120]
      barColor: charts.ColorUtil.fromDartColor(Colors.red)
    );

    /// push to provider
    Provider.of<HeartRateData>(context, listen: false).pushData(newSeries);
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      createHeartRateData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: MyLineChart(data: Provider.of<HeartRateData>(context).data),
       ),
    );
  }

  @override
  void dispose() { 
    if (timer != null) {
      timer.cancel();
      print('timer clear');
    }
    super.dispose();
  }
}
