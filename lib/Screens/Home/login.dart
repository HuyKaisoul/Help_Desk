import 'package:Help_Desk/Screens/Home/tech.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/straintion/right_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin.dart';
import 'employee.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool checkshow = false;
  String textShow = "Show";
  String textHidden = "Hidden";
  String _errorUser = null;
  String _errorPass = null;
  bool _checkPass = false;
  bool _checkUser = false;

  Future<List> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http
        .post("http://helpdesksolutionszz.000webhostapp.com/api/report", body: {
      "username": userController.text,
      "password": passController.text,
    });
    print(response.body);
    if (response.body == '999') {
      userController.clear();
      passController.clear();
      signInCheck();
    } else if (response.body == "0") {
      prefs?.setString("isLoggedIn", '0');
      var session = FlutterSession();
      await session.set("username", userController.text);
      await session.set("type", 0);
      Navigator.push(context, SlideRightRoute(page: Employee()));
    } else if (response.body == "1") {
      prefs?.setString("isLoggedIn", '1');
      var session = FlutterSession();
      await session.set("username", userController.text);
      await session.set("type", 1);
      Navigator.push(context, SlideRightRoute(page: Tech()));
    } else if (response.body == "2") {
      prefs?.setString("isLoggedIn", '2');
      var session = FlutterSession();
      await session.set("username", userController.text);
      await session.set("type", 2);
      Navigator.push(context, SlideRightRoute(page: Admin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage = AssetImage("asset/img/login.jpg");
    backgroundImage.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                          child: Text(
                            "Welcome ",
                            style: TextStyle(
                              fontFamily: 'Acme',
                              fontWeight: FontWeight.bold,
                              color: kPrimaryWhite,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          child: Text(
                            "to",
                            style: TextStyle(
                              fontFamily: 'Acme',
                              fontWeight: FontWeight.bold,
                              color: kPrimaryWhite,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                    child: Container(
                      child: Text(
                        "Help Desk ",
                        style: TextStyle(
                          fontFamily: 'Acme',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryWhite,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextField(
                      controller: userController,
                      style: TextStyle(
                        fontFamily: 'Acme',
                        color: kPrimaryWhite,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: kPrimaryWhite),
                        errorText:
                            _checkUser ? "User Name is Wrong " : _errorUser,
                        labelText: "User Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryWhite),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryWhite),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Acme',
                          color: kPrimaryHighLight,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          controller: passController,
                          style: TextStyle(
                            fontFamily: 'Acme',
                            color: kPrimaryWhite,
                          ),
                          obscureText: !checkshow,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: kPrimaryWhite),
                            errorText:
                                _checkPass ? "Password is Wrong " : _errorPass,
                            labelText: "Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryWhite),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryWhite),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Acme',
                              color: kPrimaryHighLight,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: signInTouch,
                          child: Text(
                            checkshow ? textHidden : textShow,
                            style: TextStyle(
                              fontFamily: 'Acme',
                              color: kPrimaryHighLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 160),
                    child: RaisedButton(
                      onPressed: () {
                        signInCheck();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              kPrimaryStart,
                              kPrimaryEnd,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: const Text(
                              'LOGIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Acme',
                                  color: kPrimaryWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInTouch() {
    setState(() {
      checkshow = !checkshow;
    });
  }

  void signInCheck() {
    setState(() {
      _checkPass = _checkUser = false;
      if (userController.text.length < 1) {
        _checkUser = true;
      }
      if (passController.text.length < 1) {
        _checkPass = true;
      } else {
        _login();
      }
    });
  }
}
