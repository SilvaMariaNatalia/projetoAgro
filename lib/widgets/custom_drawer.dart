import 'package:flutter/material.dart';
import 'package:gerenciamento/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
 

    final PageController pageController;
    CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack()=> Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(78, 42, 221, 51),
            Color.fromARGB(255, 35, 136, 65)

          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter

        )
      ),

    );
    return Drawer(
      child: Stack(
        children:<Widget> [
          _buildDrawerBack(),
          ListView(
            padding:const EdgeInsets.only(left: 32.0, top: 16.0),
            children:<Widget> [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding:const EdgeInsets.fromLTRB( 0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children:<Widget> [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child:  Text("Seja\n Bem-Vindo! ",
                        style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold

                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget> [
                          Text("Gerencie sua Plantação.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          )
                          
                      
                        ],

                      ),
                    )

                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController,0),
              DrawerTile(Icons.grass, "Cadastrar Produto", pageController,1),
              DrawerTile(Icons.grass, "Cadastrar Plantio",pageController,2),
              DrawerTile(Icons.attach_money, "Cadastrar Vendas",pageController,3),
              DrawerTile(Icons.list, "Gerar Relatório", pageController,4),
              DrawerTile(Icons.insert_chart, "Gerar Gráfico",pageController,5),

            ],


          ),
   
        


        ],
      ),

    );
  }
}