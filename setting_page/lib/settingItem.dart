import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final Function btnFunction;
  const SettingItem({Key key, @required this.title, this.btnFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: btnFunction,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: btnFunction == null ? Color(0xff666666) : Colors.black,
                  fontSize: 20.0,
                  letterSpacing: 1.92
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey[400]),
        ],
      ),
    );
  }
}