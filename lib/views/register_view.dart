import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/utilities/show_error_dialog.dart';
import 'package:myprivatenotes/views/verify_email_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
      ),
      body: Column(
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, password: password);

                final user = FirebaseAuth.instance.currentUser;

                await user?.sendEmailVerification();

                if (context.mounted) {
                  Navigator.of(context).pushNamed(
                    verifyEmailViewRoute,
                  );
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErorDialog(
                    context,
                    'Weak password',
                  );
                } else if (e.code == 'email-already-in-use') {
                  await showErorDialog(
                    context,
                    'Email already in use',
                  );
                } else if (e.code == 'invalid-email') {
                  await showErorDialog(
                    context,
                    'Invalid Email',
                  );
                } else {
                  await showErorDialog(
                    context,
                    'Error: ${e.code}',
                  );
                }
              } catch (e) {
                await showErorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Already registered ? Log in here'))
        ],
      ),
    );
  }
}
