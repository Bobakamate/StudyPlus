import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manform/Provider/AppProvider.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20 ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff674dde),
            child: Column(
              children: [
                ClipOval(

                  child: Image.asset("assets/images/profil.jpg",
                    height: 100,
                    width: 100,),
                ),
                SizedBox(height: 20,),
                Text(AppProvider.utilisateurCourant.nom ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: 30,),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: GestureDetector(

                        child:  Row(
                          children: [
                            Icon(Icons.account_circle_outlined,size: 40,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text("Modifier",style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            )
                            )
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),

              ],
            ),

          ),Positioned(
            top: MediaQuery.of(context).padding.top + 30,
            left: 20,
            child: GestureDetector(
              onTap: (){
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light
                ));
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileItem({required String title, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
