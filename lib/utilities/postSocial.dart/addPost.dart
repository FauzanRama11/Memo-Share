import 'dart:ffi';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '/provider/userProvider.dart';
import 'package:provider/provider.dart';
import '../../widget/util.dart';
import '../../Resource/firestoreMethod.dart';
import '/model/user.dart' as model;

class addScreenPosts extends StatefulWidget {
  const addScreenPosts({super.key});

  @override
  State<addScreenPosts> createState() => _addScreenPostsState();
}

class _addScreenPostsState extends State<addScreenPosts> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final List<ListTile> posts = [];

  bool isLoading = false;

  void addToPost() {
    setState(() {
      posts.add(ListTile(
        title: Text(_descriptionController.text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
      ));
      _descriptionController.clear();
    });
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        greenSnackBar(
          'Posted!',
          context,
        );
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        err.toString(),
        context,
      );
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Select Option"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Take a picture"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Choose from Galery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: const Text('Post Achievement')),
            body: Center(
                child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            )),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: const Text('Post Achievement'),
              actions: [
                TextButton(
                    onPressed: () => postImage(
                          user.uid,
                          user.username,
                          user.photoUrl,
                        ),
                    child: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))
              ],
            ),
            body: Column(children: [
              isLoading
                  ? const LinearProgressIndicator()
                  : Padding(padding: EdgeInsets.only(top: 0)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.photoUrl,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Pave your achievement"),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter))),
                    ),
                  ),
                  const Divider()
                ],
              )
            ]),
          );
  }
}
