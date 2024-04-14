

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manform/SQlite/data.dart';

class AppProvider extends ChangeNotifier {

  static Utilisateur utilisateurCourant = Utilisateur(
    nom: '',
    email: '',
    password: '',
    role: 0, image: '',
  );
  static List<Rendue> devoirRendue =[];
  static int filiereId = 0;
  static int indexRendue = 0;
  // section cours
  static Modules coursDetail = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
  static Utilisateur coursDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0, image: '');


  // section devoirs
  static Modules devoirsModule = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
  static List<Devoir> devoirs = [];
  static Utilisateur devoirsDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0, image: '');
  static Devoir devoirsDetail = Devoir(rendue: 0, nom: '', isProjet: 0, dateLimite: DateTime.now(), description: '', idModule: 0,);

// section du projet
  static Modules projetModule = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
  static Projet projetDetail = Projet(idModule: 0, titre: '', description: '', image: '', idEtudiant: 0);
  static List<Projet> projets = [];
  static Utilisateur  projetDetailProf = Utilisateur(nom: '', email: '', password: '', role: 0, image: '');
  static List<Cours>  courChapitres = [];

// note etudiant

  static List<Notes> notes =[];
  static List<Modules> cours = [];
  static List<Utilisateur> bddUsers = [];

  // partie admin

  static List<Utilisateur> etudaints = [];
  static List<Utilisateur> profs = [];
  static bool selected = true;




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
  void toggleDevoirRendueStatus() {
    devoirsDetail.rendue  = devoirsDetail.rendue == 0 ? 1 : 0;
    devoirs[indexRendue] = devoirsDetail;


    // Notifier les écouteurs de changement
    notifyListeners();
  }
  void updateEtudiantProf(List<Utilisateur> etudaintsL , List<Utilisateur> profsL) {
    etudaints = etudaintsL;
    profs = profsL;
    notifyListeners();
  }


}