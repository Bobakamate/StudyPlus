import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/Screens/Admin/filiereDetail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Auth/Login.dart';
import 'EditProfil.dart';
import 'Landing.dart';
import 'Profil.dart';
import 'Screens/Admin/AddFiliere.dart';
import 'Screens/Admin/Home.dart';
import 'Screens/ProEtu/Etudiant/Home.dart';
import 'Screens/ProEtu/Etudiant/CoursDetail.dart';
import 'Screens/ProEtu/Etudiant/DevoirsDetail.dart';
import 'Screens/ProEtu/Etudiant/NoteDetail.dart';
import 'Screens/ProEtu/Etudiant/ProjetDetail.dart';
import 'Screens/ProEtu/Prof/home.dart';



void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.initializeDatabase();
  DatabaseManager.displayDatabase();
  var pref = await SharedPreferences.getInstance();
  var isFirstRunning = pref.getBool("FirstRunning");
  if (isFirstRunning == null) {
    await DatabaseManager.initDataForFirstTime();
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
          "HomeEtudiant" : (context) => HomeEtudiant(),
          "CoursDetail" : (context) => CoursDetail(),
          "Profil" : (context) => Profil(),
          "DevoirsDetail" :(context) => DevoirsDetail(),
          "ProjetDetail" :(context) => ProjetDetail(),
          "NoteDetail" :(context) => NoteDetail(),
          "HomeAdmin" :(context) => Home(),
          "FiliereDetail" :(context) => FiliereDetail(),
          "profhome" :(context) => profhome(),
          "EditProfil" :(context) => EditUserPage(),
          "AddFiliere" :(context) => AddFiliere(),
        },
        initialRoute: "/",
        debugShowCheckedModeBanner: false,

      ),);
  }
}
