import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciamento/home.dart';
import 'package:gerenciamento/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
final  TextEditingController _controllerNome =TextEditingController(text: "Maria Natalia");
final  TextEditingController _controllerEmail =TextEditingController(text: "silvamarianatalia12@gmail.com");
final  TextEditingController _controllerSenha =TextEditingController(text: "27091308");
String _mensagemErro = "";

_validarCampos(){

    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if(nome.isNotEmpty){
      if(email.isNotEmpty && email.contains("@")){
        if(senha.isNotEmpty && senha.length > 6){
          setState(() {
            _mensagemErro= "";
          });

        Usuario usuario= Usuario();
        usuario.nome= nome;
        usuario.email= email;
        usuario.senha= senha;
        _cadastrarUsuario(usuario);

        }else{
          setState(() {
            _mensagemErro =" Preencha a Senha! digite mais de 6 caracteres";
          });

        }
      }else{
        setState(() {
          _mensagemErro =" Preencha o E-mail utilizando @";
        });
      }
    }else{
      setState(() {
        _mensagemErro= "Preencha o nome";
      });
    }
  }
void  _cadastrarUsuario(Usuario usuario){
    FirebaseAuth auth =FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    ).then((firebaseUser){
      // Salvar dados do Usuário
      
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("usuarios")
      .doc( firebaseUser.user?.uid )
      .set( usuario.toMap() );
  
      Navigator.push(
        context,
        MaterialPageRoute(builder:(context)=> Home()
        )
      );
      
      }).catchError((error){
        setState(() {
          _mensagemErro= "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
        });

      });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text("Cadastro"),
        titleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 34, 143, 67),),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:<Widget> [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset("imagens/usuario.png",
                  width: 300,
                  height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Color.fromARGB(125, 37, 110, 27),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  ),
                  ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Email",
                      filled: true,
                      fillColor: Color.fromARGB(125, 37, 110, 27),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: _controllerSenha,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Color.fromARGB(125, 37, 110, 27),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)

                      )
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16,bottom: 10),
                    child: ElevatedButton(
                      onPressed: (){
                        _validarCampos();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 23, 85, 25),
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        ),
                      ),
                       child: const Text(
                        "Cadastrar",
                       style: TextStyle(color:Colors.white, fontSize: 20),
                     

                      ),

                     ),
                  ),
                  Center(
                    child: Text(
                     _mensagemErro,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    
                  ) ,
                  ),
                 
                

              ],
              ),
               ),
        ),

      ),
    );
  }
    
  
        
}
