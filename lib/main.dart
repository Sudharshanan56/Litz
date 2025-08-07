import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:litz/Admin%20Pannel/Post.dart';
import 'package:litz/Admin%20Pannel/HomePage.dart';
import 'package:litz/Admin%20Pannel/points.dart';
import 'package:litz/Admin%20Pannel/post_2.dart';
import 'package:litz/Admin%20Pannel/users.dart';
import 'package:litz/Homepage/home_2.dart';
import '../Incentive/Incentive.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';
import 'package:litz/Homepage/home.dart';
import 'package:litz/Login/signup.dart';
import 'package:litz/Profile/Profile.dart';
import 'package:litz/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDziZBNXPknpAE3lkuCam3kZN5VlxchpM0",
        authDomain: "authenticationapp-b281f.firebaseapp.com",
        projectId: "authenticationapp-b281f",
        storageBucket: "authenticationapp-b281f.firebasestorage.app",
        messagingSenderId: "180878354237",
        appId: "1:180878354237:web:d9764a35cff1d19ec9c754",
        measurementId: "G-QTWWF1XVW2",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: splash(),
    );
  }
}
