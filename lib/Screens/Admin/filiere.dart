import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';



class Filieres extends StatefulWidget {
  const Filieres({super.key});

  @override
  State<Filieres> createState() => _FilieresState();
}

class _FilieresState extends State<Filieres> {
  @override
  Widget build(BuildContext context) {
    return Container(

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

    );
  }
}
