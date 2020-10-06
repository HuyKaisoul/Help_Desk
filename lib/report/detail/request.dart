import 'dart:convert';

import 'head_contain.dart';
import 'package:http/http.dart' as http;

Future<List<Report>> downloadJSON() async {
  final jsonEndpoint =
      "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/retrieve.php";

  final response = await http.get(jsonEndpoint);

  if (response.statusCode == 200) {
    List reports = json.decode(response.body);
    return reports.map((report) => new Report.fromJson(report)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
