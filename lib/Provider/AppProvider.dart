

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manform/SQlite/data.dart';

class AppProvider extends ChangeNotifier {

 static Utilisateur utilisateurCourant = Utilisateur(
    nom: '',
    email: '',
    password: '',
    role: 0,
  );
 static int filiereId = 0;
 // section cours
 static Modules coursDetail = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
 static Utilisateur coursDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0);


 // section devoirs
 static Modules devoirsModule = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
 static List<Devoir> devoirs = [];
 static Utilisateur devoirsDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0);
 static Devoir devoirsDetail = Devoir(rendue: 0, nom: '', dateLimite: DateTime.now(), description: '', idModule: 0,);

// section du projet
  static Modules projetModule = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
 static Projet projetDetail = Projet(idModule: 0, titre: '', description: '', image: '', idEtudiant: 0);
 static List<Projet> projets = [];
  static Utilisateur  projetDetailProf = Utilisateur(nom: '', email: '', password: '', role: 0);

// note etudiant

  static List<Notes> notes =[];
  static List<Modules> cours = [];
 static List<Utilisateur> bddUsers = [];

  void updateUser(Utilisateur user) {
    utilisateurCourant = user;
    notifyListeners();
  }
   void updateUsers(List<Utilisateur> users) {
    bddUsers = users;
    notifyListeners();
  }
  void updateDevoirs(List<Devoir> devoir) {
    devoirs = devoir;
    notifyListeners();
  }
  void updateCours(List<Modules> modules) {
    cours = modules;
    notifyListeners();
  }
  void updateProjects(List<Projet> projet) {
    projets = projet;
    notifyListeners();
  }

}