import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'utilities/showErrorDialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 120, // Set this height,
          centerTitle: true,
          title: const Text('REGISTER'),
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
          margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        });
                    await Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
                    );
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      final userCredentials = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);
                      // print(userCredentials);
                      devtools.log(userCredentials.toString());
                      Navigator.of(context).pop();

                      await successDialog(context, 'Registration Successfull');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        Navigator.of(context).pop();

                        // print("Weak Password");
                        // devtools.log('Weak Password');
                        await showErrorDialog(context, 'Weak Password');
                      } else if (e.code == 'email-already-in-use') {
                        Navigator.of(context).pop();

                        // print("Email is already in Use");
                        // devtools.log('Email is already in Use');
                        await showErrorDialog(context, 'Email already in use');
                      } else if (e.code == 'invalid-email') {
                        Navigator.of(context).pop();

                        // print('Invalid Email Entered');
                        // devtools.log('Invalid Email Entered');
                        await showErrorDialog(context, 'Invalid Email');
                      } else {
                        Navigator.of(context).pop();

                        // print(e);
                        // devtools.log(e.toString());
                        await showErrorDialog(context, 'Error: ${e.code}');
                      }
                    } catch (e) {
                      Navigator.of(context).pop();

                      await showErrorDialog(
                        context,
                        e.toString(),
                      );
                    }
                  },
                  child: const Text('Register')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: const Text('Already a User? Sign in!'))
            ],
          ),
        ));
  }
}

Future<void> successDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Congratulations!'),
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
