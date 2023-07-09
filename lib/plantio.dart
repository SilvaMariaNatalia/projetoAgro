import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento/home.dart';



class CadastroPlantio extends StatefulWidget {
  const CadastroPlantio({Key? key}) : super(key: key); 

  @override
  State<CadastroPlantio> createState() => _CadastroPlantioState();
}

class _CadastroPlantioState extends State<CadastroPlantio> {
  TextEditingController controllerNome =TextEditingController();
  TextEditingController controllercultura =TextEditingController();
  TextEditingController controllerDatadoPlantio =TextEditingController();
  TextEditingController controllerDatadaColheita =TextEditingController();
  TextEditingController controllercusto =TextEditingController();
  String _mensagemErro= "";

 String produtoSelecionado = '';
  List<String> produtos = [];
  List<String> uniqueProdutos = [];


  @override
  void initState() {
    super.initState();
    carregarProdutos();
    produtoSelecionado = produtos.isNotEmpty ? produtos[0] : '';
  }

  void carregarProdutos() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('produtos').get();
      setState(() {
        produtos = snapshot.docs.map((doc) => doc.id).toList();
        uniqueProdutos = produtos.toSet().toList();
        produtoSelecionado = uniqueProdutos.isNotEmpty ? uniqueProdutos[0] : '';
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  void cadastrarPlantio() async {
    String nome = controllerNome.text;
    String cultura = controllercultura.text;
    String dataPlantio = controllerDatadoPlantio.text;
    String dataColheita =controllerDatadaColheita.text;
    double custoPlantio = double.parse(controllercusto.text);

    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('plantio').add({
        'nome': nome,
        'cultura': cultura,
        'dataPlantio': dataPlantio,
        'dataColheita':dataColheita,
        'custoPlantio': custoPlantio,
        'produtoID': produtoSelecionado,
      });
      print('Plantio cadastrado com ID: ${docRef.id}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );

    } catch (e) {
      print('Erro ao cadastrar plantio: $e');
    }
  }
  bool hasDuplicateValues<T>(List<DropdownMenuItem<T>> items) {
  final values = items.map((item) => item.value).toList();
  final uniqueValues = Set<T>.from(values);
  return values.length != uniqueValues.length;
}



  @override
  Widget build(BuildContext context) {
    final uniqueProdutos = produtos.toSet().toList();  
    return Scaffold (
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 44, 136, 72)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:<Widget> [
                Padding(padding:EdgeInsets.only(bottom: 32),
                child: Image.asset("imagens/Plantio.jpg",
                width: 300,
                height: 200,),
                
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: produtoSelecionado,
                        items: uniqueProdutos.map((produto) {
                          return DropdownMenuItem<String>(
                            value: produto,
                            child: Text(produto),
                          );
                      }).toList(),
                        onChanged: (value) {
                          if(value != null && value.isNotEmpty) { // Verifique se o valor não é vazio ou nulo
                            setState(() {
                              produtoSelecionado = value;
                              });
                            }
                          },
                        decoration: InputDecoration(
                          labelText: 'Produto',
                         ),
                        validator: (value) {
                          List<DropdownMenuItem<dynamic>> dropdownItems =produtos.map((item) {
                            return DropdownMenuItem<dynamic>(
                              value: item,
                              child: Text(item),
                          );
                          }).toList();

                          if(hasDuplicateValues(dropdownItems)) {  
                            return 'Há itens duplicados com o mesmo valor';
                        }

                         return null;
                        }
                          
                      ),
                  Padding(

                    padding: EdgeInsets.only(bottom: 8),

                      child: TextField(
                        style: TextStyle(fontSize: 20),
                          controller: controllerNome,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Nome",
                            filled: true,
                            fillColor: Color.fromARGB(124, 133, 219, 121),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                  keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                     controller: controllercultura,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Cultura",
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
                  keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                     controller: controllerDatadoPlantio,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Data do Plantio",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                  keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    controller: controllerDatadaColheita,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Data da Colheita",
                      filled: true,
                      fillColor: Color.fromARGB(124, 133, 219, 121),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                   ),
                  
                  )
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                  keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    controller: controllercusto,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Custo",
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
                        cadastrarPlantio();
                         Navigator.push(
                          context,
                        MaterialPageRoute(
                          builder: (context) => CadastroPlantio(),
                        ),
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

              ]
          )
          ),
        ),
      ),
    );
  }
}