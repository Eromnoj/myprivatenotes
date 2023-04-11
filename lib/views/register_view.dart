import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_exceptions.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_event.dart';
import 'package:myprivatenotes/utilities/dialogs/error_dialog.dart';

import 'package:myprivatenotes/services/auth/bloc/auth_bloc.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_state.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Register !'),
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
                autofocus: true,
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

                  context.read<AuthBloc>().add(
                        AuthEventRegister(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text('Register'),
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text('Already registered ? Log in here'))
            ],
          ),
        ),
      ),
    );
  }
}
