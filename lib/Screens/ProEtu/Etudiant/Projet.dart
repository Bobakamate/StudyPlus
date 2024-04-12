import 'package:flutter/material.dart';

import '../../../Provider/AppProvider.dart';
import '../../../SQlite/bdd.dart';
import '../../../SQlite/data.dart';


class Projet extends StatefulWidget {
  const Projet({super.key});

  @override
  State<Projet> createState() => _ProjetState();
}

class _ProjetState extends State<Projet> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mes Projets",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.none
                ),),
                GestureDetector(
                  onTap: (){
                    //Navigator.pushNamed(context, "");
                  },
                  child:Icon(Icons.add,color: Colors.white,size: 30,),
                ),
              ],
            ),
            SingleChildScrollView(

              child:  ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppProvider.projets.length,
                itemBuilder:
                    (BuildContext context, int index)
                {
                  return  GestureDetector(
                    onTap: () async {
                      var prof = await DatabaseManager.getUserById(AppProvider.cours[index].profId);
                      AppProvider.projetDetail = AppProvider.projets[index];
                      AppProvider.projetDetailProf = prof!;
                      AppProvider.projetModule = getModule(AppProvider.projets[index].idModule)!;

                      Navigator.pushNamed(context, "ProjetDetail");
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
                          Text( "Projet de : "+ getModuleName(AppProvider.projets[index].idModule),style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                              fontSize: 18,
                              decoration: TextDecoration.none
                          ),),SizedBox(height: 20,),
                          Container(
                            height: 100,
                            child:
                            Text(AppProvider.projets[index].description,style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Roboto",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                decoration: TextDecoration.none
                            ),
                              maxLines: 4,),
                          ),



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
}
