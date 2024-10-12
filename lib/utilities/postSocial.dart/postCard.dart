import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/Resource/AuthMethod.dart';
import '/screens/commentpage.dart';
import '/utilities/postSocial.dart/likes.dart';
import 'package:provider/provider.dart';
import '/model/user.dart' as model;
import '../../provider/userProvider.dart';
import '../../Resource/firestoreMethod.dart';
import '../../widget/util.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {});
  }

  deletePost(String postId) async {
    final user = await AuthMethods().getUserDetails();
    try {
      if (widget.snap['uid'] == user.uid) {
        await FireStoreMethods().deletePost(postId);
        greenSnackBar("Berhasil mnghapus", context);
      } else {
        showSnackBar("Tidak bisa menghapus konten orang lain", context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      margin: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 36, 23, 23).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
        // Header Section
        Container(
          width: 400,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: Row(children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                widget.snap['profImage'].toString(),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.snap['username'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                              child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map((e) => InkWell(
                                    onTap: () async {
                                      deletePost(widget.snap["postId"]);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    )))
                                .toList(),
                          )));
                },
                icon: Icon(Icons.more_vert))
          ]),
        ),

        // Image Section
        GestureDetector(
          onDoubleTap: () {
            FireStoreMethods().likePost(
              widget.snap['postId'].toString(),
              user.uid,
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: 400,
                child: Image(
                  image: NetworkImage(widget.snap['postUrl'].toString()),
                  fit: BoxFit.cover,
                )),
            AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ))
          ]),
        ),

        // LC Section
        Container(
            width: 400,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user.uid),
                    smallLike: true,
                    child: IconButton(
                      icon: widget.snap['likes'].contains(user.uid)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                      onPressed: () => FireStoreMethods().likePost(
                        widget.snap['postId'].toString(),
                        user.uid,
                        widget.snap['likes'],
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.comment),
                      color: Color.fromARGB(255, 0, 0, 0),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                  postId: widget.snap['postId'].toString())))
                      //  => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>)),

                      ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ])),
        // Caption section
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.snap['likes'].length} likes',
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 8),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: widget.snap['username'].toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' ${widget.snap['description']}')
                      ]),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString()))),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "View $commentLen comments",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
    ;
  }
}
