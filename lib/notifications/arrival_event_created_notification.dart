import 'package:flutter/material.dart';

void showAddArrivalEventSuccess(BuildContext context, String content, {String? buttonText, VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Arrival event successfully added'),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
          ),
        ],
      );
    },
  );
}