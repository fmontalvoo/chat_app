import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid)
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            elevation: 5.0,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  if (Platform.isIOS)
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
}
