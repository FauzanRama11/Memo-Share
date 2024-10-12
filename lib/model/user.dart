import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String uid;
  String photoUrl;
  String username;
  List followers;
  List following;

  User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return User(
        username: data?['username'],
        uid: data?['uid'],
        photoUrl: data?['photoUrl'],
        email: data?['email'],
        followers: data?['followers'],
        following: data?['following']);
  }
}
