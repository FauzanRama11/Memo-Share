import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Resource/storageMethod.dart';
import '/model/user.dart' as model;
import '/widget/util.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? getAuthUser() {
    User? user;
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        user = FirebaseAuth.instance.currentUser;
        // print(user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    return user;
  }

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String pass,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        // Register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);

        String photoUrl = await storageMethod()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          followers: [],
          following: [],
        );

        // Add data
        await _firestore.collection('users').doc(cred.user!.uid).set(
              _user.toJson(),
            );
        res = "success";
      } else {
        res = "Please Enter all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // Login user
  Future<String> loginUser({
    required String email,
    required String pass,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        // Register User
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    String res = "Some error occured";
    try {
      await _auth.signOut();
    } catch (e) {
      print("agi eror bang");
    }
  }

  static Future<String?> resetPassword({required String email}) async {
    User? user;
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        user = FirebaseAuth.instance.currentUser;
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return 'Success';
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // static Future<User> getUser(String email) async {
  //   final docRef = _firestore.collection('users').where('email', isEqualTo: email);
  //   final docSnap = await docRef.get();
  //   final data1 = docSnap.docs.single;
  //   final options = SnapshotOptions();
  //   return User._firestore(data1, options)
  // }

  static Future<String> editUser(
      String email, List<Map<String, String>> parameter) async {
    final docRef =
        _firestore.collection('users').where('email', isEqualTo: email);
    final docSnap = await docRef.get();
    try {
      final data1 = docSnap.docs.first.reference;
      for (var updateData in parameter) {
        await data1.update(updateData);
      }
      return 'Success';
    } on FirebaseException catch (e) {
      return e.message!;
    }
  }
}
