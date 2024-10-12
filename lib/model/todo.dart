import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String uid;
  final String toDoAct;
  final String toDoNote;
  final String toDoTime;
  final DateTime toDoDate;
  bool isDone;

  ToDo(
      {required this.uid,
      required this.toDoAct,
      required this.toDoNote,
      required this.toDoTime,
      required this.toDoDate,
      this.isDone = false});

  void toggleDone() {
    this.isDone = !this.isDone;
  }

  factory ToDo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ToDo(
      uid: data?['uid'],
      toDoAct: data?['toDoAct'],
      toDoNote: data?['toDoNote'],
      toDoTime: data?['toDoTime'],
      toDoDate: data?['toDoDate'],
      isDone: data?['isDone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "id": uid,
      if (toDoAct != null) "toDoAct": toDoAct,
      if (toDoNote != null) "toDoNote": toDoNote,
      if (toDoTime != null) "toDoTime": toDoTime,
      if (toDoDate != null) "toDoDate": toDoDate,
      if (isDone != null) "isDone": isDone,
    };
  }
}
