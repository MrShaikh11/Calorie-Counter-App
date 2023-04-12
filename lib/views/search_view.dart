import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynotes/services/api_service.dart';
import 'dart:convert';
import 'dart:developer' as logu;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mynotes/services/model.dart';

import '../constants/routes.dart';

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    FetchCal obj = FetchCal();
    return FutureBuilder(
        future: obj.getSelectedData(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    logu.log('Pressed yellow');
                    await addedDialogue(context, 'Added ');
                  },
                  child: Card(
                    color: Colors.green,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name: ${snapshot.data?[index].name}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Calories: ${snapshot.data?[index].cal} calories",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    FetchCal obj = FetchCal();
    return FutureBuilder(
        future: obj.getSelectedData(query),
        builder: (context, snapshot) {
          logu.log('Snap: $snapshot.toString()');
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          logu.log("Hello");
                          logu.log(snapshot.data?[index].name);
                          postToAdded(snapshot.data?[index].name,
                              snapshot.data?[index].cal);
                        },
                        child: Card(
                          color: Colors.yellow,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name: ${snapshot.data?[index].name}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Calories: ${snapshot.data?[index].cal} calories",
                                  maxLines: 1,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(addRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: const Size.fromHeight(20), // NEW
                    ),
                    child: const Text(
                      'NOT IN LIST? CLICK HERE TO ADD!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child:
                  // Text('Hello')
                  CircularProgressIndicator(),
            );
          }
        });
  }
}

Future<void> addedDialogue(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Very Good!'),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
    },
  );
}
