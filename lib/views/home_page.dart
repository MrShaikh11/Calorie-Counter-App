import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/services/model.dart';
import 'package:mynotes/views/added_view.dart';
import 'dart:developer' as logu;
import 'package:mynotes/views/search_view.dart';
import '../services/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _name;
  late final TextEditingController _cal;
  Future<CalorieCounter>? _futureFood;
  Future<List>? _data;

  @override
  void initState() {
    _name = TextEditingController();
    _cal = TextEditingController();
    _data = obj.getAddedData();
  }

  bool valueDis = false;
  void changeData() {
    setState(() {
      // valueDis = true;
    });
  }

  FetchCal obj = FetchCal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.refresh),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Calorita',
          style: TextStyle(
            fontFamily: "Dancing Script",
            fontSize: 30,
          ),
        ),

        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(20),
        //       bottomRight: Radius.circular(20),
        //     ),
        //     color: Color(0xFF674AEF),
        //   ),
        // ),
        backgroundColor: const Color(0xFF674AEF),

        actions: [
          PopupMenuButton<MenuAction>(
              icon: const Icon(Icons.account_circle, size: 25),
              onSelected: (value) async {
                // print(value);
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogOutDialog(context);
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
                    child: Center(
                      child: Text(
                        "Logout",
                      ),
                    ),
                  )
                ];
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Center(
                child: Text(
                  "Ready to Count your calories? ",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Secular One",
                  ),
                ),
              ),
            ),
          ),
          Container(
              width: 150, child: Image.asset('assets/images/homescreen.png')),
          // Container(
          //   color: const Color(0xFF674AEF),
          //   height: 200,
          //   // width: MediaQuery.of(context).size.width,
          //   width: 400,
          //   margin: const EdgeInsets.all(10),
          //   child: Center(
          //     child: FutureBuilder(
          //         future: _data,
          //         builder: (context, snapshot) {
          //           // logu.log('message');
          //           var myList = snapshot.data;
          //           // logu.log(myList.toString());
          //           int total = 0;
          //           // total += int.parse(item.cal)
          //           // print(total.runtimeType);
          //           myList?.forEach(
          //               (item) => total += int.parse(item.cal.toString()));
          //           if (snapshot.hasData) {
          //             valueDis
          //                 ? myList?.forEach(
          //                     (item) => total += int.parse(item.cal.toString()))
          //                 : total;
          //             // return valueDis
          //             //     ? Text('Total Calories:  $total')
          //             //     : Text('Total Calories are:  $total');
          //             return Text('Total Calories: $total');
          //           } else {
          //             return const Center(
          //               child:
          //                   // Text('Hello')
          //                   CircularProgressIndicator(),
          //             );
          //           }
          //         }),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 45, 25, 30),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 10, 5, 5),
                      child: Text(
                        "Calories",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: "Secular One",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 35, 0, 5),
                      child: FutureBuilder(
                          future: _data,
                          builder: (context, snapshot) {
                            // logu.log('message');
                            var myList = snapshot.data;
                            // logu.log(myList.toString());
                            int total = 0;
                            // total += int.parse(item.cal)
                            print(total.runtimeType);
                            myList?.forEach((item) =>
                                total += int.parse(item.cal.toString()));
                            if (snapshot.hasData) {
                              valueDis
                                  ? myList?.forEach((item) =>
                                      total += int.parse(item.cal.toString()))
                                  : total;
                              // return valueDis
                              //     ? Text('Total Calories:  $total')
                              //     : Text('Total Calories are:  $total');
                              return Text(
                                '$total',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              );
                            } else {
                              return const Center(
                                child:
                                    // Text('Hello')
                                    CircularProgressIndicator(),
                              );
                            }
                          }),
                      // child: Text(
                      //   "1034",
                      //   style: TextStyle(color: Colors.black, fontSize: 30),
                      // ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                // Container(
                //   height: 50,
                //   width: 125,
                //   decoration: BoxDecoration(
                //     color: const Color(0xFF674AEF),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                SizedBox(
                  height: 50, //height of button
                  width: 130,

                  child: ElevatedButton(
                    onPressed: () async {
                      // logu.log(refresh);
                      String refresh = await showSearch(
                          context: context, delegate: SearchView());
                      // Navigator.of(context)
                      //     .push(
                      //       new MaterialPageRoute(builder: (_) => new PageTwo()),
                      //     )
                      await showSearch(context: context, delegate: SearchView())
                          .then((val) => val ? changeData() : null);

                      if (refresh == 'refresh') {
                        changeData();
                      }
                    },
                    // style: ButtonStyle(backgroundColor:  const Color(0xFF674AEF),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF674AEF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'ADD FOOD',
                      style: TextStyle(
                        fontFamily: "Secular One",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       // logu.log(refresh);
          //       String refresh =
          //           await showSearch(context: context, delegate: SearchView());
          //       // Navigator.of(context)
          //       //     .push(
          //       //       new MaterialPageRoute(builder: (_) => new PageTwo()),
          //       //     )
          //       await showSearch(context: context, delegate: SearchView())
          //           .then((val) => val ? changeData() : null);

          //       if (refresh == 'refresh') {
          //         changeData();
          //       }
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.black,
          //       minimumSize: const Size.fromHeight(30), // NEW
          //     ),
          //     child: const Text('ADD FOOD!'),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: ElevatedButton(
              onPressed: () async {
                showSearch(context: context, delegate: AddedView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF674AEF),
                minimumSize: const Size.fromHeight(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Added Food List',
                style: TextStyle(
                  fontFamily: "Secular One",
                ),
              ),
            ),
          ),
          // Container(
          //   height: 100,
          //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //   child: FutureBuilder(
          //       future: obj.getAddedData(),
          //       builder: (context, snapshot) {
          //         print(snapshot.data?.length);
          //         if (snapshot.data?.length == 0) {
          //           return const Center(
          //             child: Text("No data"),
          //           );
          //         } else if (snapshot.hasData) {
          //           return ListView.builder(
          //             itemCount: snapshot.data?.length,
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               return InkWell(
          //                 onTap: () {
          //                   // log(snapshot.data?[index]);
          //                 },
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       color: Colors.yellow,
          //                       borderRadius: BorderRadius.circular(12),
          //                     ),
          //                     child: Column(
          //                       children: [
          //                         ListTile(
          //                           title: Text(snapshot.data?[index].name),
          //                           subtitle: Text(
          //                             "Calories: ${snapshot.data?[index].cal} calories",
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         } else {
          //           return const Center(
          //             child:
          //                 // Text('Hello')
          //                 CircularProgressIndicator(),
          //           );
          //         }
          //       }),
          // )
        ],
      ),
    );
  }
}
