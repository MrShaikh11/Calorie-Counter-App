import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynotes/services/api_service.dart';

class AddedView extends SearchDelegate {
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
    FetchCal obj = new FetchCal();
    num total = 0;
    return FutureBuilder(
        future: obj.getSelectedAddedData(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // total =total+ snapshot.data?[index].cal;
                return Card(
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
        future: obj.getSelectedAddedData(query),
        builder: (context, snapshot) {
          print(snapshot.data?.length);
          if (snapshot.data?.length == 0) {
            return const Center(
              child: Text("No data"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
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
                );
              },
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
