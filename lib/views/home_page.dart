import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/services/model.dart';
import 'package:mynotes/views/added_view.dart';
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
  @override
  void initState() {
    _name = TextEditingController();
    _cal = TextEditingController();
  }

  FetchCal obj = FetchCal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calorie Counter'),
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
                    child: Text("Logout"),
                  )
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF674AEF),
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: Center(child: Text("hello")),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ElevatedButton(
              onPressed: () async {
                showSearch(context: context, delegate: SearchView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(30), // NEW
              ),
              child: const Text('ADD FOOD!'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ElevatedButton(
              onPressed: () async {
                showSearch(context: context, delegate: AddedView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(30), // NEW
              ),
              child: const Text('Added Food!'),
            ),
          )
        ],
      ),
    );
  }
}
