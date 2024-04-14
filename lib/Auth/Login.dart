import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:provider/provider.dart';

import '../SQlite/data.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /* TextEditingController email = TextEditingController(text: "boba@gmail.com");
  TextEditingController password = TextEditingController(text: "boba");
  */
  TextEditingController email = TextEditingController(text: "admin@gmail.com");
  TextEditingController password = TextEditingController(text: "admin");

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: MediaQuery.of(context).size.height * 0.20),
            decoration: const BoxDecoration( color: Color(0xff674dde)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Mot de passe",
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(200, 50),
                    ),
                    onPressed: () async {
                      bool credentialsValid = false;
                       List<Utilisateur>   Users = await DatabaseManager.getUsers();
                      for (Utilisateur utilisateur in Users) {
                        print("utilisateur ID  : ${utilisateur.id } Nom : ${utilisateur.nom}" );

                         if (utilisateur.email == email.text.trim() && utilisateur.password == password.text.trim()) {
                           credentialsValid = true;
                           AppProvider appProvider = AppProvider();
                           appProvider.updateUser(utilisateur);
                          break; // Pas besoin de continuer à parcourir la liste
                        }
                      }

                       if (credentialsValid) {

                         if(AppProvider.utilisateurCourant.role == 2) {
                           var clasroom = await DatabaseManager.getStudentById(AppProvider.utilisateurCourant.id!);
                           var cours =   await DatabaseManager.getModulesForFiliere(clasroom!.idFiliere);

                            List<Devoir> devoirsList = [];
                          for(var module in cours){

                            List<Devoir> devoirs = await DatabaseManager.getDevoirsForModule(module.id!);
                            devoirsList.addAll(devoirs);
                          }

                           AppProvider().updateDevoirs(devoirsList);
                           AppProvider().updateCours(cours);
                           AppProvider.filiereId = clasroom.idFiliere;
                           var projects = await DatabaseManager.getProjectsForUser(AppProvider.utilisateurCourant.id!);
                           AppProvider().updateProjects(projects);
                           AppProvider.notes = await DatabaseManager.getNotesForStudentFromDatabase(AppProvider.utilisateurCourant.id!);
                           AppProvider.courChapitres = await DatabaseManager.getCoursFromDatabase();
                           AppProvider.devoirRendue = [];
                           for( var devoir in devoirsList){
                             Rendue? rendue = await DatabaseManager.getRendueByIdDevoirAndIdEtudiant(devoir.id!,AppProvider.utilisateurCourant.id!);
                             if(rendue != null){
                               AppProvider.devoirRendue.add(rendue);

                             }else{
                               AppProvider.devoirRendue.add(Rendue( idDevoir: devoir.id!, idEtudiant: AppProvider.utilisateurCourant.id!, rendue: false));
                             }

                           }
                           for(var i = 0 ;i<AppProvider.devoirRendue.length;i++){
                             print(" index = $i : ${AppProvider.devoirRendue[i].rendue}");
                           }

                           Navigator.pushNamed(context, "HomeEtudiant");
                         } else if (AppProvider.utilisateurCourant.role == 1) {
                           Fluttertoast.showToast(msg: "Prof : account ");

                         }else{

                               AppProvider.etudaints = await DatabaseManager.getUserByRole(2);
                               AppProvider.profs = await DatabaseManager.getUserByRole(1);
                               Navigator.pushNamed(context, "HomeAdmin");
                          }

                      } else {
                         Fluttertoast.showToast(msg: "Email ou Mot de passe incorrect");
                      }

                    },
                    child: Text(
                      "connexion",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 1,
                  width: MediaQuery.of(context).size.width - 100,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pas de compte ? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "SignUp");
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: Transform.rotate(
                angle: 49 * 3.14 / 180,
                child: Image.asset(
                  "assets/images/bg_liquid.png",
                  height: 200,
                  width: 200,
                ),
              )),
          Positioned(
              bottom: -10,
              right: 0,
              child: Transform.rotate(
                angle: 20 * 3.14 / 180,
                child: Image.asset(
                  "assets/images/bg_liquid.png",
                  height: 200,
                  width: 200,
                ),
              ))
        ],
      ),
    );
  }
}
