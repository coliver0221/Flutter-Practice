import 'dart:math';

import 'package:charts_test/heartRateSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_style.dart' as chartStyle;
import 'package:charts_flutter/src/text_element.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartWithSelectoinCallBack extends StatefulWidget {
  LineChartWithSelectoinCallBack({Key key, @required this.data}) : super(key: key);

  final List<HeartRateSeries> data;

  @override
  _LineChartWithSelectoinCallBackState createState() => _LineChartWithSelectoinCallBackState(data);
}

class _LineChartWithSelectoinCallBackState extends State<LineChartWithSelectoinCallBack> {
  List<HeartRateSeries> _data;
  List<charts.Series<HeartRateSeries, DateTime>> _series;
  static int selectedValue;
  static DateTime selectedTime;

  // constructer
  _LineChartWithSelectoinCallBackState(this._data);

  void generateSeries() {
    setState(() {
      _series = [
      charts.Series(
        id: "Heart Rate",
        data: _data,
        domainFn: (HeartRateSeries series, _) => series.time,
        measureFn: (HeartRateSeries series, _) => series.heartRate,
        colorFn: (HeartRateSeries series, _) => series.barColor
      )
    ];
    });
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      selectedTime = selectedDatum.first.datum.time;
      selectedValue = selectedDatum.last.datum.heartRate;
    }
  }

  @override
  void initState() { 
    super.initState();
    generateSeries();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Text(
        "Heart Rate",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      Expanded(
        child: charts.TimeSeriesChart(
          _series, animate: true,
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
    ];

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: children,
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
    // canvas.drawRect(
    //   Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
    //   fill: charts.Color.white
    // );
    var textStyle = chartStyle.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
      TextElement(
        '${DateFormat('MM/dd HH:mm').format(_LineChartWithSelectoinCallBackState.selectedTime)}\n${_LineChartWithSelectoinCallBackState.selectedValue} BPM',
        style: textStyle
      ),
      (bounds.left).round(),
      (bounds.top - 28).round()
    );
  }
}
