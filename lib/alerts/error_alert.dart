import 'package:flutter/material.dart';

enum DialogActions { cancel }

class ErrorAlert {
  static Future<DialogActions> showDialogAlert({required BuildContext context}) async {
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ОШИБКА'),
            content: const Text('Ошибка получения данных'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogActions.cancel);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                child: const Text('Отмена'),
              )
            ],
          );
        });
    return (action != null) ? action : DialogActions.cancel;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage(
      {required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ошибка получения данных'),
        backgroundColor: Colors.redAccent,
        showCloseIcon: true,
      ),
    );
  }
}