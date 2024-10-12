import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './provider/eventProvider.dart';
import './provider/toDoList.dart';
import './provider/userProvider.dart';
import './screens/landingpage.dart';
import './utilities/publicNavBar.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventList(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // Checking if the snapshot has any data or not
                if (snapshot.hasData) {
                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                  return NavBar();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }

              // means connection to future hasnt been made yet
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return LandingPage();
            }),
      ),
    );
  }
}
