import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_from_API_test/models/heartRateSeries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeartRateChart extends StatelessWidget {
  final List<HeartRateSeries> data;
  final List<HeartRateSeries> annotationPoint;
  static int selectedValue;
  static DateTime selectedTime;

  /// Constructure
  HeartRateChart({@required this.data, this.annotationPoint});

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      selectedTime = selectedDatum.first.datum.time;
      selectedValue = selectedDatum.last.datum.heartRate;
    }
  }

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
                  behaviors: [
                    charts.LinePointHighlighter(
                      symbolRenderer: CustomCircleSymbolRenderer(),
                      showHorizontalFollowLine: charts.LinePointHighlighterFollowLineType.nearest
                    ),
                    charts.SelectNearest(
                      eventTrigger: charts.SelectionTrigger.tapAndDrag
                    ),
                  ],
                  selectionModels: [
                    charts.SelectionModelConfig(
                      changedListener: _onSelectionChanged,
                    )
                  ],
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

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  DateTime time;
  int value;

  CustomCircleSymbolRenderer({this.time, this.value});

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, charts.Color fillColor, charts.FillPatternType fillPattern, charts.Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    var textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
      TextElement(
        '${DateFormat('MM/dd HH:mm').format(HeartRateChart.selectedTime)}\n${HeartRateChart.selectedValue} BPM',
        style: textStyle
      ),
      (bounds.left).round(),
      (bounds.top - 28).round()
    );
  }
}
