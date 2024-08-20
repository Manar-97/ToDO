import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tooodooo/UI/utils/App_Style.dart';
import 'package:tooodooo/UI/utils/date_time_extention.dart';
import '../../../model/todo_dm.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static Future show(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddBottomSheet(),
          );
        });
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: AppStyles.bottomSheetTitle,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Enter Task Title",
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "Enter Task Description",
            ),
          ),
          const SizedBox(height: 12),
          Text("Select Date",
              style: AppStyles.bottomSheetTitle.copyWith(fontSize: 16)),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Text(
              selectedDate.toFormattedDate,
              style: AppStyles.normalGreyTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addtodoToFireStore();
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ) ??
        selectedDate;
    setState(() {});
  }

  void addtodoToFireStore() {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference doc = todoCollection.doc();
    TodoDM todoDM = TodoDM(
        id: doc.id,
        title: titleController.text,
        date: selectedDate,
        description: descriptionController.text,
        isDone: false);
    doc.set(todoDM.toJson()).then((_) {
      ///this callback is called when future is completed
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      ///this callback is called when the throws and an exception
    }).timeout(const Duration(milliseconds: 500), onTimeout: () {
      /// This callback is called after duration you've in first argument
    });
  }
}
