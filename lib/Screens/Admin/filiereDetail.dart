import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';

import '../../Provider/AppProvider.dart';


class FiliereDetail extends StatefulWidget {
  const FiliereDetail({super.key});

  @override
  State<FiliereDetail> createState() => _FiliereDetailState();
}

class _FiliereDetailState extends State<FiliereDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _moduleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showDialog(context ,AppProvider.selected ? 2 : 1);
          // Action à exécuter lorsque le bouton est cliqué

        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Position du bouton

      appBar: AppBar(
        title: Text(""),
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
                itemCount:  AppProvider.selected ? AppProvider.etudaints.length : AppProvider.profs.length,
                itemBuilder: (context, index) {
                  // Récupérer le nom du module et la note à partir de la liste de notes
                  String moduleName = AppProvider.selected ? AppProvider.etudaints[index].nom : AppProvider.profs[index].nom;


                  return Card(
                    child: ListTile(
                      title: Text(moduleName), // Nom du module
                      trailing: Text("",style: TextStyle(fontSize: 18),), // Note sur 20 avec une décimale
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
  // Add this function to show a dialog to add a student or professor
  void _showDialog(BuildContext context, int role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un nouveau ${role == 1 ? 'professeur' : 'étudiant'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                ),
                if (role == 1)
                  TextField(
                    controller: _moduleController,
                    decoration: const InputDecoration(labelText: 'Module'),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () async {
                String nom = _nameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                int etudId = await DatabaseManager.insertUtilisateur(
                Utilisateur(nom: nom,
                    image: "assets/images/profil_icon.png",
                    email: email,
                    password: password,
                    role: role
                ) ,
                );
                int? idfiliere = await  DatabaseManager.getFiliere("IDAI");
                await DatabaseManager.insertClassroom(
                    Classroom(idEtudiant: etudId,
                        idFiliere: idfiliere!
                    )
                );

              AppProvider().updateEtudiantProf(await DatabaseManager.getUserByRole(2), await DatabaseManager.getUserByRole(1));

               await  DatabaseManager.displayDatabase();



                // Vérifier si tous les champs sont remplis
                if (nom.isEmpty || email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(msg: "Veuillez remplir tous les champs");
                  return;
                }

                // Appeler la fonction pour ajouter un nouvel utilisateur
                /*if (role == 1) {
                  // Ajouter un professeur
                  String module = _moduleController.text;
                  if (module.isEmpty) {
                    Fluttertoast.showToast(msg: "Veuillez entrer un module");
                    return;
                  }
                 } else {
                  // Ajouter un étudiant
                 }*/

                // Effacer les champs après l'ajout
                _nameController.clear();
                _emailController.clear();
                _passwordController.clear();
                _moduleController.clear();

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
