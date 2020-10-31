import 'package:application_ums_app/screens/home/local_widgets/userInfo.dart';
import 'package:application_ums_app/screens/home/local_widgets/wristInfo.dart';
import 'package:application_ums_app/utils/widgetView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageController createState() => _HomePageController();
}

class _HomePageController extends State<HomePage> {
  @override
  Widget build(BuildContext context) => _HomePageView(this);
}

class _HomePageView extends WidgetView<HomePage, _HomePageController> {
  _HomePageView(_HomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserInfo(),
        WristInfo()
      ],
    );
  }
}
