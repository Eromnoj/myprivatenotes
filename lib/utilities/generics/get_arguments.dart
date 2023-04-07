import 'package:flutter/material.dart' show BuildContext, ModalRoute;

// create an extension to context that check if an argument is given or not
// through a Navigator.push
// this allows to have generic logic
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
