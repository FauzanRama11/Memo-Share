import 'package:flutter/material.dart';
import '/Resource/AuthMethod.dart';
import '/Resource/Firestore_service.dart';
import '/utilities/settings.dart';
import '/provider/userProvider.dart';
import '/model/user.dart' as model;
import 'package:provider/provider.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: profilepage(),
    );
  }
}

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  bool showPassword = false;
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _emailController = TextEditingController();
  String? validate(value) {
    if (value == null || value.isEmpty) {
      return "Tidak boleh Kosong";
    }
    return null;
  }

  @override
  void initState() {
    initText();
    super.initState();
  }

  void initText() async {
    final data =
        await FireStore.getUserService(AuthMethods.getAuthUser()!.email!);
    _textController.text = data.username;
    _emailController.text = data.email;
  }

  @override
  Widget build(BuildContext context) {
    model.User userpt = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                userpt.photoUrl,
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _textController,
                      validator: validate,
                      decoration: const InputDecoration(hintText: "Username"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        controller: _emailController,
                        validator: validate,
                        decoration: const InputDecoration(hintText: "Email"))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 50),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final message = await AuthMethods.editUser(
                            AuthMethods.getAuthUser()!.email!, [
                          {'username': _textController.text},
                          {'email': _emailController.text}
                        ]);
                        if (context.mounted) {
                          if (message != 'Success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          }
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => profilepage()));
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 50),
                      ),
                      elevation: MaterialStateProperty.all<double>(2),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameField(String labelText, String placeholder) {
    final TextEditingController _usernameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: _usernameController,
        validator: validate,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
