import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';

import 'SQlite/bdd.dart';

class EditUserPage extends StatefulWidget {



  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController nomController;
  late TextEditingController emailController;
  late TextEditingController passwordController;


  @override
  void initState() {
    super.initState();
    nomController = TextEditingController(text: AppProvider.utilisateurCourant.nom);
    emailController = TextEditingController(text:  AppProvider.utilisateurCourant.email);
        passwordController = TextEditingController(text: AppProvider.utilisateurCourant.password);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Modifier le profil"),
        backgroundColor:  Color(0xff674dde),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color(0xff674dde),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                  border: InputBorder.none,),

              ),

            ),
            SizedBox(height: 10),

            Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,),

                )),
               SizedBox(height: 10),
            Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  controller: passwordController ,
                  decoration: InputDecoration(
                    border: InputBorder.none,),

                )),

             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async  {
                await DatabaseManager.updateUserById(
                  AppProvider.utilisateurCourant.id!,
                  nomController.text,
                  emailController.text,
                  passwordController.text,

                );
                setState(() {
                    AppProvider.utilisateurCourant.nom  =  nomController.text ;
                   AppProvider.utilisateurCourant.email = emailController.text ;
                  AppProvider.utilisateurCourant.password = passwordController.text ;


                });
                Navigator.pop(context);
              },
              child: Text('Enregistrer',style: TextStyle(
                color: Colors.black
              ),),
            ),
          ],
        ),
      ),
    );
  }



}
