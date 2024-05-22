import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Provider/AppProvider.dart';
import '../../SQlite/bdd.dart';
import 'filiere.dart';
import 'package:flutter/services.dart';

import '../../SQlite/data.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool drawerIsOpen = false;
  int contentIndex = 0;
  List<Widget> content = [Filieres()];
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        )
    );
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        )
    );

    return Stack(
      children: [
        Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20,left: 10),
          decoration:  BoxDecoration(
              color: Colors.white
          ),
          child: Column(
            children: [
             Align(
               alignment: Alignment.topLeft,
               child:  ClipRRect(
                 borderRadius: BorderRadius.circular(10),

                 child:  Image.asset("assets/images/logo_fst.png",height: 170,width: 130,fit: BoxFit.cover,),
               ),
             ),SizedBox(height: 20,),
             ListView.builder(
               itemCount: AppProvider.filieres.length,
                 shrinkWrap: true,
                 itemBuilder: (context,index){
               return  GestureDetector(
                 onTap:() async{
                   AppProvider().seletedFiliereUpdate(AppProvider.filieres[index]);
                   setState(() {
                     AppProvider.seletedFiliere = AppProvider.filieres[index];


                   });
                   if(index == 0){
                     AppProvider.etudaints = await DatabaseManager.getUserByRole(2);
                     AppProvider.profs = await DatabaseManager.getUserByRole(1);
                    }else{
                     AppProvider.profs = [];
                     AppProvider.etudaints = [];
                   }
                   setState(() {
                     contentIndex = 0;
                     drawerIsOpen = !drawerIsOpen;
                   });
                 },
                 child: MenuItemBuilder(AppProvider.filieres[index].nom,Icon(Icons.add)),
               );
             }),
              const SizedBox(height: 18,),


            ],
          ),
        ),
        AnimatedContainer(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20 ,left: 10,right: 10),
          decoration:  BoxDecoration(
              color: Color(0xff0000FF),
              borderRadius:drawerIsOpen ?  BorderRadius.all( Radius.circular(20)) :  BorderRadius.all( Radius.circular(0))

          ),
          transform: Matrix4.translationValues(
              drawerIsOpen ? 150 :0,
              0,
              0),
          duration: Duration(milliseconds: 200),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child:Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: drawerIsOpen ?
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              drawerIsOpen = false;
                            });

                          },
                          child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                        )
                            : GestureDetector(
                          onTap: (){
                            setState(() {
                              drawerIsOpen = true;
                            });

                          },
                          child: Icon(Icons.menu,color: Colors.white,size: 30,),
                        ),
                      )
                      ,
                    ),
                    Expanded(
                        child:Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: ClipOval(
                                child:GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, "Profil");

                                  },
                                  child:  Image.asset(AppProvider.utilisateurCourant.image),

                                ),
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  child: Container(

                    child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Filiere : " + AppProvider.seletedFiliere.nom,style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: TextDecoration.none
                              ),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "AddFiliere");
                                },
                                child:Icon(Icons.add,size: 30,color: Colors.white,),

                              )
                            ],
                          ),
                          SingleChildScrollView(

                            child:  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder:
                                  (BuildContext context, int index)
                              {
                                return  GestureDetector(
                                  onTap: (){
                                    if(index == 0){
                                      AppProvider.selected = true;
                                    }
                                    else{
                                      AppProvider.selected = false;
                                    }
                                    Navigator.pushNamed(context, "FiliereDetail");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    margin:EdgeInsets.all(7) ,
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(index == 1 ? "Professeur" :"Etudiant",style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto",
                                          fontSize: 18,
                                          decoration: TextDecoration.none
                                      ),),
                                    ),

                                  ),
                                );

                              },
                            ),
                          )
                        ]
                    ),

                  ),
                )


              ],
            ),
          ),
        )
      ],
    );
  }

  Widget MenuItemBuilder( String name, Widget icon){
    return Row(
      children: [
        icon,
        SizedBox(width:15,),
        Text(name,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontFamily: "Roboto",
              fontSize: 18,
              decoration: TextDecoration.none
          ),)
      ],
    );


  }


}
