import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gerenciamento/cadastro.dart';
import 'package:gerenciamento/home.dart';
import 'package:gerenciamento/model/usuario.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
final  TextEditingController _controllerEmail =TextEditingController(text: "silvamarianatalia1@gmail.com");
final  TextEditingController _controllerSenha =TextEditingController(text: "27091308");
String _mensagemErro = "";
_validarCampos(){
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length > 6){
        setState(() {
          _mensagemErro= "";
        });

      Usuario usuario= Usuario();
      usuario.email= email;
      usuario.senha= senha;
      _logarUsuario(usuario);

      }else{
        setState(() {
          _mensagemErro =" Preencha a Senha!";
          });

      }
    }else{
      setState(() {
        _mensagemErro =" Preencha o utilizando @";
      });
    }
  }
  _logarUsuario(Usuario usuario){
    FirebaseAuth auth =FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: usuario.email, 
      password: usuario.senha,
    ).then((firebaseUser){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:(context)=> Home()
        )
      );

    }).catchError((error){
        setState(() {
          _mensagemErro = "Erro ao autenticar usuário, vereifique email e senha e tente novamente!";
        });

      });
  }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 44, 136, 72)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:<Widget> [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset("imagens/imagen.png",
                  width: 500,
                  height: 300,
                  ),
                ),
                
              
                Center(
                  heightFactor: 2,
                  child: Text(
                    "Bem-Vindo",
                    textDirection: TextDirection.ltr,
                    style: TextStyle( fontSize: 50, color: Colors.white
                  ),

                  ),
                ),
                
                
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Email",
                      filled: true,
                      fillColor: Color.fromARGB(125, 37, 110, 27),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                    )
                   ),
                  
                  ),
                  ),
                  TextField(
                    controller: _controllerSenha,
                    obscureText: true,
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
                        "Entrar",
                       style: TextStyle(color:Colors.white, fontSize: 25),
                     

                      ),

                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text(
                        "Não tem conta ? Cadastre-se!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>Cadastro()));
                        
                          
                        },

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Center(
                        child: Text(
                          _mensagemErro,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20
                          ),
                        ),
                      ),),
                      
                    

                  

              ],
              ),
               ),
        ),

      ),
    );
  }
}