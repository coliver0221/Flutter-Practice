import 'package:flutter/material.dart';

import '../../../utils/widgetView.dart';

class UserInfo extends StatefulWidget {
  UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoController createState() => _UserInfoController();
}

class _UserInfoController extends State<UserInfo> {
  @override
  Widget build(BuildContext context) => _UserInfoView(this);
}

class _UserInfoView extends WidgetView<UserInfo, _UserInfoController> {
  _UserInfoView(_UserInfoController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
      ),
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        heightFactor: 0.91,
        widthFactor: 0.94,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
          ),
        ),
      ),
    );
  }
}
