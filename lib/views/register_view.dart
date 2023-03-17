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
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter you Email"),
            controller: _email,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter you Password"),
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
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  // print(userCredentials);
                  devtools.log(userCredentials.toString());
                  await successDialog(context, 'Registeration Successfull');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    // print("Weak Password");
                    // devtools.log('Weak Password');
                    await showErrorDialog(context, 'Weak Password');
                  } else if (e.code == 'email-already-in-use') {
                    // print("Email is already in Use");
                    // devtools.log('Email is already in Use');
                    await showErrorDialog(context, 'Email already in use');
                  } else if (e.code == 'invalid-email') {
                    // print('Invalid Email Entered');
                    // devtools.log('Invalid Email Entered');
                    await showErrorDialog(context, 'Invalid Email');
                  } else {
                    // print(e);
                    // devtools.log(e.toString());
                    await showErrorDialog(context, 'Error: ${e.code}');
                  }
                } catch (e) {
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
    );
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
