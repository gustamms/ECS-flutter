import 'package:flutter/material.dart';
import 'package:esc/views/loginScreen.dart';
//import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de ponto',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      //initialRoute: '/',
      //routes: {'/':(context) => LoginScreen()},
    );
  }
}
