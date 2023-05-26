import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynotes/services/api_service.dart';

import '../constants/routes.dart';

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
          // Navigator.pop(context, true);
          Navigator.of(context).pushNamedAndRemoveUntil(
            homePage,
            (_) => false,
          );
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    FetchCal obj = new FetchCal();
    num total = 0;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          homePage,
          (_) => false,
        );

        return false;
      },
      child: FutureBuilder(
          future: obj.getSelectedAddedData(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // total =total+ snapshot.data?[index].cal;
                  return InkWell(
                    onTap: () {
                      log(snapshot.data?[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 172, 159, 229),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                            title: Text(
                              snapshot.data?[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Calories: ${snapshot.data?[index].cal} calories",
                            ),
                            trailing: IconButton(
                              // onPressed: () async {
                              //   log('Delete bhenchod');
                              //   await deleteAdded(snapshot.data?[index].id);
                              // },
                              onPressed: () async {
                                // logu.log('Pressed yellow');
                                await confirmDeleteDialog(
                                    context,
                                    snapshot.data?[index].name,
                                    snapshot.data?[index].name,
                                    snapshot.data?[index].cal,
                                    snapshot.data?[index].id);
                                // logu.log(snapshot.data?[index].name);
                              },
                              icon: Icon(Icons.delete),
                            )),
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
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    FetchCal obj = FetchCal();
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          homePage,
          (_) => false,
        );

        return false;
      },
      child: FutureBuilder(
          future: obj.getSelectedAddedData(query),
          builder: (context, snapshot) {
            print(snapshot.data?.length);
            if (snapshot.data?.length == 0) {
              return const Center(
                child: Text("No data"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      log(snapshot.data?[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 172, 159, 229),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                            title: Text(
                              snapshot.data?[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Total Calories: ${snapshot.data?[index].cal} cal",
                              // style: const TextStyle(
                              //   fontSize: 18,
                              //   color: Colors.black,
                              // ),
                            ),
                            trailing: IconButton(
                              // onPressed: () async {
                              //   log('Delete bhenchod');
                              //   await deleteAdded(snapshot.data?[index].id);
                              // },
                              onPressed: () async {
                                // logu.log('Pressed yellow');
                                await confirmDeleteDialog(
                                    context,
                                    snapshot.data?[index].name,
                                    snapshot.data?[index].name,
                                    snapshot.data?[index].cal,
                                    snapshot.data?[index].id);
                                // logu.log(snapshot.data?[index].name);
                              },
                              icon: Icon(Icons.delete),
                            )),
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
          }),
    );
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

Future<void> confirmDeleteDialog(
    BuildContext context, String text, String name, int cal, int id) {
  // logu.log(name);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Please Confirm if you want to DELETE !',
        ),
        content: Text('Name: $text, Calories: $cal'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () async {
              deleteAdded(id);
              showSearch(context: context, delegate: AddedView());
            },
            child: const Text('YES'),
          ),
        ],
      );
    },
  );
}
