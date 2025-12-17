import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg, {SnackBarAction? action}) {
  
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(msg), action: action));
}
