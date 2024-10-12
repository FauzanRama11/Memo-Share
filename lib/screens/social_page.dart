import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/screens/profilepage.dart';
import '/utilities/postSocial.dart/addPost.dart';
import '/utilities/postSocial.dart/postCard.dart';
import '/utilities/publicAppBar.dart';
import '/utilities/search.dart';

import 'editProfile.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  _SocialPage createState() => _SocialPage();
}

class _SocialPage extends State<SocialPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(111), child: PublicAppBar()),
        floatingActionButton: FloatingActionButton(
          // Adding task
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addScreenPosts()),
            );
          },
          child: Icon(Icons.post_add_rounded),
        ),
        body: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 36, 23, 23).withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text("What do you want to search?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF2585DE)))),
            ),
          ]),
          Flexible(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Container(
                      child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  )),
                );
              },
            ),
          ),
        ]));
  }
}
