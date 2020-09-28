import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_from_API_test/models/temperatureSeries.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  final List<TemperatureSeries> data;

  /// Constructure
  TemperatureChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TemperatureSeries, DateTime>> series = [
      charts.Series(
        id: "Heart Rate",
        data: data,
        domainFn: (TemperatureSeries series, _) => series.time,
        measureFn: (TemperatureSeries series, _) => series.temperature,
        // colorFn: (TemperatureSeries series, _) => series.barColor
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
                "Temperature",
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
