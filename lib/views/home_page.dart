import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/views/utilities/showErrorDialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List list = [
    'item',
    'item',
    'item',
    'item',
    'item',
  ];
  List dropDownListData = [
    {"title": "100gm", "value": "1"},
    {"title": "200gm", "value": "2"},
    {"title": "300gm", "value": "3"},
    {"title": "400gm", "value": "4"},
  ];
  String defaultValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Main UI"),
      //   actions: [
      //     PopupMenuButton<MenuAction>(onSelected: (value) async {
      //       // print(value);
      //       switch (value) {
      //         case MenuAction.logout:
      //           final shouldLogOut = await showLogOutDialog(context);
      //           // devtools.log(shouldLogOut.toString());
      //           if (shouldLogOut) {
      //             await FirebaseAuth.instance.signOut();
      //             Navigator.of(context).pushNamedAndRemoveUntil(
      //               loginRoute,
      //               (_) => false,
      //             );
      //           }
      //       }
      //     }, itemBuilder: (context) {
      //       return const [
      //         PopupMenuItem<MenuAction>(
      //           value: MenuAction.logout,
      //           child: Text("Logout"),
      //         )
      //       ];
      //     })
      //   ],
      // ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Color(0xFF674AEF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<MenuAction>(
                          color: Colors.white,
                          icon: Icon(Icons.account_circle, size: 25),
                          onSelected: (value) async {
                            // print(value);
                            switch (value) {
                              case MenuAction.logout:
                                final shouldLogOut =
                                    await showLogOutDialog(context);
                                // devtools.log(shouldLogOut.toString());
                                if (shouldLogOut) {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginRoute,
                                    (_) => false,
                                  );
                                }
                            }
                          },
                          itemBuilder: (context) {
                            return const [
                              PopupMenuItem<MenuAction>(
                                value: MenuAction.logout,
                                child: Text(
                                  "Logout",
                                ),
                              )
                            ];
                          })
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      "TRACK YOUR CALORIES!!!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    // width: MediaQuery.of(context).size.width,
                    // width: 200,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add Food",
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          prefixIcon: Icon(Icons.add, size: 25)),
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 5, bottom: 20),
                  //   // width: MediaQuery.of(context).size.width,
                  //   // width: 200,
                  //   height: 40,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //         isDense: true,
                  //         value: defaultValue,
                  //         isExpanded: true,
                  //         menuMaxHeight: 350,
                  //         items: [
                  //           const DropdownMenuItem(
                  //               child: Text(
                  //                 "Select Quantity",
                  //               ),
                  //               value: ""),
                  //           ...dropDownListData
                  //               .map<DropdownMenuItem<String>>((data) {
                  //             return DropdownMenuItem(
                  //                 child: Text(data['title']),
                  //                 value: data['value']);
                  //           }).toList(),
                  //         ],
                  //         onChanged: (value) {
                  //           print("selected Value $value");
                  //           setState(() {
                  //             defaultValue = value!;
                  //           });
                  //         }),
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      hint: Text('Quantity'),
                      items: <String>['100gm', '200gm', '300gm', '400gm']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: const Size.fromHeight(40), // NEW
                    ),
                    onPressed: () {},
                    child: Text("Add Food"),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
