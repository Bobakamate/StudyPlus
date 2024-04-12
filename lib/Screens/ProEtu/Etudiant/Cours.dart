import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:sqflite/sqflite.dart';

class Cours extends StatefulWidget {
  const Cours({super.key});

  @override
  State<Cours> createState() => _CoursState();
}

class _CoursState extends State<Cours> {


 @override
  void initState()   {

    super.initState();

 }
 @override
  void didChangeDependencies()  {

    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
        children: [
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (AppProvider.cours.length / 2).ceil(), // Nombre de lignes
            itemBuilder: (BuildContext context, int index) {
              final int startIndex = index * 2; // Index de début pour chaque ligne
              final int endIndex = startIndex + 2; // Index de fin pour chaque ligne

              return Padding(padding:EdgeInsets.only(bottom: 20) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = startIndex; i < endIndex && i < AppProvider.cours.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child:GestureDetector(
                        onTap: () async {
                          var prof = await DatabaseManager.getUserById(AppProvider.cours[i].profId);
                          AppProvider.coursDetailProf = prof! ;
                          AppProvider.coursDetail = AppProvider.cours[i];


                          Navigator.pushNamed(context, "CoursDetail");

                        },
                        child:  courItems(AppProvider.cours[i].nom, AppProvider.cours[i].image),

                      ),
                    ),
                ],
              ),);
            },
          )
        ],
      ),
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
