import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_test/heartRateSeries.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatelessWidget {
  final List<HeartRateSeries> data;

  /// Constructure
  MyLineChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartRateSeries, DateTime>> series = [
      charts.Series(
        id: "Heart Rate",
        data: data,
        domainFn: (HeartRateSeries series, _) => series.time,
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
                child: charts.TimeSeriesChart(
                  series, animate: true,
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)
                  ),
                  behaviors: [
                    charts.RangeAnnotation([
                      charts.LineAnnotationSegment(
                        DateTime.parse("20200915T17:30:00"),
                        charts.RangeAnnotationAxisType.domain,
                        color: charts.ColorUtil.fromDartColor(Colors.green),
                      ),
                    ]),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
