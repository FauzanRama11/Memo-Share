import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String uid;
  final String title;
  final String notes;
  final String time;
  final DateTime date;
  bool isDone;

  Event(
      {required this.uid,
      required this.title,
      required this.notes,
      required this.time,
      required this.date,
      this.isDone = false});

  void toggleDone() {
    this.isDone = !this.isDone;
  }

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      uid: data?['id'],
      title: data?['title'],
      notes: data?['notes'],
      time: data?['time'],
      date: data?['date'].toDate(),
      isDone: data?['isDone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "id": uid,
      if (title != null) "title": title,
      if (notes != null) "notes": notes,
      if (time != null) "time": time,
      if (date != null) "date": date,
      if (isDone != null) "isDone": isDone,
    };
  }
}
