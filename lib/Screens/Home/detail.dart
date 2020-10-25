import 'dart:async';
import 'dart:convert';

import 'package:Help_Desk/Screens/Home/tech.dart';
import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:Help_Desk/straintion/right_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'components/messages.dart';
import 'components/person.dart';
import 'package:easy_localization/easy_localization.dart';

class SecondScreen extends StatefulWidget {
  final Report value;

  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Future<List<Messages>> _future;
  bool _isVisible = true;
  bool _isVisible2 = false;

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        _future = messages(widget.value.id);
      });
    });
  }

  TextEditingController descripController = TextEditingController();
  TextEditingController controllersend = TextEditingController();
  Future<List<Report>> send(int id, String text) async {
    var bodyEncoded = json.encode(id);
    var bodytext = json.encode(text);
    var bodytype = json.encode(await FlutterSession().get("type"));
    final response = await http.post(
        "http://helpdesksolutionszz.000webhostapp.com/api/sendmess",
        body: {
          "contains": bodytext,
          "type": bodytype,
          "id": bodyEncoded,
        });

    if (response.body == "Success") {
      controllersend.clear();
    }
  }

  Future<List<Messages>> solutions(int id, String text) async {
    var bodyEncoded = json.encode(id);
    var bodySolu = json.encode(text);
    print(text);
    final response = await http.post(
        "http://192.168.2.24/LoginRegister/public/api/postsolution",
        body: {
          "id": bodyEncoded,
          "solution": bodySolu,
        });
    print(response.body);

    if (response.body == "1") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("success".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("fail".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    }
    setState(() {
      Future.delayed(
        Duration(seconds: 5),
        () {
          Navigator.push(
            context,
            SlideRightRoute(page: Tech()),
          );
        },
      );
    });
  }

  Future<List<Report>> accept(int id) async {
    var bodyEncoded = json.encode(id);
    final response = await http.post(
        "http://helpdesksolutionszz.000webhostapp.com/api/acreport",
        body: {
          "id": bodyEncoded,
        });
    print(response.body);

    if (response.body == "1") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("success".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("fail".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    }
    setState(() {
      Future.delayed(
        Duration(seconds: 5),
        () {
          Navigator.push(
            context,
            SlideRightRoute(page: Tech()),
          );
        },
      );
    });
  }

  Future<List<Messages>> close(int id) async {
    var bodyEncoded = json.encode(id);
    final response = await http.post(
        "http://helpdesksolutionszz.000webhostapp.com/api/clreport",
        body: {
          "id": bodyEncoded,
        });
    print(response.body);
    if (response.body == "1") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("success".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("fail".tr().toString()),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    }
    setState(() {
      Future.delayed(
        Duration(seconds: 5),
        () {
          Navigator.push(
            context,
            SlideRightRoute(page: Tech()),
          );
        },
      );
    });
  }

  Future<String> check(int status, String username, String techname) async {
    String checkname = await FlutterSession().get("username");
    int type = await FlutterSession().get("type");
    if (type == 2) {
      return 'admin'.tr().toString();
    } else if (type == 1) {
      if (status != 3) {
        if (techname == checkname) {
          return 'me'.tr().toString();
        }
      }
    } else {
      if (status != 3) {
        if (username == checkname) {
          return 'me'.tr().toString();
        }
      }
    }
  }

  Future<String> checktech(int status, String username, String techname) async {
    String checkname = await FlutterSession().get("username");
    int type = await FlutterSession().get("type");
    if (type == 1) {
      if (status == 2) {
        if (techname == checkname) {
          return 'me'.tr().toString();
        }
      }
    }
  }

  Future<String> checkuser(int status, String username, String techname) async {
    String checkname = await FlutterSession().get("username");

    int type = await FlutterSession().get("type");
    if (type == 1) {
      if (status == 1) {
        if (techname == checkname) {
          return 'me'.tr().toString();
        }
      }
    }
  }

  String gettitle() {
    if (_isVisible) {
      return "feedback";
    } else {
      return "solution";
    }
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
      _isVisible2 = !_isVisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text('detail'.tr().toString())),
      body: new Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    child: new Text(
                      '${widget.value.title}',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Padding(
                    //`widget` is the current configuration. A State object's configuration
                    //is the corresponding StatefulWidget instance.
                    child:
                        Image.network('${widget.value.imageUrl}', width: 120),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        child: new Text(
                          'create'.tr().toString() +
                              ' : ${widget.value.create}',
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'descrip'.tr().toString() +
                              ' : ${widget.value.description}',
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  Padding(
                    child: new Text(
                      'solution'.tr().toString() +
                          ' : ${widget.value.solution}',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[kPrimaryEnd, kPrimaryStart]),
                    ),
                    child: FutureBuilder(
                      future: checktech(
                          widget.value.status,
                          '${widget.value.username_emp}',
                          '${widget.value.username_tech}'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RaisedButton(
                            onPressed: () {
                              showToast();
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    kPrimaryStart,
                                    kPrimaryEnd,
                                  ],
                                ),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 10.0,
                                    minHeight:
                                        6.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                  child: Text(
                                    gettitle().tr().toString(),
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
                          );
                        } else {
                          return FutureBuilder(
                              future: checkuser(
                                  widget.value.status,
                                  '${widget.value.username_emp}',
                                  '${widget.value.username_tech}'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container();
                                } else {
                                  return RaisedButton(
                                    onPressed: () {
                                      showToast();
                                    },
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            kPrimaryStart,
                                            kPrimaryEnd,
                                          ],
                                        ),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 10.0,
                                            minHeight:
                                                6.0), // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 2, 0, 2),
                                          child: Text(
                                            'feedback'.tr().toString(),
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
                                  );
                                }
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: checktech(
                    widget.value.status,
                    '${widget.value.username_emp}',
                    '${widget.value.username_tech}'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _isVisible
                        ? Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Expanded(
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: new FutureBuilder<
                                                List<Messages>>(
                                              future: _future,
                                              //we pass a BuildContext and an AsyncSnapshot object which is an
                                              //Immutable representation of the most recent interaction with
                                              //an asynchronous computation.
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<Messages> mess =
                                                      snapshot.data;
                                                  return new Mess(mess);
                                                } else if (snapshot.hasError) {
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text("null"
                                                              .tr()
                                                              .toString()),
                                                          Icon(
                                                            Icons.no_cell_sharp,
                                                            size: 30,
                                                          ),
                                                        ],
                                                      ));
                                                }
                                                //return  a circular progress indicator.
                                                return CircularProgressIndicator();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          kPrimaryEnd,
                                          kPrimaryStart
                                        ]),
                                  ),
                                  child: FutureBuilder(
                                    future: check(
                                        widget.value.status,
                                        '${widget.value.username_emp}',
                                        '${widget.value.username_tech}'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 35,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: kPrimaryWhite,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                80.0)),
                                                  ),
                                                  child: TextField(
                                                    controller: controllersend,
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'Acme',
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                kPrimaryNone),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                kPrimaryNone),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: RaisedButton(
                                                onPressed: () {
                                                  send(widget.value.id,
                                                      controllersend.text);
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.0)),
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Ink(
                                                  decoration:
                                                      const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: <Color>[
                                                        kPrimaryStart,
                                                        kPrimaryEnd,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                80.0)),
                                                  ),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 20.0,
                                                            minHeight:
                                                                6.0), // min sizes for Material buttons
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 5, 0, 5),
                                                      child: Text(
                                                        'send'.tr().toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: 'Acme',
                                                            color:
                                                                kPrimaryWhite,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 35,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: kPrimaryBlue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  } else {
                    return FutureBuilder(
                        future: checkuser(
                            widget.value.status,
                            '${widget.value.username_emp}',
                            '${widget.value.username_tech}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      accept(widget.value.id);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            kPrimaryStart,
                                            kPrimaryEnd,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 100.0,
                                            minHeight:
                                                7.0), // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          child: Text(
                                            'get'.tr().toString(),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      close(widget.value.id);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            kPrimaryStart,
                                            kPrimaryEnd,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 100.0,
                                            minHeight:
                                                7.0), // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          child: Text(
                                            'close'.tr().toString(),
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
                                ),
                              ],
                            );
                          } else {
                            return Expanded(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Expanded(
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: new FutureBuilder<
                                                  List<Messages>>(
                                                future: _future,
                                                //we pass a BuildContext and an AsyncSnapshot object which is an
                                                //Immutable representation of the most recent interaction with
                                                //an asynchronous computation.
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<Messages> mess =
                                                        snapshot.data;
                                                    return new Mess(mess);
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text("null"
                                                                .tr()
                                                                .toString()),
                                                            Icon(
                                                              Icons
                                                                  .no_cell_sharp,
                                                              size: 30,
                                                            ),
                                                          ],
                                                        ));
                                                  }
                                                  //return  a circular progress indicator.
                                                  return CircularProgressIndicator();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[
                                            kPrimaryEnd,
                                            kPrimaryStart
                                          ]),
                                    ),
                                    child: FutureBuilder(
                                      future: check(
                                          widget.value.status,
                                          '${widget.value.username_emp}',
                                          '${widget.value.username_tech}'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: 35,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: kPrimaryWhite,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  80.0)),
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          controllersend,
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                          fontFamily: 'Acme',
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  kPrimaryNone),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  kPrimaryNone),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    send(widget.value.id,
                                                        controllersend.text);
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.0)),
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Ink(
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: <Color>[
                                                          kPrimaryStart,
                                                          kPrimaryEnd,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  80.0)),
                                                    ),
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 20.0,
                                                              minHeight:
                                                                  6.0), // min sizes for Material buttons
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 5, 0, 5),
                                                        child: Text(
                                                          'send'
                                                              .tr()
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Acme',
                                                              color:
                                                                  kPrimaryWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 35,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: kPrimaryBlue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                  }
                }),
            FutureBuilder(
                future: checktech(
                    widget.value.status,
                    '${widget.value.username_emp}',
                    '${widget.value.username_tech}'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _isVisible2
                        ? Expanded(
                            child: ListView(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                  child: TextField(
                                    controller: descripController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: "descrip".tr().toString(),
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    solutions(widget.value.id,
                                        descripController.text);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          kPrimaryStart,
                                          kPrimaryEnd,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(80.0)),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 20.0,
                                          minHeight:
                                              7.0), // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            1, 2, 1, 2),
                                        child: Text(
                                          'send'.tr().toString(),
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
                              ],
                            ),
                          )
                        : Container();
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
