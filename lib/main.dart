import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mastering_firebase/screens/auth/sign_up.dart';
import 'package:mastering_firebase/screens/home/home.dart';

import 'screens/auth/sign_in.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('*****************User is currently signed out!*********************');
      } else {
        print('*****************User is signed in!********************************');
      }
    });
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mastering Firebase',
      home: FirebaseAuth.instance.currentUser == null ?SignIn() : HomePage(),
      routes: {
        "HomePage" :(context)=>HomePage(),
        "SignInPage" :(context)=>SignIn(),
        "SigUpPage" :(context)=>SignUp(),
      }
    );
  }
}
