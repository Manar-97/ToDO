import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM {
  static const String collectionName = "todo";
  String? id;
  String? title;
  Timestamp? date;
  String? description;
  bool? isDone;

  TodoDM({this.id, this.title, this.date, this.description, this.isDone = false});

  TodoDM.fromJson(Map<String, dynamic>? json) {
    id = json?["id"];
    title = json?["title"];
    description = json?["description"];
    date = json?["date"];
    isDone = json?["isDone"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
    };
  }
}
