import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mynotes/views/utilities/showErrorDialog.dart';

import '../services/api_service.dart';
import '../services/model.dart';
import 'register_view.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late final TextEditingController _name;
  late final TextEditingController _cal;
  Future<CalorieCounter>? _futureFood;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _cal = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 120, // Set this height,
        centerTitle: true,
        title: const Text('ADD NEW ITEM'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Color(0xFF674AEF),
            // color: Colors.red,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        // color: const Color(0xFF674AEF),

        // color: Colors.blueGrey,
        height: 240,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(10, 80, 10, 10),
        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: Colors.grey[300],
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  // hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(
                    // color: Colors.white,
                    ),
              ),
              TextField(
                controller: _cal,
                decoration: const InputDecoration(
                  hintText: 'Enter Calories',
                  hintStyle: TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
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
                      await postToFood(_name.text, int.parse(_cal.text));
                      Navigator.of(context).pop();

                      await successDialog(context, "Added Succesfully");
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
                  child: const Text('Create Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
