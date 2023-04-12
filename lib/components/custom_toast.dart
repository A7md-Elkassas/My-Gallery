import 'package:flutter/material.dart';

Future<void> showSnackBar(
    {required BuildContext context,
    required String text,
    required bool success}) async {
  await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(text),
    dismissDirection: DismissDirection.endToStart,
    backgroundColor: success == true ? Colors.green : Colors.red,
    action: SnackBarAction(
        textColor: Colors.white,
        label: "Ok",
        onPressed: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }),
    behavior: SnackBarBehavior.floating,
  ));
}
