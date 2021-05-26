import 'package:esc/Home.dart';
import 'package:esc/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _msgError = "";

  _validInputs(){

    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isEmpty){
      setState(() {
        _msgError = "Preencha o e-mail";
      });
      return;
    }

    if(senha.isEmpty){
      setState(() {
        _msgError = "Preencha a senha";
      });
      return;
    }

    User user = User();
    user.email = email;
    user.senha = senha;

    _LoginUser(user);
  }

  _LoginUser(User user){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: user.email, password: user.senha)
    .then((firebaseUser){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
    }).catchError((onError){
      setState(() {
        _msgError = "Erro ao autenticar usuário, verificar e-mail e senha";
      });
    });

  }

  Future _verifyUser() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    if(user != null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
     }
  }

  @override
  void initState() {
    _verifyUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Login",
                    style: TextStyle(
                    color: Colors.black,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      autofocus: true,
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                    ),
                ),
                TextField(
                  autofocus: true,
                  controller: _controllerSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){_validInputs();}
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? Cadastre-se",
                      style: TextStyle(
                        color: Colors.green
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register()
                          )
                      );
                    },
                  ),
                ),
                Center(
                  child: Text(
                    _msgError,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20
                    ),
                  ),
                )
              ]
            ),
          ),
        )
      )
    );
  }
}
