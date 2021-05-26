import 'package:esc/Home.dart';
import 'package:esc/Login.dart';
import 'package:esc/model/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _msgError = "";

  _validInputs(){

    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(nome.isEmpty){
      setState(() {
        _msgError = "Preencha o nome";
      });
      return;
    }

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

    if(senha.length < 6){
      setState(() {
        _msgError = "Senha deve ter ao menos 6 caracteres";
      });
      return;
    }

    User user = User();
    user.nome = nome;
    user.email = email;
    user.senha = senha;

    _registerUser(user);
  }

  _registerUser(User user){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.senha
    ).then((firebaseUser){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
    }).catchError((onError){
      setState(() {
        _msgError = onError;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro")
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
                            "Registro",
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
                          controller: _controllerNome,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              hintText: "Nome",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: TextField(
                          controller: _controllerEmail,
                          autofocus: true,
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
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                              "Cadastrar",
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
                            "Já tem conta?",
                            style: TextStyle(
                                color: Colors.green
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()
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
