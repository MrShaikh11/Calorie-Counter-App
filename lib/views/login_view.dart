import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import '../firebase_options.dart';
import 'utilities/showErrorDialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 120, // Set this height,
            centerTitle: true,
            title: const Text('LOGIN'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xFF674AEF),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            // margin: EdgeInsets.all(24),
            margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter you Email",
                    prefixIcon: Icon(Icons.email, size: 25),
                  ),
                  controller: _email,
                ),
                SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: "Enter you Password",
                    prefixIcon: Icon(Icons.password, size: 25),
                  ),
                  controller: _password,
                ),
                TextButton(
                  onPressed: () async {
                    await Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    );
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      final userCredentials = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password);
                      devtools.log(userCredentials.toString());
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        await showErrorDialog(context, 'User Not Found');
                        devtools.log('User not found');
                      } else if (e.code == 'wrong-password') {
                        await showErrorDialog(context, 'Wrong Credentials');
                        // devtools.log('Wrong Password    ');
                        // print(e.code);
                      } else {
                        await showErrorDialog(
                          context,
                          'Error: ${e.code}',
                        );
                      }
                    } catch (e) {
                      await showErrorDialog(
                        context,
                        e.toString(),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF674AEF),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false);
                  },
                  child: const Text(
                    'Not Registered Yet? Register Here!',
                    style: TextStyle(
                      color: Color(0xFF674AEF),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
