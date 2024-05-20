

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:manform/Screens/ProEtu/Etudiant/Note.dart';

class AppProvider extends ChangeNotifier {

  static Utilisateur utilisateurCourant = Utilisateur(
    nom: '',
    email: '',
    password: '',
    role: 0, image: '',
  );
  static List<Rendue> devoirRendue =[];
  static int indexRendue = 0;

  static int filiereId = 0;

  static List<Utilisateur> students = [];

  // section cours
  static Modules coursDetail = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
  static Utilisateur coursDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0, image: '');

  // section devoirs
  static Modules devoirsModule = Modules(nom: "", profId: 0, description: "", image: "", idFiliere: 0);
  static List<Devoir> devoirs = [];
  static Utilisateur devoirsDetailProf =Utilisateur(nom: '', email: '', password: '', role: 0, image: '');
  static Devoir devoirsDetail = Devoir(rendue: 0, nom: '', dateLimite: DateTime.now(), description: '', idModule: 0, isProjet: 0,);

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
  static List<Filiere> filieres = [];
  static Filiere seletedFiliere  = Filiere(
    nom: "",
    semestre: "",
  );

void filieresUpdate(List<Filiere> filieresL) {
  filieres = filieresL;
  notifyListeners();
}
void seletedFiliereUpdate(Filiere filiere) {
  seletedFiliere = filiere;
  notifyListeners();
}

  static List<Cours> chapters = [];

  void updateChapter(List<Cours> chapter) {
    chapters = chapter;
    notifyListeners();
  }

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


  void updateCoursDetail(Modules module) {
    coursDetail = module;
    notifyListeners();
  }

  void addCours(Cours chapter) {
    try{
      DatabaseManager.insertCours(chapter);
      notifyListeners();

    }
    catch(e){
      print('error adding course');
    }
  }

  void updateCourseInDatabase(Cours chapter) {
    try{
      DatabaseManager.updateCours(chapter);
      for (int i = 0; i < chapters.length; i++) {
        if (chapters[i].id == chapter.id) {
          chapters[i] = chapter;
          break;
        }
      }

      notifyListeners();
    }
    catch(e){
      print('error updating course');
    }
  }

  void deleteCourseFromDatabase(Cours chapter) {
    try{
      DatabaseManager.deleteCours(chapter);
      chapters.remove(chapter);
      notifyListeners();
    }
    catch(e){
      print('error deleting course');
    }
  }

  void addDevoir(Devoir devoir) {
    try{
      DatabaseManager.insertDevoir(devoir);
      notifyListeners();
    }
    catch(e){
      print('error adding devoir');
    }
  }

  void updateDevoirInDatabase(Devoir devoir) {
    try{
      DatabaseManager.updateDevoir(devoir);
      for (int i = 0; i < devoirs.length; i++) {
        if (devoirs[i].id == devoir.id) {
          devoirs[i] = devoir;
          break;
        }
      }

      notifyListeners();
    }
    catch(e){
      print('error updating devoir');
    }
  }

  void deleteDevoirFromDatabase(Devoir devoir) {
    try{
      DatabaseManager.deleteDevoir(devoir);
      devoirs.remove(devoir);
      notifyListeners();
    }
    catch(e){
      print('error deleting devoir');
    }
  }

  void addProjet(Projet projet) {
    try{
      DatabaseManager.insertProjet(projet);
      notifyListeners();
    }
    catch(e){
      print('error adding projet');
    }
  }

  void updateProjetInDatabase(Projet projet) {
    try{
      DatabaseManager.updateProjet(projet);
      for (int i = 0; i < projets.length; i++) {
        if (projets[i].id == projet.id) {
          projets[i] = projet;
          break;
        }
      }

      notifyListeners();
    }
    catch(e){
      print('error updating projet');
    }
  }

  void deleteProjetFromDatabase(Projet projet) {
    try{
      DatabaseManager.deleteProjet(projet);
      projets.remove(projet);
      notifyListeners();
    }
    catch(e){
      print('error deleting projet');
    }
  }



  void updateNote(int noteid, double newnote) {
    Notes note = Notes(id: 0, idEtudiant: 0, idModule: 0, note: 0);
    try{
      for (var currnote in notes) {
        if (currnote.id == noteid) {
          note = currnote;
          currnote.note = newnote;
          break;
        }
      }
      DatabaseManager.updateNoteInDatabase(note, newnote);

      notifyListeners();
    }
    catch(e){
      print('error updating note');
    }
  }

  void addNoteInDatabase(Notes note) {
    try{
      DatabaseManager.insertNotes(note);
      notes.add(note);
      notifyListeners();
    }
    catch(e){
      print('error adding note');
    }
  }
}