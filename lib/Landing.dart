import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        )
    );
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top + 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child:Container(
                width: 380,
                alignment: Alignment.center,
                height: 380,


                child: Image.asset("assets/images/bglanding.png"),
              ) ,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,

                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: Text(
                  "StudyPlus"
                  ,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff674dde),
                    fontSize: 25
                ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "plateforme d'éducation en ligne conçue pour les etudiants et les enseignants",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,

                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "Login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color(0xff674dde),
                        minimumSize: Size(200, 50),
                      ),
                      child: Text("suivant",style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
