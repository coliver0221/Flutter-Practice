import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_test/heartRateSeries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBarChart extends StatelessWidget {
  final List<HeartRateSeries> data;

  /// Constructure
  MyBarChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartRateSeries, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: data,
        domainFn: (HeartRateSeries series, _) => DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(series.time),
        measureFn: (HeartRateSeries series, _) => series.heartRate,
        colorFn: (HeartRateSeries series, _) => series.barColor
      )
    ];

    return Container(
      // height: 200,
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Heart Rate",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(
                  series,
                  animate: true,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
