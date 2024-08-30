import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/todo_task/edit_todo.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';
import 'package:tooodooo/db/functions/task_fun.dart';
import 'package:tooodooo/db/model/todo_dm.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';

typedef showTask = void Function(String? title, String? description);

class Todos extends StatefulWidget {
  TodoDM? todo;
  showTask? show;
  Todos({super.key, this.todo, this.show});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  Color titleColor = const Color(0xFF82B1FF);

  @override
  Widget build(BuildContext context) {
    var dateOfTask = DateTime.fromMillisecondsSinceEpoch(
        widget.todo?.date?.millisecondsSinceEpoch ?? 0);
    return InkWell(
      onTap: () {
        widget.show?.call(widget.todo?.title, widget.todo?.description);
      },
      child: Slidable(
        startActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              var authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              Dialogs.showMessageDialog(context, "task_delete",
                  icon: Icon(
                    Icons.warning,
                    color: Colors.yellow[800],
                  ),
                  positiveActionText: "yes",
                  positiveAction: () {
                    TasksFun.deleteTask(authProvider.user?.id, widget.todo?.id);
                  },
                  negativeActionText: "no",
                  negativeAction: () {
                    Navigator.pop(context);
                  });
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            icon: CupertinoIcons.delete,
            label: "Delete",
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                EditTask.routeName,
                arguments: widget.todo,
              );
            },
            backgroundColor: Colors.green,
            icon: Icons.edit,
            label: "Edit",
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
          ),
        ]),
        child: Container(
          margin:
              const EdgeInsets.only(left: 0, right: 20, top: 22, bottom: 22),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          child: Row(
            children: [
              buildVerticalLine(context),
              const SizedBox(
                width: 25,
              ),
              Row(children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${dateOfTask.day} / ${dateOfTask.month} / ${dateOfTask.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ]),
              buildTodoInfo(),
              // buildTodoState(),
            ],
          ),
        ),
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              widget.todo?.title ?? "",
              style: TextStyle(color: titleColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const Spacer(),
            Text(
              widget.todo?.description ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
          ],
        ),
      );

  buildTodoState() => GestureDetector(
      onTap: () {
        widget.todo?.isDone != widget.todo!.isDone;
      },
      child: AnimatedCrossFade(
        firstChild: widget.todo!.isDone!
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                child: const Icon(
                  Icons.celebration,
                  color: Colors.white,
                  size: 30,
                ),
              )
            : InkWell(
                onTap: () {
                  var authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    await TasksFun.updateTask(authProvider.user?.id,
                        widget.todo?.id, {'isdone': true});
                  });
                  setState(() {
                    crossFadeState = CrossFadeState.showSecond;
                    titleColor = Theme.of(context).colorScheme.onSecondary;
                  });
                },
                child: Container(
                  width: 69,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary),
                  child: const Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
        secondChild: Text(
          "done",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
        ),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 400),
      ));
}
