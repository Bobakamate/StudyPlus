import 'package:flutter/material.dart';

import '../../../Provider/AppProvider.dart';


class ProjetDetail extends StatefulWidget {
  const ProjetDetail({super.key});

  @override
  State<ProjetDetail> createState() => _ProjetDetailState();
}

class _ProjetDetailState extends State<ProjetDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Image.asset(AppProvider.projetModule.image,
              height: 300,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 1100,
              width: MediaQuery.of(context).size.width,),
            Positioned(

                top: 10 + 250,
                child:  Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1100,
                  padding: EdgeInsets.only(left: 10,
                      right: 10,top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff0000FF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),



                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Projet de : "+ AppProvider.projetModule.nom,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("prof : "+ AppProvider.projetDetailProf.nom,style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Description:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(AppProvider.projetDetail.titre,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(AppProvider.projetDetail.description,style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),SizedBox(height: 20,),

                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Instruction",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18),),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("clicker sur modifier pour Modifier",style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("clicker sur download pour telecharger le projet",style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),

                      Expanded(
                          child: Container(

                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 150),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(150, 40),
                                    minimumSize: Size(150, 40),
                                  ),
                                  child: Text("Modifier",style: TextStyle(color: Colors.black),),),
                                ElevatedButton(onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(150, 40),
                                    minimumSize: Size(150, 40),
                                  ),
                                  child: Text("Download",style: TextStyle(color: Colors.black),),)
                              ],
                            ),
                          ))
                    ],
                  ),
                )
            ) ,


          ],
        ),
      ),
    );
  }
}
