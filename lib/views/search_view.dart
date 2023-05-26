import 'package:flutter/material.dart';
import 'package:mynotes/services/api_service.dart';
import 'dart:developer' as logu;
import '../constants/routes.dart';
import '../services/argument.dart';
import 'addToList.dart';

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
          future: obj.getSelectedData(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            // await confirmDialogue(
                            //   context,
                            //   snapshot.data?[index].name,
                            //   snapshot.data?[index].name,
                            //   snapshot.data?[index].cal,
                            //   snapshot.data?[index].qty,
                            // );

                            // logu.log(quant);
                            // if (snapshot.data?[index].qty == 'grams') {
                            //   quant = snapshot.data?[index].qty;
                            // } else {
                            //   quant = '100 grams';
                            // }
                          },
                          child: Card(
                            color: Color.fromARGB(255, 172, 159, 229),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name: ${snapshot.data?[index].name}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Calories(per ${snapshot.data?[index].qty}): ${snapshot.data?[index].cal} calories",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
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
          future: obj.getSelectedData(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            // await confirmDialogue(
                            //   context,
                            //   snapshot.data?[index].name,
                            //   snapshot.data?[index].name,
                            //   snapshot.data?[index].cal,
                            //   snapshot.data?[index].qty,
                            // );

                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     addToListPage, (route) => false,
                            //     arguments: AddToList());
                            Navigator.pushNamed(
                              context,
                              addToListPage,
                              arguments: FormData(
                                  snapshot.data?[index].name,
                                  '${snapshot.data?[index].cal}',
                                  snapshot.data?[index].qty),
                            );
                            // logu.log(quant);
                            // if (snapshot.data?[index].qty == 'grams') {
                            //   quant = snapshot.data?[index].qty;
                            // } else {
                            //   quant = '100 grams';
                            // }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color.fromARGB(255, 172, 159, 229),
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name: ${snapshot.data?[index].name}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Calories(per ${snapshot.data?[index].qty == 'grams' ? '100 grams' : 'piece'}): ${snapshot.data?[index].cal} calories",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
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

// Future<void> confirmDialogue(
//     BuildContext context, String text, String name, int cal, String qty) {
//   // logu.log(name);
// //   return showDialog(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //         title: const Text(
// //           'Please Confirm if you want to add !',
// //         ),
// //         content: Text('Name: $text, Calories(per $qty): $cal'),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //             child: const Text('NO'),
// //           ),
// //           TextButton(
// //             onPressed: () async {
// //               Navigator.of(context).pop();
// //               await addedDialogue(context, 'ADDED!');
// //               postToAdded(name, cal);
// //             },
// //             child: const Text('YES'),
// //           ),
// //         ],
// //       );
// //     },
// //   );
// // }
