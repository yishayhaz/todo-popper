import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_popper/common/router.dart';

class Alert extends StatelessWidget {
  final String? confirmText;
  final String? cancelText;
  final String title;
  final String message;
  final Function onConfirm;
  final Function? onCancel;

  const Alert(
      {super.key,
      this.confirmText,
      this.cancelText,
      required this.title,
      required this.message,
      required this.onConfirm,
      this.onCancel});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              if (onCancel == null) {
                AppRouter.router.pop();
              } else {
                onCancel!();
              }
            },
            child: Text(cancelText ?? "Cancel"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              onConfirm();
            },
            child: Text(confirmText ?? "OK"),
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel == null) {
              AppRouter.router.pop();
            } else {
              onCancel!();
            }
          },
          child: Text(cancelText ?? "Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
          },
          child: Text(confirmText ?? "OK"),
        ),
      ],
    );
  }
}
