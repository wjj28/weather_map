import 'package:flutter/material.dart';
import '../screens/loading_screen.dart';
import 'dart:convert';

// http package
import 'package:http/http.dart' as http;

// String key = "941fa85ed52e855eed1105a100aac488";

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      return decodedData;
    } else{
      print(response.statusCode);
    }
  }
}
