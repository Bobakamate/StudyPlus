import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Devoirs.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  // Méthode pour obtenir les notes de l'étudiant par module
  Map<String, double> getStudentGrades() {
    // Note de Boba pour chaque module
    return {
      "SR Informatique": 18.5,
      "BDD": 17.0,
      "Dev Web": 19.0,
      "Modélisation": 18.0,
      "Dart": 19.5,
      "Soft Skills": 17.5,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer les notes de l'étudiant
    Map<String, double> studentGrades = getStudentGrades();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Notes"),
        backgroundColor:  Color(0xff674dde),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff674dde),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: AppProvider.notes.length,
                itemBuilder: (context, index) {
                  // Récupérer le nom du module et la note à partir de la liste de notes
                  String moduleName = getModuleName(AppProvider.notes[index].idModule);
                  double grade = AppProvider.notes[index].note;

                  return Card(
                    child: ListTile(
                      title: Text(moduleName), // Nom du module
                      trailing: Text(grade.toStringAsFixed(2),style: TextStyle(fontSize: 18),), // Note sur 20 avec une décimale
                    ),
                  );
                },
              ),
            ),
          ),
        ),
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
}
