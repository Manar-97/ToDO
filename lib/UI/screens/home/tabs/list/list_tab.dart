import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/todo.dart';
import 'package:tooodooo/UI/utils/App_Colors.dart';
import 'package:tooodooo/UI/utils/App_Style.dart';
import 'package:tooodooo/UI/utils/date_time_extention.dart';
import 'package:tooodooo/model/todo_dm.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => ListTabState();
}

class ListTabState extends State<ListTab> {
  DateTime selectedCalender = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  void initState() {
    super.initState();
    gettodosListFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCalender(),
        Expanded(
          flex: 75,
          child: ListView.builder(
            itemCount: todosList.length,
            itemBuilder: (context, index) {
              return Todo(
                item: todosList[index],
              );
            },
          ),
        )
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
          EasyInfiniteDateTimeLine(
            activeColor: AppColors.primary,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selectedCalender,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            itemBuilder: (context, date, isSelected, onDayTapped) {
              return InkWell(
                onTap: () {
                    selectedCalender = date;
                    gettodosListFromFireStore();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        date.dayName,
                        style: isSelected
                            ? AppStyles.selectedCalenderDayStyle
                            : AppStyles.unSelectedCalenderDayStyle,
                      ),
                      const Spacer(),
                      Text(
                        date.day.toString(),
                        style: isSelected
                            ? AppStyles.selectedCalenderDayStyle
                            : AppStyles.unSelectedCalenderDayStyle,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}

  void gettodosListFromFireStore() async {
    // List<String> nums = ["1", "2", "3"];
    // List<int> numbers = [];

    ///Solution1
    // for(int i = 0; i < nums.length; i++){
    //   numbers.add(int.parse(nums[i]));
    // }
    ///Solution2
    // numbers = nums.map((string) => int.parse(string)).toList();
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();
    todosList = todosList
        .where((todo) =>
            todo.date.year == selectedCalender.year &&
            todo.date.month == selectedCalender.month &&
            todo.date.day == selectedCalender.day)
        .toList();
    setState(() {});
  }
}
