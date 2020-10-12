import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_from_API_test/models/heartRateSeries.dart';
import 'package:flutter/material.dart';

class HeartRateChart extends StatelessWidget {
  final List<HeartRateSeries> data;
  final List<HeartRateSeries> annotationPoint;

  /// Constructure
  HeartRateChart({@required this.data, this.annotationPoint});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartRateSeries, DateTime>> series = [
      charts.Series(
        id: "Heart Rate",
        data: data,
        domainFn: (HeartRateSeries series, _) => series.time,
        measureFn: (HeartRateSeries series, _) => series.heartRate,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ),
      charts.Series(
        id: "Annotation",
        data: annotationPoint,
        domainFn: (HeartRateSeries series, _) => series.time,
        domainLowerBoundFn: (_, __) => null,
        domainUpperBoundFn: (_, __) => null,
        /// No measure values are needed for symbol annotations.
        measureFn: (_, __) => null,
        colorFn: (HeartRateSeries series, _) => charts.ColorUtil.fromDartColor(Colors.green),
      )
      /// Configure our custom symbol annotation renderer for this series.
      ..setAttribute(charts.rendererIdKey, 'customSymbolAnnotation')
      // Optional radius for the annotation shape. If not specified, this will
      // default to the same radius as the points.
      // ..setAttribute(charts.boundsLineRadiusPxKey, 3.5),
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
                  customSeriesRenderers: [
                    charts.SymbolAnnotationRendererConfig(
                      // ID used to link series to this renderer.
                      customRendererId: 'customSymbolAnnotation',
                      radiusPx: 3.5,
                    ),
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
