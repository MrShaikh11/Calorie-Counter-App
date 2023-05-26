import 'package:flutter/material.dart';
import 'package:mynotes/views/utilities/showErrorDialog.dart';
import '../services/api_service.dart';
import 'register_view.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        // toolbarHeight: 120, // Set this height,
        centerTitle: true,
        title: const Text(
          'ADD NEW ITEM',
          style: TextStyle(
              // fontFamily: "Secular One",
              ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(20),
            //   bottomRight: Radius.circular(20),
            // ),
            color: Color(0xFF674AEF),
            // color: Colors.red,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // color: const Color(0xFF674AEF),

            // color: Colors.blueGrey,
            height: 260,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(15, 80, 15, 110),
            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color.fromARGB(255, 172, 159, 229),
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
                  TextField(
                    controller: _qty,
                    decoration: const InputDecoration(
                      hintText: 'Enter Quantity',
                      hintStyle: TextStyle(
                          // color: Colors.white,
                          ),
                    ),
                  ),
                  // DropdownButton<String>(
                  //   value: value,
                  //   items: items.map(buildMenuItem).toList(),
                  //   onChanged: (value) => this.value = value,
                  // ),
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
                          await postToFood(
                              _name.text, int.parse(_cal.text), _qty.text);
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

                        backgroundColor:
                            Colors.black, // background (button) color
                        foregroundColor:
                            Colors.white, // foreground (text) color
                      ),
                      child: const Text('Create Data'),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
