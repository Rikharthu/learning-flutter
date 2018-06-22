import 'dart:async';
import "package:http/http.dart" as http;
import 'package:klimatic/constants.dart';


Future<dynamic> getCurrentWeather(String city, [String countryCode]) {
  var url = "$API_BASE_URL?q=$city${countryCode == null
      ? ""
      : ",$countryCode"}"
      "&appId=$API_KEY"
      "&units=metric";
  return http.get(url);
}
