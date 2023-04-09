import 'package:flutter/material.dart';
import 'package:myprivatenotes/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You connat share an empty note',
    optionBuilder: () => {'Ok': null},
  );
}
