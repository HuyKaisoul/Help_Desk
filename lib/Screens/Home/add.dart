import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:Help_Desk/constrain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String base64Image;

  File imageFile;
  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descripController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      if (picture != null) {
        imageFile = File(picture.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse(
        "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['username'] = await FlutterSession().get("username");
    request.fields['address'] = addressController.text;
    request.fields['descrip'] = descripController.text;
    request.fields['title'] = titleController.text;
    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              content: Row(
                children: <Widget>[
                  Text("Successful"),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            );
          });
    } else {
      print('Image Not Uploded');
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Make a Choice"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Add Report",
                  style: TextStyle(
                    fontFamily: 'Acme',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            labelText: "Title",
                            labelStyle: TextStyle(fontFamily: 'Acme')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: TextField(
                        controller: descripController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Decription",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                            labelText: "Addrees",
                            labelStyle: TextStyle(fontFamily: 'Acme')),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 20, right: 40),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    _showChoiceDialog(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
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
                                          Radius.circular(50.0)),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 90.0,
                                          minHeight:
                                              40.0), // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 6, 0, 6),
                                        child: const Text(
                                          'Image',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Acme',
                                              color: kPrimaryWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 20, left: 40),
                          child: RaisedButton(
                            onPressed: () {
                              uploadImage();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    kPrimaryEnd,
                                    kPrimaryStart,
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 90.0,
                                    minHeight:
                                        40.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                  child: const Text(
                                    'Send',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Acme',
                                        color: kPrimaryWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            imageFile == null
                                ? Text('No image selected.')
                                : Image.file(
                                    imageFile,
                                    width: 300,
                                    height: 300,
                                  ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
