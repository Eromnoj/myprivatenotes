import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                final user = FirebaseAuth.instance.currentUser;

                if (user?.emailVerified ?? false) {
                  print('You are a verified user');
                } else {
                  print('Verify your email first');
                }
                return const Text('Done');
              default:
                return const Text('Loading...');
            }
          },
        ));
  }
}
