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
  final List<String> _tabList = ['day', 'week', 'month'];
  TabController _tabController;
  int currentTabIndex;

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: ScrollableState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: _tabList.map((tab) => Text(tab)).toList(),
          controller: _tabController,
          onTap: (value) {
            setState(() {
              currentTabIndex = value;
            });
          },
        ),
      ),
      body: Center(
        child: Text(currentTabIndex.toString())
      ),
    );
  }
}
