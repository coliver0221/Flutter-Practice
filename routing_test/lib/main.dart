import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'named_route': (context) => NamedRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        'named_route_with_parameter': (context) => NameRouteWithParameter(),
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}): super(key:key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('open simple route'),
              textColor: Colors.green,
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimpleRoute())
                );
              },
            ),
            FlatButton(
              child: Text('open tip route'),
              textColor: Colors.purple,
              onPressed: () async {
                var res = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TipRoute(text: "I'm the msg from home page")),
                );
                print(res);
              },
            ),
            FlatButton(
              child: Text('open named route'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.pushNamed(context, "named_route");
              },
            ),
            FlatButton(
              child: Text('open named route with parameter'),
              textColor: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed("named_route_with_parameter", arguments: "This is the msg from home page");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleRoute extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple route'),
      ),
      body: Center(
        child: Text('This is the simple route'),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
  }): super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top route"),
      ),
      body: Column(
        children: <Widget>[
          Text(text),
          RaisedButton(
            onPressed: () => Navigator.pop(context, "I'm the return value of Tip route page"),
            child: Text("return"),
          ),
        ],
      ),
    );
  }
}

class NamedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext conext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Named route'),
      ),
      body: Center(
        child: Text('This is the named route'),
      ),
    );
  }
}

class NameRouteWithParameter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Named route with parameter'),
      ),
      body: Center(
        child: Text(ModalRoute.of(context).settings.arguments),
      ),
    );
  }
}
