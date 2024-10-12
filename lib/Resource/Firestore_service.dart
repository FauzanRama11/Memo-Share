import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/user.dart';

import '';

class FireStore {
  static var db = FirebaseFirestore.instance;
  late CollectionReference firestoreInstance;

  FireStoreService(String collection, var from, var to) {
    firestoreInstance = db
        .collection(collection)
        .withConverter(fromFirestore: from, toFirestore: to);
  }

  static Future<User> getUserService(String email) async {
    final docref = db.collection('users').where('email', isEqualTo: email);
    final docSnap = await docref.get();
    final dataService = docSnap.docs.single;
    final optionsService = SnapshotOptions();
    return User.fromFirestore(dataService, optionsService);
  }
}
