import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Auth/Login.dart';
import 'Landing.dart';
import 'Profil.dart';
import 'Screens/ProEtu/Etudiant/Home.dart';
import 'Screens/ProEtu/Etudiant/CoursDetail.dart';
import 'Screens/ProEtu/Etudiant/DevoirsDetail.dart';
import 'Screens/ProEtu/Etudiant/NoteDetail.dart';
import 'Screens/ProEtu/Etudiant/ProjetDetail.dart';



void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.initializeDatabase();
  DatabaseManager.displayDatabase();
  var pref = await SharedPreferences.getInstance();
  var isFirstRunning = pref.getBool("FirstRunning");
  if (isFirstRunning == null) {
    await DatabaseManager.initData();
    await pref.setBool("FirstRunning", true); // Correction de la clé ici
  }



   //await DatabaseManager.clearDatabase();
  AppProvider.bddUsers = await DatabaseManager.getUsers();
  for(var user in AppProvider.bddUsers){
    print("ID  : ${user.id } Nom : ${user.nom}" );
  }
  if(AppProvider.bddUsers.isEmpty){
    print("Vide ");
  }

  DatabaseManager.displayDatabase();


  runApp(const StudyPlus());
}

class StudyPlus extends StatefulWidget {
  const StudyPlus({super.key});

  @override
  State<StudyPlus> createState() => _StudyPlusState();
}

class _StudyPlusState extends State<StudyPlus> {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create:(context) => AppProvider(),
    child: MaterialApp(
      routes: {
        "/":(context) => Landing(),
        "Login":(context) => Login(),
        "HomeEtudiant" : (context) => Home(),
        "CoursDetail" : (context) => CoursDetail(),
        "Profil" : (context) => Profil(),
        "DevoirsDetail" :(context) => DevoirsDetail(),
        "ProjetDetail" :(context) => ProjetDetail(),
        "NoteDetail" :(context) => NoteDetail(),
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,

    ),);
  }
}
