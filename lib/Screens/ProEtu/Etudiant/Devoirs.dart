import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';




class Devoirs extends StatefulWidget {
  const Devoirs({super.key});

  @override
  State<Devoirs> createState() => _DevoirsState();
}

class _DevoirsState extends State<Devoirs> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(

          children: [
            Text("Devoirs et Projet  a Rendre",style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Roboto",
                decoration: TextDecoration.none
            ),),
           SingleChildScrollView(

             child:  ListView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemCount: AppProvider.devoirs.length,
               itemBuilder:
                   (BuildContext context, int index)
               {
                 return  GestureDetector(
                   onTap: () async {
                     var prof = await DatabaseManager.getUserById(AppProvider.cours[index].profId);
                     AppProvider.devoirsDetail = AppProvider.devoirs[index];
                     AppProvider.devoirsDetailProf = prof!;
                     AppProvider.devoirsModule = getModule(AppProvider.devoirs[index].idModule)!;
                     AppProvider. indexRendue = index;

                     Navigator.pushNamed(context, "DevoirsDetail");
                   },
                   child: Container(
                     padding: EdgeInsets.all(7),
                     margin:EdgeInsets.all(7) ,
                     height: 200,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(  AppProvider.devoirs[index].isProjet == 0  ? "Devoir de : " +  getModuleName(AppProvider.devoirs[index].idModule): "Projet de : " + getModuleName(AppProvider.devoirs[index].idModule),style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "Roboto",
                                 fontSize: 18,
                                 decoration: TextDecoration.none
                             ),),
                             Text(getRendueByIdDevoirAndIdEtudiantFromList(AppProvider.devoirs[index].id!).rendue  ?  "Rendue" : "non rendue",style: TextStyle(
                                 color: getRendueByIdDevoirAndIdEtudiantFromList(AppProvider.devoirs[index].id!).rendue ? Colors.green : Colors.red,
                                 fontWeight: FontWeight.bold,
                                 fontFamily: "Roboto",
                                 fontSize: 16,
                                 decoration: TextDecoration.none
                             ),)
                           ],
                         ),SizedBox(height: 20,),
                         Container(
                           height: 100,
                           child:
                           Text(AppProvider.devoirs[index].description,style: TextStyle(
                               color: Colors.black,
                               fontWeight: FontWeight.normal,
                               fontFamily: "Roboto",
                               overflow: TextOverflow.ellipsis,
                               fontSize: 18,
                               decoration: TextDecoration.none
                           ),
                             maxLines: 4,),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [

                             Text("Date limite : "+ formatDateWithoutMilliseconds(AppProvider.devoirs[index].dateLimite),style:
                             TextStyle(
                               color: Colors.black,
                               fontSize: 16,
                               decoration: TextDecoration.none,
                               fontFamily: "Roboto",
                               fontWeight: FontWeight.normal,

                             ),)
                           ],
                         )


                       ],
                     ),

                   ),
                 );

               },
             ),
           )
          ]
      ),

    );
  }
  String getModuleName(int idModule){

    for(int i=0;i<AppProvider.cours.length;i++){
      if(AppProvider.cours[i].id == idModule){
        return AppProvider.cours[i].nom;
      }
    }
    return "";
  }
  Modules? getModule(int idModule){

    for(int i=0;i<AppProvider.cours.length;i++){
      if(AppProvider.cours[i].id == idModule){
        return AppProvider.cours[i];
      }
    }
    return null;
  }
  String formatDateWithoutMilliseconds(DateTime date) {
    // Formatage de la date
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    // Formatage de l'heure
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    // Concaténation de la date et de l'heure
    return '$day/$month/$year $hour:$minute';
  }
  Rendue getRendueByIdDevoirAndIdEtudiantFromList( int idDevoir) {
    return AppProvider.devoirRendue.firstWhere(
          (rendue) => rendue.idDevoir == idDevoir,

    );
  }

}
