import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Login.dart';

void main() async {

  //Firebase Init
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
