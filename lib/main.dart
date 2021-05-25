import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  //Firebase Init
  WidgetsFlutterBinding.ensureInitialized();

  Firestore.instance
      .collection("usuarios")
      .document("pontuacao")
      .setData({"Gustavo" : "Teste"});

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
