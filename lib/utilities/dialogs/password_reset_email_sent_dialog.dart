import 'package:flutter/material.dart';
import 'package:myprivatenotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'Wa have sent a password reset link',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
