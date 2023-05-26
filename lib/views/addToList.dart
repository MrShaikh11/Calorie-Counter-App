import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/views/utilities/showErrorDialog.dart';
import '../services/api_service.dart';
import '../services/argument.dart';
import 'register_view.dart';
import 'search_view.dart';

class AddToList extends StatefulWidget {
  @override
  State<AddToList> createState() => _AddToListState();
}

class _AddToListState extends State<AddToList> {
  late final TextEditingController _name;
  late final TextEditingController _cal;
  late final TextEditingController _qty;

  final items = ['100 grams', 'piece'];
  String? value;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _cal = TextEditingController();
    _qty = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var formData = ModalRoute.of(context)!.settings.arguments as FormData;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
            onPressed: () =>
                showSearch(context: context, delegate: SearchView())),
        // toolbarHeight: 120, // Set this height,
        centerTitle: true,
        title: const Text('ADD TO LIST'),
        flexibleSpace: Container(
            // decoration: const BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(20),
            //     bottomRight: Radius.circular(20),
            // ),
            // color: Color(0xFF674AEF),
            // color: Colors.red,
            // ),
            ),
        // backgroundColor: Colors.transparent,
        backgroundColor: Color(0xFF674AEF),
      ),
      body: Container(
        // color: const Color(0xFF674AEF),

        // color: Colors.blueGrey,
        height: 300,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(15, 80, 15, 110),
        padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: Color.fromARGB(255, 172, 159, 229),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter the number of ${formData.quant == 'grams' ? 'grams' : 'pieces'} you had',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19  ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Name: ${formData.name}',
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Calories per ${formData.quant == 'grams' ? '100 grams' : 'piece'}: ${formData.message}',
              style: TextStyle(fontSize: 17),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Enter Quantity'),
                textAlign: TextAlign.center,
                controller: _qty,
              ),
            ),
            // ElevatedButton(
            // onPressed: () async {
            //   showDialog(
            //       context: context,
            //       builder: (context) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       });
            //   // setState(
            //   //   () {
            //   //     postToFood(_name.text, int.parse(_cal.text));
            //   //   },
            //   // );
            //   try {
            //     var calorie = int.parse(formData.message);
            //     if (formData.quant == "grams") {
            //       // calorie = (calorie / 100) as int;
            //       calorie = (calorie ~/ 100).toInt();
            //     }

            //     await postToAdded(formData.name, calorie, formData.quant,
            //         int.parse(_qty.text));
            //     Navigator.of(context).pop();

            //     await addToListDialog(context, "Added Succesfully");
            //   } catch (e) {
            //     Navigator.of(context).pop();

            //     await showErrorDialog(
            //       context,
            //       e.toString(),
            //     );
            //   }
            // },
            //     child: Text("Add to List"))
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  // setState(
                  //   () {
                  //     postToFood(_name.text, int.parse(_cal.text));
                  //   },
                  // );
                  try {
                    var calorie = int.parse(formData.message);
                    if (formData.quant == "grams") {
                      // calorie = (calorie / 100) as int;
                      calorie = (calorie ~/ 100).toInt();
                    }

                    await postToAdded(formData.name, calorie, formData.quant,
                        int.parse(_qty.text));
                    Navigator.of(context).pop();

                    await addToListDialog(context, "Added Succesfully");
                  } catch (e) {
                    Navigator.of(context).pop();

                    await showErrorDialog(
                      context,
                      e.toString(),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(30), // NEW

                  backgroundColor: Colors.black, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                ),
                child: const Text('ADD TO LIST'),
              ),
            ),

            // DropdownButton<String>(
            //   value: value,
            //   items: items.map(buildMenuItem).toList(),
            //   onChanged: (value) => this.value = value,
            // ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       showDialog(
            //           context: context,
            //           builder: (context) {
            //             return const Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           });
            //       // setState(
            //       //   () {
            //       //     postToFood(_name.text, int.parse(_cal.text));
            //       //   },
            //       // );
            //       try {
            //         await postToFood(
            //             _name.text, int.parse(_cal.text), _qty.text);
            //         Navigator.of(context).pop();

            //         await successDialog(context, "Added Succesfully");
            //       } catch (e) {
            //         Navigator.of(context).pop();

            //         await showErrorDialog(
            //           context,
            //           e.toString(),
            //         );
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       minimumSize: const Size.fromHeight(30), // NEW

            //       backgroundColor: Colors.black, // background (button) color
            //       foregroundColor: Colors.white, // foreground (text) color
            //     ),
            //     child: const Text('Create Data'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

Future<void> addToListDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Congratulations!'),
        content: Text(text),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  homePage,
                  (_) => false,
                );
              },
              child: const Text('OK'))
        ],
      );
    },
  );
}
