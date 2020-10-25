import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';

import 'head_contain.dart';
import 'package:http/http.dart' as http;

Future<List<Report>> downloadJSONMyReport() async {
  final jsonEndpoint = "http://192.168.2.24/LoginRegister/public/api/history";

  final response = await http.post(jsonEndpoint, body: {
    "username": await FlutterSession().get("username"),
  });
  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Report>> downloadJSONProcess() async {
  final jsonEndpoint = "http://192.168.2.24/LoginRegister/public/api/process";

  final response = await http.post(jsonEndpoint, body: {
    "username": await FlutterSession().get("username"),
  });
  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

Future<List<Report>> downloadJSONApprod() async {
  final jsonEndpoint = "http://192.168.2.24/LoginRegister/public/api/approd";

  final response = await http.post(jsonEndpoint, body: {
    "username": await FlutterSession().get("username"),
  });
  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
