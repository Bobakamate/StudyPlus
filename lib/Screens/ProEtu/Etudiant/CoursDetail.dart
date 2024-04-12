import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manform/Provider/AppProvider.dart';


class CoursDetail extends StatefulWidget {
  const CoursDetail({super.key});

  @override
  State<CoursDetail> createState() => _CoursDetailState();
}

class _CoursDetailState extends State<CoursDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Image.asset(AppProvider.coursDetail.image,
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
                  color: Color(0xff674dde),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),



                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(AppProvider.coursDetail.nom,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("prof : "+ AppProvider.coursDetailProf.nom,style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Description:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text(AppProvider.coursDetail.description,style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Instruction",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18),),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("clicker sur download pour telecharger le cour",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),

                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 100),

                          alignment: Alignment.topCenter,
                          height: 40,
                          width: 200,
                          child: ElevatedButton(onPressed: (){
                            Fluttertoast.showToast(msg: "Lancement du telechargement");
                          },
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size(200, 40),
                              minimumSize: Size(200, 40),
                            ),
                            child: Text("Download",style: TextStyle(color: Colors.black),),),
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
