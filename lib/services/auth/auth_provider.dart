import 'package:myprivatenotes/services/auth/auth_user.dart';

// creating an abstract class to set the default attribute and method for the
// different auth providers and for auth service, the class which is called by the
// UI to manage login
abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
