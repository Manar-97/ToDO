import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/utils/App_Style.dart';
import 'package:tooodooo/UI/widget/cust_text_field.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';
import 'package:tooodooo/db/functions/task_fun.dart';
import 'package:tooodooo/db/model/todo_dm.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});
  static const String routeName = 'edit';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TodoDM? todo;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (todo == null) {
      todo = ModalRoute.of(context)?.settings.arguments as TodoDM;
      title.text = todo!.title!;
      description.text = todo!.description!;
      selectedDate = DateTime.fromMillisecondsSinceEpoch(
          todo!.date?.millisecondsSinceEpoch ?? 0);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Edit Task",
                    textAlign: TextAlign.center,
                    style: AppStyles.bottomSheetTitle,
                  ),
                  const Spacer(),
                  CustomTextField(
                    hint: 'enter your task title',
                    control: title,
                    maxline: 2,
                    minline: 1,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(height: 2),
                    textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 20,
                          height: 2,
                        ),
                    withBoarder: true,
                    check: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter task title';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    hint: 'enter your task details',
                    control: description,
                    maxline: 10,
                    minline: 1,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 15, height: 2),
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(height: 2),
                    withBoarder: true,
                    check: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter task content';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Spacer(),
                  Text(
                    "Select Date",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  InkWell(
                    onTap: () async {
                      showTaskDate();
                    },
                  ),
                  Visibility(
                    visible: showDateError,
                    child: Text(
                      'please enter date',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: '',
                      ),
                    ),
                  ),
                  Text(
                    selectedDate == null
                        ? ''
                        : '${selectedDate?.day} / ${selectedDate?.month} / ${selectedDate?.year}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () async {
                          var authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          var finalDate = Timestamp.fromMillisecondsSinceEpoch(
                              selectedDate?.millisecondsSinceEpoch ?? 0);
                          if (description.text == todo!.description &&
                              title.text == todo!.title &&
                              finalDate == todo!.date) {
                            print('no changes');
                            return;
                          }
                          todo!.title = title.text;
                          todo!.description = description.text;
                          todo!.date = finalDate;
                          try {
                            Dialogs.showLoadingDialog(context, 'Add Task...',
                                isCanceled: false);
                             TasksFun.updateTask(authProvider.user?.id,
                                todo!.id, todo!.toJson());
                            Dialogs.closeMessageDialog(context);
                            Dialogs.showMessageDialog(
                              context,
                              'Task added successfully',
                              isClosed: false,
                              positiveActionText: 'Ok',
                              positiveAction: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.check_circle_sharp,
                                color: Colors.green,
                                size: 30,
                              ),
                            );
                          } catch (e) {
                            Dialogs.closeMessageDialog(context);
                            Dialogs.showMessageDialog(
                                context, 'some thing went wrong',
                                icon: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  bool showDateError = false;

  void showTaskDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          const Duration(days: 365),
        ));
    selectedDate = date;
    setState(() {
      selectedDate = date;
      if (selectedDate != null) {
        showDateError = false;
      }
    });
  }

  bool validation() {
    if (formKey.currentState!.validate() && selectedDate != null) {
      return true;
    }
    setState(() {
      if (selectedDate == null) {
        showDateError = true;
      }
    });
    return false;
  }
}
