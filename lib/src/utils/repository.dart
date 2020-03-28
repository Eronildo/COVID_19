import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;

import 'package:covid19/src/models/data.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String _url = 'https://api.covid19api.com/summary';

  Future<Data> getData() async {
    final response = await http.get(_url).timeout(Duration(minutes: 1));
    if (response.statusCode == HttpStatus.ok) {
      var bodyJson = json.decode(response.body);
      var data = Data.fromJson(bodyJson);
      return data;
    } else {
      return null;
    }
  }
}
