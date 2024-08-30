import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tooodooo/db/model/user_dm.dart';

class UserFun {
  static CollectionReference<UserDM> getUserCollection() {
    var db = FirebaseFirestore.instance;
    var userCollection = db.collection(UserDM.collectionName).withConverter(
        fromFirestore: (snapshot, option) =>
            UserDM.fromJson(snapshot.data()),
        toFirestore: (user, option) => user.toJson());
    return userCollection;
  }

  static Future<void> addUser(UserDM user) async {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
    return await doc.set(user);
  }

  static Future<UserDM?> getUser(String? userID) async {
    var collection = getUserCollection();
    var userSnapshot = collection.doc(userID);
    var data = await userSnapshot.get();
    return data.data();
  }
}