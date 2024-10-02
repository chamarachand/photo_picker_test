import 'package:flutter/material.dart';

Future alertWarningDialog(
  BuildContext dialogContext,
  String title,
  String content,
) {
  return showDialog(
      context: dialogContext,
      builder: (BuildContext buildContext) {
        return AlertDialog(title: Text(title), content: Text(content), actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            style: TextButton.styleFrom(
              shadowColor: Colors.transparent,
              elevation: 0,
              // foregroundColor: Colors.shadeButtonOrange,
              // backgroundColor: CustomColors.shadeButtonOrange,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            child: const Text("Okay"),
          ),
        ]);
      });
}
