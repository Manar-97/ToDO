import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tooodooo/db/functions/user_fun.dart';
import 'package:tooodooo/db/model/todo_dm.dart';


class TasksFun {
  static var date = DateTime.now();
  static bool isFirst = true;

  static CollectionReference<TodoDM> getTaskCollection(String? userId) {
    return UserFun.getUserCollection()
        .doc(userId)
        .collection(TodoDM.collectionName)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            TodoDM.fromJson(snapshot.data()),
        toFirestore: (taskObject, options) => taskObject.toJson());
  }

  static Future<void> addTask(TodoDM userTask, String userId) {
    var tasksCollection = getTaskCollection(userId);
    var task = tasksCollection.doc();
    userTask.id = task.id;
    return task.set(userTask);
  }

  static Stream<List<TodoDM>> getSearchTasks(String userId) async* {
    var filter = date.copyWith(
        microsecond: 0, millisecond: 0, second: 0, minute: 0, hour: 0);
    var taskCollection = getTaskCollection(userId);
    var tasksSnapshot = taskCollection
        .where('date',
        isEqualTo: Timestamp.fromMillisecondsSinceEpoch(
            filter.millisecondsSinceEpoch))
        .snapshots();
    var snapShots = tasksSnapshot
        .map((snapshots) => snapshots.docs.map((e) => e.data()).toList());
    yield* snapShots;
  }

  static Stream<List<TodoDM>> getTasks(String userId) async* {
    isFirst = false;
    var taskCollection = getTaskCollection(userId);
    var tasksSnapshot = taskCollection.snapshots();
    var snapShots = tasksSnapshot
        .map((snapshots) => snapshots.docs.map((e) => e.data()).toList());
    yield* snapShots;
  }

  static Future<void> deleteTask(String? id, String? taskId) async {
    var taskCollection = getTaskCollection(id);
    return await taskCollection.doc(taskId).delete();
  }

  static Future<void> updateTask(String? userId, String? taskId, Map<String, dynamic> newTask) {
    var taskCollection = getTaskCollection(userId);
    return taskCollection.doc(taskId).update(newTask);
  }
}