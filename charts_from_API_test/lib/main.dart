import 'dart:convert';

import 'package:charts_from_API_test/models/heartRateSeries.dart';
import 'package:charts_from_API_test/models/temperatureSeries.dart';
import 'package:charts_from_API_test/widgets/heartRateChart.dart';
import 'package:charts_from_API_test/widgets/temperatureChart.dart';
import 'package:dio/dio.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _bearer = '';
  List<HeartRateSeries> _heartRateData = [];
  List<TemperatureSeries> _temperatureData = [];

  Dio _dio = Dio();

  void _getDisplayData() async {
    print('----LOGIN----');
    try {
      var res = await _dio.post(
        'http://140.116.247.117:11050/login',
        data: {
          "account": 'Oliver1',
          "password": '2020-01-01',
          "role": "user",
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.toString());
        setState(() {
          _bearer = data['bearer'];
        });
        print(_bearer);
      }
    } on DioError catch (exception) {
      print(exception.error.toString());
    }

    print('----GETDATA----');
    print('curr bearer: $_bearer');
    print(DateTime.now().timeZoneOffset.inHours);
    // calling api
    try {
      var res = await _dio.get(
        'http://140.116.247.117:11050/data',
        queryParameters: {
          'query': '2020-09-22',
          'type': 'day',
          'timezone': DateTime.now().timeZoneOffset.inHours,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_bearer',
          }
        ),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.toString());
        _dataReformat(data['data']);
      }
    } on DioError catch (exception) {
      print(exception.error.toString());
    }
  }

  void _dataReformat(List<dynamic> data) {
    // print(data[0]);
    // print(DateTime.parse(data[0][0]));
    // print(int.parse(data[0][1]));
    // print(double.parse(data[0][2]));

    // print(data[0][0].runtimeType);
    // print(data[0][1].runtimeType);
    // print(data[0][2].runtimeType);

    print('----START REFORMAT----');
    setState(() {
      for (var record in data) {
        print(record);
        _heartRateData.add(HeartRateSeries(
          time: DateTime.parse(record[0]),
          heartRate: record[1],
        ));
        _temperatureData.add(TemperatureSeries(
          time: DateTime.parse(record[0]),
          temperature: record[2],
        ));
      }
    });
    print('----END REFORMAT----');
  }

  @override
  void initState() {
    _getDisplayData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(child: HeartRateChart(data: _heartRateData)),
            Expanded(child: TemperatureChart(data: _temperatureData)),
          ],
        ),
      ),
    );
  }
}
