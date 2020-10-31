import 'package:flutter/material.dart';
import 'package:setting_page/settingItem.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            '設定',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          elevation: 0, // remove bottom shadow
          backgroundColor: Colors.grey[50],
        ),
      ),
      body: Column(
        children: <Widget>[
          SettingItem(title: '緊急聯絡人', btnFunction: null),
          SettingItem(title: '顯示語言', btnFunction: null),
          SettingItem(title: '自主異常通報', btnFunction: null),
          SettingItem(title: '聯絡我們', btnFunction: null),
          SettingItem(title: '隱私權條款', btnFunction: null),
          SettingItem(title: 'APP版本號', btnFunction: null),
          SettingItem(title: '登出', btnFunction: null),
        ],
      ),
    );
  }
}
