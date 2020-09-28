import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_from_API_test/models/heartRateSeries.dart';
import 'package:flutter/material.dart';

class HeartRateChart extends StatelessWidget {
  final List<HeartRateSeries> data;

  /// Constructure
  HeartRateChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartRateSeries, DateTime>> series = [
      charts.Series(
        id: "Heart Rate",
        data: data,
        domainFn: (HeartRateSeries series, _) => series.time,
        measureFn: (HeartRateSeries series, _) => series.heartRate,
        // colorFn: (HeartRateSeries series, _) => series.barColor
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
                child: charts.TimeSeriesChart(
                  series, animate: true,
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
