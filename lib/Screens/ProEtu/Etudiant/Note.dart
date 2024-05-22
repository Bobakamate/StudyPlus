import 'package:flutter/material.dart';



class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My Note",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.none
                ),)
              ],
            ),
            SingleChildScrollView(

              child:  ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder:
                    (BuildContext context, int index)
                {
                  return  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "NoteDetail");
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
                        child: Text("Semester 8",style: TextStyle(
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
