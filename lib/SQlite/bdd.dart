import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseManager {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE utilisateurs(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, email TEXT, password TEXT, role INTEGER)",
        );
        await db.execute(
          "CREATE TABLE modules(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, profId INTEGER, description TEXT, image TEXT, idFiliere INTEGER)",
        );
        await db.execute(
          "CREATE TABLE devoirs(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, dateLimite TEXT, description TEXT, image TEXT, idModule INTEGER, rendue INTEGER)",
        );
        await db.execute(
          "CREATE TABLE filieres(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, semestre TEXT)",
        );
        await db.execute(
          "CREATE TABLE classrooms(id INTEGER PRIMARY KEY AUTOINCREMENT, idEtudiant INTEGER, idFiliere INTEGER)",
        );
        await db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, idEtudiant INTEGER, idModule INTEGER, note REAL)",
        );
        await db.execute(
          "CREATE TABLE cours(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, resume TEXT, idModule INTEGER)",
        );
        await db.execute(
          "CREATE TABLE projets(id INTEGER PRIMARY KEY AUTOINCREMENT, titre TEXT, description TEXT, image TEXT, idEtudiant INTEGER,idModule INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<void> clearDatabase() async {
    final Database db = await database; // Assurez-vous d'avoir une méthode 'database' pour obtenir la référence à la base de données

    // Supprimer toutes les données de chaque table
    await db.delete('utilisateurs');
    await db.delete('modules');
    await db.delete('filieres');
    await db.delete('classrooms');
    // Ajoutez d'autres tables si nécessaire

    print('Base de données vidée avec succès.');
  }

  static Future<void> initData() async {
    // Insérer les utilisateurs (professeurs)
    final int boba = await insertUtilisateur(
      Utilisateur(
        nom: 'Boba Kamate',
        email: 'boba@gmail.com',
        password: 'boba',
        role: 2, // Le rôle du professeur est 2
      ),
    );

     final int daveProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Dave Wiliams',
        email: 'dave@gmail.com',
        password: 'dave',
        role: 1, // Le rôle du professeur est 1
      ),
    );

     final int karimProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Karim El Bahri',
        email: 'karim@gmail.com',
        password: 'karim',
        role: 1, // Le rôle du professeur est 1
      ),
    );

     final int fatimaProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Fatima Essaadi',
        email: 'fatima@gmail.com',
        password: 'fatima',
        role: 1, // Le rôle du professeur est 1
      ),
    );






    // Insérer les filieres
    final int IDAIid = await insertFiliere(Filiere(
      nom: "IDAI",
      semestre: "S5",
    ));
    final int ADid = await insertFiliere(Filiere(
       nom: "AD",
       semestre: "S5",
     ));
     await insertClassroom(
       Classroom(
           idEtudiant: boba,
           idFiliere: IDAIid)
     );

    // Insérer les modules
   var srinformatique=  await insertModule(Modules(
      nom: "SR Informatique",
      description: "Ce module aborde les concepts avancés en science informatique, y compris les algorithmes, les structures de données et les principes de conception logicielle.",
      image: "assets/images/c1.jpg",
      idFiliere: IDAIid,
      profId: fatimaProfId,
    ));

    var bdd =await insertModule(Modules(
      nom: "BDD",
      description: "Ce module couvre les bases de données relationnelles et non relationnelles, ainsi que les langages de requête associés comme SQL.",
      image: "assets/images/c2.jpg",
      idFiliere: IDAIid,
      profId: daveProfId,
    ));

    var devweb = await insertModule(Modules(
      nom: "Dev Web",
      description: "Ce module explore les technologies et les outils utilisés pour le développement web, y compris HTML, CSS, JavaScript et les frameworks associés.",
      image: "assets/images/c3.jpg",
      idFiliere: IDAIid,
      profId: daveProfId,
    ));

    var modelisation = await insertModule(Modules(
      nom: "Modélisation",
      description: "Ce module se concentre sur les techniques de modélisation utilisées pour concevoir des systèmes logiciels et matériels.",
      image: "assets/images/c4.jpg",
      idFiliere: IDAIid,
      profId: karimProfId,
    ));

    var dart = await insertModule(Modules(
      nom: "Dart",
      description: "Ce module introduit le langage de programmation Dart et son utilisation pour développer des applications mobiles et web avec Flutter.",
      image: "assets/images/c5.jpg",
      idFiliere: IDAIid,
      profId: karimProfId,
    ));

    var softskil = await insertModule(Modules(
      nom: "Soft Skills",
      description: "Ce module met l'accent sur le développement des compétences non techniques, telles que la communication, le travail d'équipe et la résolution de problèmes.",
      image: "assets/images/c6.jpg",
      idFiliere: IDAIid,
      profId: fatimaProfId,
    ));

    await insertDevoir(Devoir(
      nom: "Analyse de cas pratique en résolution de problèmes",
      rendue: 0, // Non rendue
      dateLimite:  DateTime(2024, 5, 11, 23, 45),
      description: "Dans ce devoir, les étudiants devront analyser un cas pratique en résolution de problèmes lié aux soft skills. Ils devront identifier les problèmes, proposer des solutions efficaces en utilisant des techniques de communication et de travail d'équipe, et justifier leurs choix. Le devoir devra inclure une analyse détaillée ainsi que des recommandations concrètes pour résoudre le problème.",
      idModule: softskil, // ID du module de la filière IDAI
    ));

    await insertDevoir(Devoir(
      nom: "Développement d'une application mobile avec Flutter",
      rendue: 0, // Non rendue
      dateLimite: DateTime(2024, 5, 22, 23, 45), // Remplacez par la date limite appropriée
      description: "Dans ce devoir, les étudiants devront concevoir et développer une application mobile fonctionnelle en utilisant le langage de programmation Dart et le framework Flutter. L'application devra répondre à des besoins spécifiques fournis dans l'énoncé du devoir. Les étudiants devront également fournir une documentation détaillée de leur travail, y compris les choix de conception, les fonctionnalités implémentées et les tests effectués.",
      idModule: dart, // ID du module de la filière IDAI
    ));

    await insertDevoir(Devoir(
      nom: "Conception et implémentation d'une base de données relationnelle",
      rendue: 0, // Non rendue
      dateLimite:DateTime(2024, 5, 12, 2, 45), // Remplacez par la date limite appropriée
      description: "Dans ce devoir, les étudiants devront concevoir le schéma d'une base de données relationnelle en fonction d'un ensemble de spécifications données. Ils devront ensuite mettre en œuvre ce schéma en utilisant le langage SQL. Les étudiants seront évalués sur la clarté et la cohérence de leur conception de base de données, ainsi que sur la qualité de leur implémentation SQL. Le devoir devra être accompagné d'une documentation détaillée expliquant la structure de la base de données et justifiant les choix de conception.",
      idModule: bdd, // ID du module de la filière IDAI
    ));
    Future<void> insertNotes(List<Notes> notes) async {
      // Récupérer une référence à la base de données
      final Database db = await database;

      // Insérer chaque note dans la base de données
      for (var note in notes) {
        await db.insert(
          'notes',
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace, // Remplacer en cas de conflit
        );
      }
    }

    int projetId = await insertProjet( Projet(
      titre: "Développement d'une application mobile de gestion de tâches",
      description: "Ce projet consiste à développer une application mobile de gestion de tâches pour aider les utilisateurs à organiser leurs activités quotidiennes. L'application permettra de créer, modifier et supprimer des tâches, ainsi que de définir des rappels pour les échéances importantes.",
      image: "assets/images/mobile_app_project.png",
      idModule : dart,
      idEtudiant: boba, // ID de Boba
    ));

    List<Notes> notesList = [
      Notes(
        idEtudiant: boba,
        idModule: softskil, // ID du module SR Informatique
        note: 18.5,
      ),
      Notes(
        idEtudiant: boba,
        idModule: srinformatique, // ID du module BDD
        note: 17.0,
      ),
      Notes(
        idEtudiant: boba,
        idModule: dart, // ID du module Dev Web
        note: 19.0,
      ),
      Notes(
        idEtudiant: boba,
        idModule: modelisation, // ID du module Modélisation
        note: 18.0,
      ),
      Notes(
        idEtudiant: boba,
        idModule: devweb, // ID du module Dart
        note: 19.5,
      ),
      Notes(
        idEtudiant: boba,
        idModule: bdd, // ID du module Soft Skills
        note: 17.5,
      ),
    ];

