import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/views/utilities/showErrorDialog.dart';
import '../services/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String defaultValue = "";
  FetchCal obj = new FetchCal();

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
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         hintText: "Add Food",
                  //         hintStyle:
                  //             TextStyle(color: Colors.black.withOpacity(0.5)),
                  //         prefixIcon: Icon(Icons.add, size: 25)),
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.numbers),
                    //   ),
                    //   hint: Text('Quantity'),
                    //   items: <String>['100gm', '200gm', '300gm', '400gm']
                    //       .map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: new Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (_) {},
                    // ),
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
          ),
          FutureBuilder(
              future: obj.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        // height: 120,
                        color: Colors.greenAccent,

                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: ${snapshot.data?[index].name}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Calories: ${snapshot.data?[index].cal} calories",
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }
}
