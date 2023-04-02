import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mynotes/services/model.dart';

class FetchCal {
  List<CalorieCounter> sample = [];

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/foods/'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sample.add(CalorieCounter.fromJson(index));
      }

      return sample;
    } else {
      return sample;
    }
  }
}
