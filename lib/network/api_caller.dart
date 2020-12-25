import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiCaller {
  final String baseUrl = "http://data.fixer.io/api/";
  final String apiToken = "a79979a1ef421eaf6ea38a6a0ed278c8";

  Future<Map> getAllSymbols() async {
    try {

      var endPoint = "symbols?access_key=" + apiToken;

      var response = await http.get(baseUrl + endPoint);
      var decodedBody = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedBody["success"] != null &&
          decodedBody["success"]) {
        return decodedBody["symbols"];
      } else {
        throw Exception(decodedBody["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> getAllRatesBasedOnEUR() async {
    try {
      final DateTime nowDate = DateTime. now();
      final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      final String dateFormatted = dateFormatter. format(nowDate);
      var endPoint = "$dateFormatted?access_key=" + apiToken;

      var response = await http.get(baseUrl + endPoint);
      var decodedBody = json.decode(response.body);
      if (response.statusCode == 200 &&
          decodedBody["success"] != null &&
          decodedBody["success"]) {
        return decodedBody["rates"];
      } else {
        throw Exception(decodedBody["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      rethrow;
    }
  }
}
