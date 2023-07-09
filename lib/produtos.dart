
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gerenciamento/home.dart';




class CadastroProdutos extends StatefulWidget {
  const CadastroProdutos({super.key});

  @override
  State<CadastroProdutos> createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  //Controladores
  TextEditingController nomeController =TextEditingController();
  TextEditingController controllerdescricao =TextEditingController( );
  String _mensagemErro= "";

  void cadastrarProduto() async {
    String nome = nomeController.text;
    String descricao = controllerdescricao.text;

    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('produtos').add({
        'nome': nome,
        'descricao': descricao,
      });
      print('Produto cadastrado com ID: ${docRef.id}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );


    } catch (e) {
      print('Erro ao cadastrar produto: $e');
    }
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
              children:<Widget> [
                Padding(padding:EdgeInsets.only(bottom: 32),
                child: Image.asset("imagens/verduras.jpg",
                width: 400,
                height: 300,),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8 ),
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                   controller: nomeController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome do Produto",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )


                    ),
                  ),

                  ),
                  TextField(
                    style: TextStyle(fontSize: 20),
                    controller: controllerdescricao,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Descrição",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    )

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: ElevatedButton(
                      onPressed: (){
                        cadastrarProduto();
                        Navigator.push(
                          context,
                        MaterialPageRoute(
                          builder: (context) => CadastroProdutos()),
                        );
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
                          color: Colors.red,
                          fontSize: 20
                        ),
                      ),
                     
                    )
                  
                  

              ],
            ),
          ),
        ),
      ),
    );
 
    
    
    
    
  
  }
}