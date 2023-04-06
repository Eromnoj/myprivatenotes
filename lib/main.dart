import 'package:flutter/material.dart';
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/views/login_view.dart';
import 'package:myprivatenotes/views/notes/new_note_view.dart';
import 'package:myprivatenotes/views/notes/notes_view.dart';
import 'package:myprivatenotes/views/register_view.dart';
import 'package:myprivatenotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    // create named routes
    // Map with name of the route as key, and a function that calls the view
    // as value
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailViewRoute: (context) => const VerifyEmailView(),
      newNotesRoute: (context) => const NewNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future : take the asynchronous function, here the app inialization
      future: AuthService.firebase().initialize(),
      // builder : allow to adapt display depending on the state of the asynchronous response
      builder: (context, snapshot) {
        // Switch depending on display
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            // Check if user is connected
            if (user != null) {
              // if user is connected check if email is verified
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                // if not verified, show the verify email screen
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