// Insérer les notes dans la base de données
    insertNotes(notesList);


  }

  // get the student of specific sector
  static Future<List<Map<String, dynamic>>> getStuSec(String sec) async {
    final Database db = await database;
    return await db.rawQuery(
        'SELECT * FROM utilisateurs WHERE role = 0 AND id IN (SELECT idEtudiant FROM classrooms WHERE idFiliere IN (SELECT id FROM filieres WHERE nom = ?))',
        [sec]);
  }


  static Future<int> insertUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;

    return await db.insert(
      'utilisateurs',
      utilisateur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  static Future<int> insertModule(Modules module) async {
    final Database db = await database;

    return await db.insert(
      'modules',
      module.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertDevoir(Devoir devoir) async {
    final Database db = await database;

   return await db.insert(
      'devoirs',
      devoir.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertFiliere(Filiere filiere) async {
    final Database db = await database;

    return await db.insert(
      'filieres',
      filiere.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertClassroom(Classroom classroom) async {
    final Database db = await database;

    return await db.insert(
      'classrooms',
      classroom.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertNotes(Notes notes) async {
    final Database db = await database;

    return await db.insert(
      'notes',
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertCours(Cours cours) async {
    final Database db = await database;

    return await db.insert(
      'cours',
      cours.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> insertProjet(Projet projet) async {
    final Database db = await database;

    return await db.insert(
      'projets',
      projet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> displayDatabase() async {
    final Database db = await database;

    // Sélectionner et afficher les utilisateurs
    List<Map<String, dynamic>> utilisateurs = await db.query('utilisateurs');
    print('Table "utilisateurs":');
    utilisateurs.forEach((row) => print(row));

    // Sélectionner et afficher les modules
    List<Map<String, dynamic>> modules = await db.query('modules');
    print('Table "modules":');
    modules.forEach((row) => print(row));

    // Sélectionner et afficher les filières
    List<Map<String, dynamic>> filieres = await db.query('filieres');
    print('Table "filieres":');
    filieres.forEach((row) => print(row));

    // Sélectionner et afficher les classrooms
    List<Map<String, dynamic>> classrooms = await db.query('classrooms');
    print('Table "classrooms":');
    classrooms.forEach((row) => print(row));

    // Ajoutez d'autres tables si nécessaire

    print('Fin de la base de données.');
  }

  static Future<List<Utilisateur>> getUsers() async {
    final Database db = await database;

    final List<Map<String, dynamic>> usersMap = await db.query('utilisateurs');

    // Convertir la liste de maps en une liste d'objets Utilisateur
    return List.generate(usersMap.length, (index) {
      return Utilisateur(
        id: usersMap[index]['id'],
        nom: usersMap[index]['nom'],
        email: usersMap[index]['email'],
        password: usersMap[index]['password'],
        role: usersMap[index]['role'],
      );
    });
  }


  static Future<List<Modules>> getModulesForFiliere(int idFiliere) async {

    final Database db = await database;
    final List<Map<String, dynamic>> moduleMaps = await db.query(
      'modules',
      where: 'idFiliere = ?',
      whereArgs: [idFiliere],
    );

    // Convertir les résultats en une liste d'objets Module
    return List.generate(moduleMaps.length, (i) {
      return Modules.fromMap(moduleMaps[i]);
    });
  }


 static  Future<Classroom?> getStudentById(int id) async {

    final Database db = await database;
    final List<Map<String, dynamic>> classroomMaps = await db.query(
      'classrooms',
      where: 'idEtudiant = ?',
      whereArgs: [id],
    );

    if (classroomMaps.isEmpty) {
      return null; // Aucun étudiant trouvé avec cet ID
    }

    return Classroom.fromMap(classroomMaps.first);
  }

  static Future<Utilisateur?> getUserById(int id) async {


    final Database db = await database;
    final List<Map<String, dynamic>> userMaps = await db.query(
      'utilisateurs',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (userMaps.isEmpty) {
      return null; // Aucun utilisateur trouvé avec cet ID
    }

    return Utilisateur.fromMap(userMaps.first);
  }
  static Future<List<Devoir>> getDevoirsForModule(int idModule) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'devoirs',
      where: 'idModule  = ?',
      whereArgs: [idModule],
    );


    return List.generate(maps.length, (i) {
      return Devoir.fromMap(maps[i]);
    });
  }


  static Future<List<Projet>> getProjectsForUser(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'projets',
      where: 'idEtudiant = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Projet.fromMap(maps[i]);
    });
  }

  static Future<List<Notes>> getNotesForStudentFromDatabase(int idEtudiant) async {
    // Ouvrir la base de données
    final Database db = await database;

    // Récupérer les notes de la table pour l'étudiant spécifié
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'idEtudiant = ?',
      whereArgs: [idEtudiant],
    );

    // Retourner la liste des notes
    return List.generate(maps.length, (i) {
      return Notes.fromMap(maps[i]);
    });
  }



}



