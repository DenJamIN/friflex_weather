import 'package:flutter/material.dart';

//Перечисление с вариантами работы над диалоговым окном
enum DialogActions { cancel }

//Класс, который позволяет вызывать диалоговое окно и Снэкбар
class ErrorAlert {
  //Статический метод для того чтобы не было нужно создавать экземпляр класса
  //Метод является асинхрон, потому что будет ожидать действия пользователя: выбор операции, нажатие вне рамок диалого окна
  //Возвращаемый тип значение из инама
  static Future<DialogActions> showDialogAlert({required BuildContext context}) async {
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //Заголовок окна
            title: const Text('ОШИБКА'),
            //Текст окна
            content: const Text('Ошибка получения данных'),
            //Кнопки
            actions: [
              // Кнопка с операцией
              ElevatedButton(
                //Обработка нажатия
                onPressed: () {
                  //Закрываем диалоговое окно
                  Navigator.of(context).pop(DialogActions.cancel);
                  //Переход на предыдущую страницу (в данном случае из 2 старницы на 1ую)
                  Navigator.of(context).pop();
                },
                //Стиль кнопки: цвет
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                //Текст кнопки
                child: const Text('Отмена'),
              )
            ],
          );
        });
    //Если пользователя нажал вне диалогого окна, то это считается как cancel
    return (action != null) ? action : DialogActions.cancel;
  }

  //Статический метод, который будет вызывать скафолд с снэбаром
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage(
      {required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        //Надпись
        content: Text('Ошибка получения данных'),
        //Цвет
        backgroundColor: Colors.redAccent,
        //Кнопка досрочного закрытия сообщения
        showCloseIcon: true,
      ),
    );
  }
}