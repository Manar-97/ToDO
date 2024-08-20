import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}

void showMessage(BuildContext context,
    {String? title,
    String? body,
    String? posButtonTitle,
    String? negButtonTitle,
    Function? onPosButtonClick,
    Function? onNegButtonClick}) {
  showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posButtonTitle != null)
              TextButton(
                onPressed: () {
                  onPosButtonClick?.call();
                  Navigator.of(context).pop();
                },
                child: Text(posButtonTitle),
              ),
            if (negButtonTitle != null)
              TextButton(
                onPressed: () {
                  onNegButtonClick?.call();
                  Navigator.of(context).pop();
                },
                child: Text(negButtonTitle),
              ),
          ],
        );
      });
}
