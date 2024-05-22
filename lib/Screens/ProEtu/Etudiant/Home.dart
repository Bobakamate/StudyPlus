import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Cours.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Devoirs.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Note.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Projet.dart';

import '../../../Provider/AppProvider.dart';


class HomeEtudiant extends StatefulWidget {
  const HomeEtudiant({super.key});

  @override
  State<HomeEtudiant> createState() => _HomeEtudiantState();
}

class _HomeEtudiantState extends State<HomeEtudiant> {
  bool drawerIsOpen = false;
  int contentIndex = 0;
  List<Widget> content = [Cours(),Devoirs(),Projet(),Note()];
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
              GestureDetector(
                onTap:(){
                  setState(() {
                    contentIndex = 0;
                    drawerIsOpen = !drawerIsOpen;
                  });
                       },
                child: MenuItemBuilder("courses",Icon(Icons.home)),
              ),
              const SizedBox(height: 18,),
              GestureDetector(
                onTap:(){
                  setState(() {
                    contentIndex = 1;
                    drawerIsOpen = !drawerIsOpen;
                  });
                },
                child: MenuItemBuilder("Homework",Icon(Icons.home_work)),
              ),



              const SizedBox(height: 18,),
              GestureDetector(
                onTap:(){
                  setState(() {
                    contentIndex = 3;
                    drawerIsOpen = !drawerIsOpen;
                  });
                },
                child: MenuItemBuilder("Note",Icon(Icons.school)),
              ),


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
                  child: content[contentIndex],
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
