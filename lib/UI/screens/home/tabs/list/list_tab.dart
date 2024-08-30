import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/todo_task/show_todo.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/todo_task/todos.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';
import 'package:tooodooo/db/functions/task_fun.dart';
import 'package:tooodooo/db/model/todo_dm.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';
import 'package:tooodooo/db/provider/my_provider.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => ListTabState();
}

class ListTabState extends State<ListTab> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Column(
      children: [
        buildCalender(),
        Expanded(
            flex: 75,
            child: StreamBuilder(
                stream: TasksFun.isFirst
                    ? TasksFun.getTasks(authProvider.user?.id ?? "")
                    : TasksFun.getSearchTasks(authProvider.user?.id ?? ""),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<TodoDM>? todos = snapshot.data;
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Todos(
                        todo: todos![index],
                        show: showTodo,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                    itemCount: todos?.length ?? 0,
                  );
                }))
      ],
    );
  }

  buildCalender() {
    return Expanded(
        flex: 25,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  color: AppColors.primary,
                )),
                Expanded(
                    child: Container(
                  color: AppColors.background,
                )),
              ],
            ),
            EasyDateTimeLine(
                locale: Provider.of<MyProvider>(context).local,
                headerProps: const EasyHeaderProps(showHeader: false),
                initialDate: DateTime.now(),
                dayProps: EasyDayProps(
                    todayStyle: const DayStyle(
                        borderRadius: 5,
                        decoration: BoxDecoration(border: null)),
                    activeDayStyle: DayStyle(
                        dayNumStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                        monthStrStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                fontSize: 10),
                        dayStrStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                fontSize: 10),
                        borderRadius: 0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground)),
                    inactiveDayStyle: const DayStyle(
                        borderRadius: 0,
                        decoration: BoxDecoration(color: Colors.transparent))),
                onDateChange: (date) {
                  setState(() {
                    TasksFun.date = date;
                  });
                })
          ],
        ));
  }

  void showTodo(String? title, String? text) {
    showModalBottomSheet(
        context: context,
        builder: (content) => ShowTodo(title: title!, content: text!),
        isScrollControlled: true);
  }
}
