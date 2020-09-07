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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /* state variables */
  String _account = '';
  String _password = '';
  bool _isRememberMe = false;

  /* Form controller */
  TextEditingController _accountControllor = new TextEditingController();
  TextEditingController _passwordControllor = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  /* FocusNode for TextFormField */
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();

  /* handler */
  void _handleAccountChanged(String account) {
    setState(() {
      _account = account;
    });
  }

  void _handlePasswordChanged(String password) {
    setState(() {
      _password = password;
    });
  }

  void _handleRememberMeChanged(bool newValue) {
    setState(() {
      _isRememberMe = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //prevent resize when keyboard open
      appBar: AppBar(title: Text('Login Page Demo')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 100),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // logo
              Image(
                image: AssetImage("assets/logo.png"),
              ),
              // account input field
              TextFormField(
                controller: _accountControllor,
                focusNode: focusNode1,
                decoration: InputDecoration(
                  labelText: "識別證號",
                  icon: Icon(Icons.person),
                ),
                onChanged: (value) => _handleAccountChanged(value),
                validator: (v) {
                  return v.trim().length >= 6 && v.trim().length <= 32 ? null : "識別證號長度不合法";
                },
                onFieldSubmitted: (String s) {
                  FocusScope.of(context).requestFocus(focusNode2);
                },
              ),
              // password input field
              TextFormField(
                controller: _passwordControllor,
                focusNode: focusNode2,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  labelText: "生日",
                  hintText: "2000-01-01",
                  icon: Icon(Icons.lock),
                ),
                onChanged: (value) => _handlePasswordChanged(value),
                validator: (v) {
                  return RegExp(r"(^\d{4}-\d{2}-\d{2}$)").hasMatch(v.trim()) ? null : "生日格式不合法";
                },
                onFieldSubmitted: (String s) {
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                },
              ),
              // remember me checkbox
              CheckboxListTile(
                title: Text("記住我"),
                value: _isRememberMe,
                activeColor: Colors.blue,
                onChanged: _handleRememberMeChanged,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              // login button
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    print("Account: $_account");
                    print("Password: $_password");
                    print("isRememberMe: $_isRememberMe");
                  },  
                  child: Text("登入")
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}