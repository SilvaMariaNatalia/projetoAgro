import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
 

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack()=> Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 19, 85, 47),
            Color.fromARGB(255, 68, 179, 87)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
      CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title:  Text("Gerenciamento de Plantações"),
                centerTitle: true,

              ),

            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
               .collection("home").orderBy("pos").get(),
              builder:(context, snapshot){
                if(!snapshot.hasData)
                return SliverToBoxAdapter(
                  child: Container(
                    height: 200.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                     ),
                  ),
                );
                else {
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    staggeredTiles:snapshot.data!.docs.map(
                      (doc){
                        return StaggeredTile.count(
                        int.parse( doc["x"].toString()),
                        double.parse(doc["y"].toString())
                       
                          );
                      }
                    ).toList(),
                      children: snapshot.data!.docs.map(
                        (doc){
                          return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage, 
                            
                            image: doc["image"],
                            fit: BoxFit.cover,

                          );

                        }
                      ).toList(),
                    );
                }
                  
                
                
                

    
              },
            )
  
   
          
         
                
          ],
        )
      ],
    );
  }
}