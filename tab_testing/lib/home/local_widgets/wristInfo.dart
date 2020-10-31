import 'package:flutter/material.dart';

import '../../../utils/widgetView.dart';

class WristInfo extends StatefulWidget {
  WristInfo({Key key}) : super(key: key);

  @override
  _WristInfoController createState() => _WristInfoController();
}

class _WristInfoController extends State<WristInfo> {
  @override
  Widget build(BuildContext context) => _WristInfoView(this);
}

class _WristInfoView extends WidgetView<WristInfo, _WristInfoController> {
  _WristInfoView(_WristInfoController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/4,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
          ),
        ),
      ),
    );
  }
}
