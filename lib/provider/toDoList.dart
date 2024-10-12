import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/Resource/AuthMethod.dart';
import 'package:uuid/uuid.dart';
import '../main.dart';
import '../model/todo.dart';

class ListProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance.collection('todo').withConverter(
        fromFirestore: ToDo.fromFirestore,
        toFirestore: (ToDo todo, options) => todo.toFirestore(),
      );
  // FirebaseFirestore datafirestore = FirebaseFirestore.instance;

  List<ToDo> _listProvider = [];

  List<ToDo> get listProvider => _listProvider;

  void initData() async {
    final docRef = db;
  }

  void addList(ToDo todo) async {
    // await datafirestore.collection("User").add(todo);
    await db.add(todo);
    _listProvider.add(todo);
    notifyListeners();
  }

  void getList() async {
    final user = await AuthMethods().getUserDetails();
    final docSnap = await db.where('id', isEqualTo: user.uid).get();
    final docRef = docSnap.docs;
    for (var data in docRef) {
      _listProvider.add(data.data());
      print(data.data().toDoNote);
    }
    notifyListeners();
  }

  void changeStatus(ToDo todo) {
    _listProvider
        .where((element) => element.uid == todo.uid)
        .first
        .toggleDone();
    notifyListeners();
  }

  void deleteTask(ToDo todo) {
    _listProvider.removeWhere((element) => element.uid == todo.uid);
    notifyListeners();
  }
}
