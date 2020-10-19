import 'dart:async';
import 'dart:convert';

import 'package:Help_Desk/constrain.dart';
import 'package:Help_Desk/report/detail/head_contain.dart';
import 'package:Help_Desk/report/detail/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'components/messages.dart';
import 'components/person.dart';

class SecondScreen extends StatefulWidget {
  final Report value;

  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Future<List<Messages>> _future;
  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
        _future = messages(widget.value.id);
      });
    });
  }

  TextEditingController controllersend = TextEditingController();
  Future<List<Messages>> send(int id, String text) async {
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

  Future<String> check(int status, String username, String techname) async {
    String checkname = await FlutterSession().get("username");
    String type = await FlutterSession().get("type");
    if (type == '2') {
      return ':Admin';
    } else if (type == '1') {
      if (status != 3) {
        if (techname == checkname) {
          return ': Me';
        }
      }
    } else {
      if (status != 3) {
        if (username == checkname) {
          return ': Me';
        }
      }
    }

    print(username +
        checkname +
        'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text('Detail Page')),
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
                          'Create : ${widget.value.create}',
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                      Padding(
                        child: new Text(
                          'Decription : ${widget.value.description}',
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  Padding(
                    child: new Text(
                      'Solution : ${widget.value.solution}',
                      style: new TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[kPrimaryEnd, kPrimaryStart]),
                        ),
                        child: Center(
                            child: Text(
                          "Feedback",
                          style: TextStyle(color: kPrimaryWhite),
                        )),
                      ),
                      Container(
                        child: new FutureBuilder<List<Messages>>(
                          future: _future,
                          //we pass a BuildContext and an AsyncSnapshot object which is an
                          //Immutable representation of the most recent interaction with
                          //an asynchronous computation.
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Messages> mess = snapshot.data;
                              return new Mess(mess);
                            } else if (snapshot.hasError) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Null"),
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
                    colors: <Color>[kPrimaryEnd, kPrimaryStart]),
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
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: kPrimaryWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: TextField(
                                controller: controllersend,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: 'Acme',
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kPrimaryNone),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kPrimaryNone),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: RaisedButton(
                            onPressed: () {
                              send(widget.value.id, controllersend.text);
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 20.0,
                                    minHeight:
                                        6.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: const Text(
                                    'SEND',
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
                    return Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
