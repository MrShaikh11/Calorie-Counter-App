import 'dart:convert';
import 'dart:developer' as logu;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mynotes/services/model.dart';

class FetchCal {
  List<CalorieCounter> sample = [];

  Future<List> getData() async {
    print("hello from get data");
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

  Future<List> getAddedData() async {
    print("hello from get data");
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/today/'));

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

  Future<List> getSelectedData(String? query) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/foods/'));

    var data = jsonDecode(response.body.toString());

    logu.log('data: $data');

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sample.add(CalorieCounter.fromJson(index));
      }
      sample = sample
          .where((element) =>
              element.name!.toLowerCase().contains(query!.toLowerCase()))
          .toList();

      return sample;
    } else {
      return sample;
    }
  }

  Future<List> getSelectedAddedData(String? query) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/today/'));

    var data = jsonDecode(response.body.toString());

    logu.log('data: $data');

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sample.add(CalorieCounter.fromJson(index));
      }
      sample = sample
          .where((element) =>
              element.name!.toLowerCase().contains(query!.toLowerCase()))
          .toList();

      return sample;
    } else {
      return sample;
    }
  }
}

Future<CalorieCounter> postToFood(String name, int cal) async {
  logu.log('Posting');
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/foods/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        'name': name,
        'cal': cal,
      },
    ),
  );
  logu.log(response.statusCode.toString());

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    logu.log('hi');
    return CalorieCounter.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    logu.log(response.headers.toString());
    throw Exception('Failed to create album.');
  }
}

Future<CalorieCounter> postToAdded(String name, int cal) async {
  logu.log('PostingCrd');
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/today/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'cal': cal,
    }),
  );
  logu.log(response.statusCode.toString());

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    logu.log('hi');
    return CalorieCounter.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    logu.log(response.headers.toString());
    throw Exception('Failed to create album.');
  }
}
