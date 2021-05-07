import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registrar',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim(); //remove whitespace
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Senha"),
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim(); //remove whitespace
                    });
                  },
                ),
                Text(
                  'Não tem conta?Clique aqui',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12),
                ),
                RaisedButton(child: Text('Login')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}