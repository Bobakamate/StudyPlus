

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Provider/AppProvider.dart';
import '../../../SQlite/bdd.dart';
import '../../../SQlite/data.dart';



class DevoirsDetail extends StatefulWidget {
  const DevoirsDetail({super.key});

  @override
  State<DevoirsDetail> createState() => _DevoirsDetailState();
}

class _DevoirsDetailState extends State<DevoirsDetail> {
  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Image.asset(AppProvider.devoirsModule.image,
              height: 300,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: 1500,
              width: MediaQuery.of(context).size.width,),
            Positioned(

                top: 10 + 250,
                child:  Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1500,
                  padding: EdgeInsets.only(left: 10,
                      right: 10,top: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff0000FF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),



                  ),
                  child: Column(
                    children: [
                      Row(
                         children: [

                          Container(
                            width: MediaQuery.of(context).size.width-30,
                            child:Text(   AppProvider.devoirsDetail.isProjet == 0  ?   "Project  : "  +  AppProvider.devoirsModule.nom  : "Homework  : "+ AppProvider.devoirsModule.nom,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),

                          ),


                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          getRendueByIdDevoirAndIdEtudiantFromList(AppProvider.devoirsDetail.id!).rendue  ?
                          "Rendered": "Not rendered",
                          style: TextStyle(
                            color: getRendueByIdDevoirAndIdEtudiantFromList(AppProvider.devoirsDetail.id!).rendue ? Color(0xff39ff14) : Color(0xffff0040), // Vert vif pour "Rendue", Rouge vif pour "Non rendue"
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                            fontSize: 16,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Teacher : "+ AppProvider.devoirsDetailProf.nom,style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Description:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(AppProvider.devoirsDetail.nom,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      ),SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(AppProvider.devoirsDetail.description,style: TextStyle(color: Colors.white,fontSize: 18),),
                      ),SizedBox(height: 20,),

                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Instructions",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Click 'Submit' to attach a file and submit the assignment.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Click 'Download' to download the assignment.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),SizedBox(height: 40,)
                      ,
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    child:Text("File containing details about the " + (AppProvider.devoirsDetail.isProjet == 0  ? "Project" :"Homework" ),
                                      overflow :TextOverflow.ellipsis , maxLines : 1, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      Fluttertoast.showToast(msg: "Downloading...");

                                    },
                                    child: Icon(Icons.download),
                                  ),
                                ]),
                            SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: MediaQuery.of(context).size.width - 10,

                              child:Text("To complete the " +(AppProvider.devoirsDetail.isProjet == 0  ? "Project" :"Homework" ) +", please download the necessary file by clicking the link below. ",

                                overflow :TextOverflow.ellipsis,  maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 16)
                                ,),

                            )
                          ],

                        ),
                      ),


                      Expanded(
                          child: Container(

                            alignment: Alignment.topCenter,

                            padding: EdgeInsets.only(top: 50,left: 10,right: 10),
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(onPressed: () async {
                                  PermissionStatus permission = await Permission.storage.request();

                                  PermissionStatus status = await checkStoragePermissionStatus();

                                  if (permission.isGranted) {
                                    // Si la permission est accordée
                                    // Effectuer l'action après avoir obtenu la permission
                                    if (await openFileExplorer(context)) {
                                       DatabaseManager.updateDevoirRendue(
                                          AppProvider.devoirsDetail.id!, AppProvider.devoirsDetail.rendue);
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => DevoirsDetail()));
                                      Fluttertoast.showToast(msg: "Devoir rendu");
                                    } else {
                                      Fluttertoast.showToast(msg: "Please select a file");
                                    }
                                  } else {
                                    // Si la permission est refusée
                                    Fluttertoast.showToast(msg: "Permission refusée");
                                  }

                                },
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(150, 40),
                                    minimumSize: Size(150, 40),
                                  ),
                                  child: Text("Submit",style: TextStyle(color: Colors.black),),),

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

  Future<bool> openFileExplorer(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
    return true;
    } else {
      return false ;
    }
  }
  Future<void> requestStoragePermission() async {
    PermissionStatus permission = await Permission.storage.request();
  }

// Fonction pour vérifier le statut de la permission de stockage
  Future<PermissionStatus> checkStoragePermissionStatus() async {
    PermissionStatus status = await Permission.storage.status;
    return status;
  }
  Rendue getRendueByIdDevoirAndIdEtudiantFromList( int idDevoir) {
    return AppProvider.devoirRendue.firstWhere(
          (rendue) => rendue.idDevoir == idDevoir,

    );
  }
 }




