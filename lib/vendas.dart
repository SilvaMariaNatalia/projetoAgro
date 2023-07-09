import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciamento/home.dart';

class CadastroVendas extends StatefulWidget {
  const CadastroVendas({Key? key}) : super(key: key); 

  @override
  State<CadastroVendas> createState() => _CadastroVendasState();
}
class _CadastroVendasState extends State<CadastroVendas> {
TextEditingController custoController =TextEditingController();
TextEditingController valorvendaController =TextEditingController( );
TextEditingController DataVendaController =TextEditingController( );


// Método para cadastrar vendas no Firebase
void cadastrarVendas() async {
  //String custo = custoController.text;

String valorVenda= valorvendaController.text;
  String datavenda= DataVendaController.text;


  // Obtenha o valor do custo da coleção plantio
  DocumentSnapshot plantioSnapshot =
      await FirebaseFirestore.instance.collection('plantio').doc('FLSutMNbmFWOkLEtDsaS').get();
  
  // Verifique se o documento existe antes de acessar seus dados
  if (plantioSnapshot.exists) {
    // Obtenha o valor do custo do documento
    double custo = (plantioSnapshot.data() as Map<String, dynamic>)['custo'];
    
    // Crie um novo documento na coleção vendas
    
  try {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('produtos').add({
      'custo': custo,
      'valorVenda': valorVenda,
      'datavenda': datavenda,
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
                child: Image.asset("imagens/cafezal.jpg",
                width: 300,
                height: 200,),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8 ),
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    controller: DataVendaController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Data da venda",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )


                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                  keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    controller: valorvendaController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Valor da Venda",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  ),
                  ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                  keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    controller: custoController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Custo do Plantio",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  )
                ),
                
                
              
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: ElevatedButton(
                      onPressed: (){
                        cadastrarVendas();
                        Navigator.push(
                          context,
                        MaterialPageRoute(
                          builder: (context) => CadastroVendas()),
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

              ]
          )
          ),
        ),
      ),
    );
  }
}
    
  
