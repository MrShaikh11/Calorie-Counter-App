// import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/add_new.dart';
import 'package:mynotes/views/home_page.dart';
import 'package:mynotes/views/login_view.dart';
import 'views/addToList.dart';
import 'views/added_view.dart';
import 'views/register_view.dart';
// import 'dart:developer' as devtools show log;

void main() {
  final Color myColor = Color(0xFF674AEF);

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {
      50: color.withOpacity(strengths[0]),
      100: color.withOpacity(strengths[0] * 2),
      200: color.withOpacity(strengths[0] * 3),
      300: color.withOpacity(strengths[0] * 4),
      400: color.withOpacity(strengths[0] * 5),
      500: color.withOpacity(strengths[0] * 6),
      600: color.withOpacity(strengths[0] * 7),
      700: color.withOpacity(strengths[0] * 8),
      800: color.withOpacity(strengths[0] * 9),
      900: color.withOpacity(strengths[0] * 10),
    };
    return MaterialColor(color.value, swatch);
  }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Secular One",
        primarySwatch: createMaterialColor(myColor),
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const HomePage(),
        addRoute: (context) => const AddNew(),
        homePage: (context) => const HomeView(),
        addToListPage: (context) => AddToList(),
        // searchRoute: (context) =>  SearchView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return const HomeView();
            } else {
              return const LoginView();
            }
          default:
            // print('loading');
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

// class NotesView extends StatefulWidget {
//   const NotesView({super.key});

//   @override
//   State<NotesView> createState() => _NotesViewState();
// }

// class _NotesViewState extends State<NotesView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Main UI"),
//         actions: [
//           PopupMenuButton<MenuAction>(onSelected: (value) async {
//             // print(value);
//             switch (value) {
//               case MenuAction.logout:
//                 final shouldLogOut = await showLogOutDialog(context);
//                 // devtools.log(shouldLogOut.toString());
//                 if (shouldLogOut) {
//                   await FirebaseAuth.instance.signOut();
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     loginRoute,
//                     (_) => false,
//                   );
//                 }
//             }
//           }, itemBuilder: (context) {
//             return const [
//               PopupMenuItem<MenuAction>(
//                 value: MenuAction.logout,
//                 child: Text("Logout"),
//               )
//             ];
//           })
//         ],
//       ),
//       body: const Text('Hello World'),
//     );
//   }
// }

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Sign Out',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            "Are you sure you want to sign out?",
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Log Out")),
          ],
        );
      }).then((value) => value ?? false);
}
