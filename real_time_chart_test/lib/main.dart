import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chart_test/heartRateData.dart';
import 'package:real_time_chart_test/homePage.dart';

void main() {
  // runApp(MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => HeartRateData(),
      child: MyApp(),
    ),
  );
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
      home: HomePage(),
    );
  }
}
