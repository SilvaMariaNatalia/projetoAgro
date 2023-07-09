import 'package:flutter/material.dart';
import 'package:gerenciamento/tabs/home_tab.dart';
import 'package:gerenciamento/widgets/custom_drawer.dart';
import 'package:gerenciamento/produtos.dart';
import 'package:gerenciamento/plantio.dart';
import 'package:gerenciamento/vendas.dart';
import 'package:gerenciamento/relatorio.dart';
import 'package:gerenciamento/grafico.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children:<Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text("Cadastrar Produtos ",),
            centerTitle: true,

          ),
          drawer: CustomDrawer(_pageController),
          body: CadastroProdutos(),

        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text("Cadastrar Plantio",),
            centerTitle: true,
          ),
          
          drawer: CustomDrawer(_pageController),
          body: CadastroPlantio(),
          

        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text("Cadastrar Vendas",),
            centerTitle: true,
          ),
          
          drawer: CustomDrawer(_pageController),
          body: CadastroVendas(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text("Relatório lucros",),
            centerTitle: true,
          ),
          
          drawer: CustomDrawer(_pageController),
          body: RelatorioLucros(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text("Gráfico de lucros",),
            centerTitle: true,
          ),
          
          drawer: CustomDrawer(_pageController),
          body: GraficoLucros(),
        )
       
        

      ],
    );
      
  }
}