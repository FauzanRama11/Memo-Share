import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '/Resource/AuthMethod.dart';
import '/screens/login_screen.dart';
import '/utilities/constants.dart';

import '../widget/util.dart';

void main(List<String> args) {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _conpassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool passToggle = true;
  bool conpassToggle = true;
  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    if (_formKey.currentState!.validate()) {
      String res = "success";
    }
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        pass: _passController.text,
        username: _usernameController.text,
        file: _image!);

    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      greenSnackBar("User Berhasil Terdaftar!", context);
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _usernameController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Choose your username',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value!.length < 5) {
                String res = "Your Username is too short";
                showSnackBar(res, context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (!value!.contains("@") || !value.contains(".")) {
                String res = "Please use a valid email address";
                showSnackBar(res, context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _passController,
            obscureText: passToggle,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    passToggle = !passToggle;
                  });
                },
                child: Icon(
                    passToggle ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                String res = "Enter your password";
                showSnackBar(res, context);
              } else if (value.length < 7) {
                String res = "Enter password with 8 character or more";
                showSnackBar(res, context);
              } else if (value != _conpassController.text) {
                String res = "Password missmatch";
                showSnackBar(res, context);
              }

              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _ConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _conpassController,
            obscureText: conpassToggle,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    conpassToggle = !conpassToggle;
                  });
                },
                child: Icon(
                    conpassToggle ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white),
              ),
              hintText: 'Confirm your Password',
              hintStyle: kHintTextStyle,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                String res = "Enter your password";
                showSnackBar(res, context);
              } else if (value.length < 7) {
                String res = "Enter password with 8 character or more";
                showSnackBar(res, context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return InkWell(
      onTap: signUpUser,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        width: double.infinity,
        child: !_isLoading
            ? const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }

  Widget _buildProfpic() {
    return Stack(children: [
      _image != null
          ? CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(_image!),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            )
          : const CircleAvatar(
              radius: 64,
              backgroundImage:
                  NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
      Positioned(
        bottom: -10,
        left: 80,
        child: IconButton(
          onPressed: selectImage,
          icon: const Icon(Icons.add_a_photo),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 40.0,
                          ),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    _buildProfpic(),
                                    SizedBox(height: 20.0),
                                    _buildUsernameTF(),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    _buildEmailTF(),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    _buildPasswordTF(),
                                    SizedBox(height: 20.0),
                                    _ConfirmPasswordTF(),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    _buildRegisterBtn()
                                  ]))))
                ]))));
  }
}
