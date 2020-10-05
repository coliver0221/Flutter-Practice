import 'dart:convert';

import 'package:charts_from_API_test/models/heartRateSeries.dart';
import 'package:charts_from_API_test/models/temperatureSeries.dart';
import 'package:charts_from_API_test/widgets/heartRateChart.dart';
import 'package:charts_from_API_test/widgets/temperatureChart.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> rangeList = ['day', 'week', 'month'];

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
  List<bool> _toggleSelect = [true, false, false];
  DateTime _selectedDate = DateTime.now().subtract(Duration(days: 1));
  String _displayTime = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)));
  String _range = rangeList[0];

  Dio _dio = Dio();

  void _getDisplayData() async {
    // print('----LOGIN----');
    // try {
    //   var res = await _dio.post(
    //     'http://140.116.247.117:11050/login',
    //     data: {
    //       "account": 'Oliver1',
    //       "password": '2020-01-01',
    //       "role": "user",
    //     },
    //     options: Options(
    //       headers: {
    //         'Content-Type': 'application/json',
    //       },
    //     ),
    //   );
    //   if (res.statusCode == 200) {
    //     var data = jsonDecode(res.toString());
    //     setState(() {
    //       _bearer = data['bearer'];
    //     });
    //     print(_bearer);
    //   }
    // } on DioError catch (exception) {
    //   print(exception.error.toString());
    // }

    print('----GETDATA----');
    print('start date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}');
    /// calling api
    try {
      var res = await _dio.get(
        'http://140.116.247.117:11050/data',
        queryParameters: {
          'query': DateFormat('yyyy-MM-dd').format(_selectedDate).toString(),
          'type': _range,
          'timezone': DateTime.now().timeZoneOffset.inHours,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer $_bearer',
            'Authorization': 'Bearer 81b4dc91adf59b0c0a8e72e8df2e075d3a593db77348551b840c7fc694768ee2',
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
    print('----START REFORMAT----');
    setState(() {
      _heartRateData.clear();
      _temperatureData.clear();
      for (var record in data) {
        // print(record);
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

  void _updateDisplayTime() {
    var formatter = DateFormat('yyyy-MM-dd');
    String startTime = formatter.format(_selectedDate);
    switch (_range) {
      case 'day':
        setState(() {
          _displayTime = startTime;
        });
        break;
      case 'week':
        setState(() {
          _displayTime = '$startTime ~ ${formatter.format(_selectedDate.add(Duration(days: 6)))}';
        });
        break;
      case 'month':
        setState(() {
          _displayTime = '$startTime ~ ${formatter.format(DateTime(_selectedDate.year, _selectedDate.month+1, 0))}';
        });
        break;
    }
  }

  void _dateAdd() {
    switch (_range) {
      case 'day':
        setState(() {
           _selectedDate = _selectedDate.add(Duration(days: 1));
        });
        break;
      case 'week':
        setState(() {
           _selectedDate = _selectedDate.add(Duration(days: 7));
        });
        break;
      case 'month':
        setState(() {
           _selectedDate = DateTime(_selectedDate.year, _selectedDate.month+1, 1);
        });
        break;
      default:
    }
    _updateDisplayTime();
    _getDisplayData();
  }

  void _dateSub() {
    switch (_range) {
      case 'day':
        setState(() {
           _selectedDate = _selectedDate.subtract(Duration(days: 1));
        });
        break;
      case 'week':
        setState(() {
           _selectedDate = _selectedDate.subtract(Duration(days: 7));
        });
        break;
      case 'month':
        setState(() {
           _selectedDate = DateTime(_selectedDate.year, _selectedDate.month-1, 1);
        });
        break;
      default:
    }
    _updateDisplayTime();
    _getDisplayData();
  }
  
  void _handleToggleClick(int index) {
    /// update toggle
    setState(() {
      _range = rangeList[index];
      for (int i=0; i<_toggleSelect.length; i++) {
        if (i == index) {
          _toggleSelect[i] = true;
        } else {
          _toggleSelect[i] = false;
        }
      }
    });
    /// set start time
    switch (_range) {
      case 'day':
        break;
      case 'week':
        setState(() {
          _selectedDate = _selectedDate.subtract(Duration(days: (_selectedDate.weekday % 7)));
        });
        break;
      case 'month':
        setState(() {
          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
        });
        break;
    }
    _updateDisplayTime();
    _getDisplayData();
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
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '歷史查詢',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ToggleButtons(
                isSelected: _toggleSelect,
                constraints: BoxConstraints.expand(
                  width: (MediaQuery.of(context).size.width-32) / 3, // 32 is the surrounding padding
                ),
                onPressed: (index) => _handleToggleClick(index),
                children: <Widget>[
                  Text('日'),
                  Text('週'),
                  Text('月'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () => _dateSub(),
                    ),
                    Expanded(
                      child: Text(
                        _displayTime,
                        textAlign: TextAlign.center,
                      )
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () => _dateAdd(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: HeartRateChart(data: _heartRateData)
            ),
            Expanded(
              flex: 4,
              child: TemperatureChart(data: _temperatureData)
            ),
          ],
        ),
      ),
    );
  }
}
