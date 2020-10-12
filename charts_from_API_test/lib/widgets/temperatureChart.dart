import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_from_API_test/models/temperatureSeries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TemperatureChart extends StatelessWidget {
  final List<TemperatureSeries> data;
  static double selectedValue;
  static DateTime selectedTime;

  /// Constructure
  TemperatureChart({@required this.data});

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      selectedTime = selectedDatum.first.datum.time;
      selectedValue = selectedDatum.last.datum.temperature;
    }
  }

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
                  behaviors: [
                    charts.LinePointHighlighter(
                      symbolRenderer: CustomCircleSymbolRenderer(),
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
  double value;

  CustomCircleSymbolRenderer({this.time, this.value});

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, charts.Color fillColor, charts.FillPatternType fillPattern, charts.Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    var textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
      TextElement(
        '${DateFormat('MM/dd HH:mm').format(TemperatureChart.selectedTime)}\n${TemperatureChart.selectedValue} °C',
        style: textStyle
      ),
      (bounds.left).round(),
      (bounds.top - 28).round()
    );
  }
}
