import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/utils/extentions/build_context_extentions.dart';
import 'package:tooodooo/UI/widget/cust_text_field.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';
import 'package:tooodooo/db/functions/task_fun.dart';
import 'package:tooodooo/db/model/todo_dm.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 25,
            left: 45,
            right: 45,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.onBackground),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.local.add_task,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: context.local.task_title,
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
                    return context.local.error_title;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: context.local.task_content,
                control: description,
                maxline: 4,
                minline: 1,
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 15, height: 2),
                textStyle:
                    Theme.of(context).textTheme.labelSmall?.copyWith(height: 2),
                withBoarder: true,
                check: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return context.local.error_details;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  showTaskDate();
                },
                child: Text(
                  context.local.selected_date,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: showDateError ? 0 : 15,
              ),
              Visibility(
                visible: showDateError,
                child: Text(
                  context.local.error_date,
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
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: TextButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    context.local.add_task_button,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
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

  void addTask() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!validation()) {
      return;
    }
    TodoDM todoDM = TodoDM(
        title: title.text,
        description: description.text,
        date: Timestamp.fromMillisecondsSinceEpoch(
            selectedDate!.millisecondsSinceEpoch));
    try {
      Dialogs.showLoadingDialog(context, 'Add Task...', isCanceled: false);
      TasksFun.addTask(todoDM, authProvider.user!.id!);
      Dialogs.closeMessageDialog(context);
      Dialogs.showMessageDialog(
        context,
        context.local.task_success,
        isClosed: false,
        positiveActionText: context.local.ok,
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
      Dialogs.showMessageDialog(context, e.toString(),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }
}
