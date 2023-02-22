import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // create variable
  late final TextEditingController _email;
  late final TextEditingController _password;
  // function to initiate the State of the variable
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  // function to dispose the State of the variable
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        // FutureBuilder : widget to manage asynchronous response from Firebase
        body: FutureBuilder(
          // future : take the asynchronous function, here the app inialization
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          // builder : allow to adapt display depending on the state of the asynchronous response
          builder: (context, snapshot) {
            // Switch depending on display
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      // use the created states in the controller of the textField
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email here',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      // options for password fields
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password here',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);

                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print("User not Found");
                          } else if (e.code == 'wrong-password') {
                            print("Wrong Password");
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                );
              default:
                return const Text('Loading...');
            }
          },
        ));
  }
}
