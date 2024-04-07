import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool drawerIsOpen = false;
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
    if (!drawerIsOpen){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
          ));
    }else{
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark
          ));
    }
    return Stack(
      children: [
        Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15,left: 10),
          decoration:  BoxDecoration(
              color: Colors.white
          ),
          child: Column(
            children: [
              MenuItemBuilder("Acceuil",Icon(Icons.home)),
              const SizedBox(height: 18,),
              MenuItemBuilder("Devoirs",Icon(Icons.home_work)),
              const SizedBox(height: 18,),
              MenuItemBuilder("Projet",Icon(Icons.book)),
              const SizedBox(height: 18,),
              MenuItemBuilder("Note",Icon(Icons.school)),
              const SizedBox(height: 18,),
              MenuItemBuilder("Admin",Icon(Icons.settings)),
              const SizedBox(height: 18,),
            ],
          ),
        ),
        AnimatedContainer(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20 ,left: 10,right: 10),
          decoration:  BoxDecoration(
              color: Colors.orange,
              borderRadius:drawerIsOpen ?  BorderRadius.all( Radius.circular(20)) :  BorderRadius.all( Radius.circular(0))

          ),
          transform: Matrix4.translationValues(
              drawerIsOpen ? 150 :0,
              0,
              0),
          duration: Duration(milliseconds: 500),
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
                              child: Image.asset("assets/images/profil.jpg"),
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Mes Cours",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 25,
                    decoration: TextDecoration.none
                ),),

              ),
              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    courItems( "SR Informatique",  "assets/images/c1.jpg"),
                    SizedBox(width: 30,),
                    courItems( "BDD",  "assets/images/c2.jpg")
                  ]
              ),SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    courItems( "Dev Web",  "assets/images/c3.jpg"),
                    SizedBox(width: 30,),
                    courItems( "Modelisation",  "assets/images/c4.jpg")
                  ]
              ),SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    courItems( "Dart",  "assets/images/c5.jpg"),
                    SizedBox(width: 30,),
                    courItems( "Soft Skill",  "assets/images/c6.jpg")
                  ]
              ),


            ],
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

  Widget courItems(String courname, String image){
    return Row(

      children: [
        Column(
          children: [
            Text(courname,style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                fontSize: 18,
                decoration: TextDecoration.none
            ),),
            SizedBox(height: 10,),
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(image,fit: BoxFit.cover,),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
