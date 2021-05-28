import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = "";

  _marcarPonto() async{
    Firestore db = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();

    db.collection("pontos")
    .add({"user": user.uid, "dateTime": DateTime.now()});
    setState(() => _message = "Ponto adicionado");
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() => _message = message["notification"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() => _message = message["notification"]["body"]);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() => _message = message["notification"]["body"]);
      },
    );

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('Push token gerado: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()
                  )
              );
            },
          )
        ],
      ),
        body: Container(
            decoration: BoxDecoration(color: Color(0xff0)),
            padding: EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(bottom: 120),
                        child: Center(
                          child: Text(
                            "Registro de ponto",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 10),
                        child: RaisedButton(
                            child: Text(
                              "Marcar",
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            color: Colors.green,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(100.0),
                            onPressed: (){
                                _marcarPonto();
                            }
                        ),
                      ),
                      Container(
                          child: Center(
                            child: Text(_message),
                          )),
                    ]
                ),
              ),
            )
        )
    );
  }
}
