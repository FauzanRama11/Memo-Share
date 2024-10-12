import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/Resource/AuthMethod.dart';
import '/model/event.dart';
import '/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../main.dart';
import '../model/todo.dart';

class EventList with ChangeNotifier {
  final db = FirebaseFirestore.instance.collection('events').withConverter(
        fromFirestore: Event.fromFirestore,
        toFirestore: (Event event, options) => event.toFirestore(),
      );
  // FirebaseFirestore datafirestore = FirebaseFirestore.instance;

  final Map<String, Event> _EventList = {};
  Map<String, Event> get events => _EventList;
  // List<Event> _Event = [];

  // List<Event> _EventList = [];

  // List<Event> get events => _EventList;
  void initEvent() async {
    final dataRef = await db
        .where('id', isEqualTo: AuthMethods.getAuthUser()!.uid)
        .where(
          'date',
          isGreaterThanOrEqualTo:
              Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1))),
        )
        .orderBy('date', descending: true)
        .get();
    final data = dataRef.docs;
    for (var docSnapshot in data) {
      _EventList.putIfAbsent(docSnapshot.id, () {
        return docSnapshot.data();
      });
    }

    notifyListeners();
  }

  void addList(String id, Event Event) async {
    _EventList.putIfAbsent(
      id,
      () => Event,
    );
    await db.doc(id).set(Event);
    notifyListeners();
  }

  //

  // void changeStatus(Event Event) {
  //   _EventList.removeWhere((String uid, Event) => Event.uid == Event.uid).first.toggleDone();
  //   notifyListeners();
  // }

  deleteTask(Event Event) {
    _EventList.removeWhere((String uid, Event) => Event.uid == Event.uid);
    notifyListeners();
  }
}
