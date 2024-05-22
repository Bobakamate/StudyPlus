
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'data.dart';


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
          "CREATE TABLE utilisateurs(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, email TEXT,image TEXT, password TEXT, role INTEGER)",
        );
        await db.execute(
          "CREATE TABLE modules(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, profId INTEGER, description TEXT, image TEXT, idFiliere INTEGER)",
        );
        await db.execute(
          "CREATE TABLE devoirs(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, dateLimite TEXT, description TEXT, image TEXT, idModule INTEGER, rendue INTEGER, isProjet INTEGER)",
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
        await db.execute(
          "CREATE TABLE rendue(id INTEGER PRIMARY KEY AUTOINCREMENT, idDevoir INTEGER, idEtudiant INTEGER, rendue INTEGER)",
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
   /* final int boba = await insertUtilisateur(
      Utilisateur(
        nom: 'Boba Kamate',
        email: 'boba@gmail.com',
        image: "assets/images/profil.jpg",
        password: 'boba',
        role: 2,
      ),
    );*/
    final int sara = await insertUtilisateur(
      Utilisateur(
        nom: 'Sara Amhil',
        email: 'sara@gmail.com',
        image: "assets/images/profil_5.jpg",
        password: 'sara',
        role: 2,
      ),
    );

    final int admin = await insertUtilisateur(
      Utilisateur(
        nom: 'Administration',
        email: 'admin@gmail.com',
        image: "assets/images/profil_6.jpg",
        password: 'admin',
        role: 0,

      ),
    );

     final int daveProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Dave Wiliams',
        email: 'dave@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'dave',
        role: 1,
      ),
    );

     final int karimProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Karim El Bahri',
        email: 'karim@gmail.com',
        image: "assets/images/profil_4.jpg",//image pour un prof homme
        password: 'karim',
        role: 1,
      ),
    );

     final int fatimaProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Fatima Essaadi',
        email: 'fatima@gmail.com',
        image: "assets/images/profil_5.jpg",//image pour un prof femme
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
           idEtudiant: sara,
           idFiliere: IDAIid
       )
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
      isProjet: 0,
      description: "Dans ce devoir, les étudiants devront analyser un cas pratique en résolution de problèmes lié aux soft skills. Ils devront identifier les problèmes, proposer des solutions efficaces en utilisant des techniques de communication et de travail d'équipe, et justifier leurs choix. Le devoir devra inclure une analyse détaillée ainsi que des recommandations concrètes pour résoudre le problème.",
      idModule: softskil, // ID du module de la filière IDAI
    ));

    await insertDevoir(Devoir(
      nom: "Développement d'une application mobile avec Flutter",
      rendue: 0, // Non rendue
      isProjet: 0,
      dateLimite: DateTime(2024, 5, 22, 23, 45), // Remplacez par la date limite appropriée
      description: "Dans ce devoir, les étudiants devront concevoir et développer une application mobile fonctionnelle en utilisant le langage de programmation Dart et le framework Flutter. L'application devra répondre à des besoins spécifiques fournis dans l'énoncé du devoir. Les étudiants devront également fournir une documentation détaillée de leur travail, y compris les choix de conception, les fonctionnalités implémentées et les tests effectués.",
      idModule: dart, // ID du module de la filière IDAI
    ));
   int devoirdart =  await insertDevoir(Devoir(
      nom: "Développement d'une application mobile de gestion de tâches",
      rendue: 1, // Non rendue
      isProjet: 1,
      dateLimite: DateTime(2024, 5, 22, 23, 45),
      description: "Ce devoir consiste à développer une application mobile de gestion de tâches pour aider les utilisateurs à organiser leurs activités quotidiennes. L'application doit permettre de créer, modifier et supprimer des tâches, ainsi que de définir des rappels pour les échéances importantes. Les étudiants doivent concevoir et implémenter cette application en utilisant le langage de programmation Dart et le framework Flutter.",
      idModule: dart, // ID du module de la filière IDAI
    ));
   await insertRendue(
     Rendue(
       idDevoir: devoirdart,
       idEtudiant: sara,
         rendue: true
     )
   );


    await insertDevoir(Devoir(
      nom: "Conception et implémentation d'une base de données relationnelle",
      rendue: 0, // Non rendue
      isProjet: 0,
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



    List<Notes> notesList = [
      Notes(
        idEtudiant: sara,
        idModule: softskil, // ID du module SR Informatique
        note: 18.5,
      ),
      Notes(
        idEtudiant: sara,
        idModule: srinformatique, // ID du module BDD
        note: 17.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: dart, // ID du module Dev Web
        note: 19.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: modelisation, // ID du module Modélisation
        note: 18.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: devweb, // ID du module Dart
        note: 19.5,
      ),
      Notes(
        idEtudiant: sara,
        idModule: bdd, // ID du module Soft Skills
        note: 17.5,
      ),
    ];

// Insérer les notes dans la base de données
    insertNotes(notesList);


    // Module SR Informatique


    await insertCours(Cours(
      nom: "Algorithmes",
      resume: "Ce cours couvre les concepts fondamentaux des algorithmes, y compris les structures de données et les techniques de conception.",
      idModule: srinformatique,
    ));

    await insertCours(Cours(
      nom: "Complexité",
      resume: "Ce cours examine la complexité des algorithmes et les méthodes pour analyser et mesurer leur efficacité.",
      idModule: srinformatique,
    ));

    await insertCours(Cours(
      nom: "Programmation Dynamique",
      resume: "Ce cours explore la programmation dynamique comme une technique d'optimisation pour résoudre des problèmes récursifs.",
      idModule: srinformatique,
    ));



    await insertCours(Cours(
      nom: "SQL Avancé",
      resume:
      "Ce cours explore les fonctionnalités avancées du langage SQL pour manipuler et interroger les bases de données relationnelles.",
      idModule: bdd,
    ));

    await insertCours(Cours(
      nom: "NoSQL",
      resume:
      "Ce cours introduit les bases de données NoSQL et explore leur utilisation dans différents scénarios d'application.",
      idModule: bdd,
    ));

    await insertCours(Cours(
      nom: "Modélisation de Données",
      resume:
      "Ce cours couvre les techniques de modélisation de données pour concevoir des schémas de base de données efficaces.",
      idModule: bdd,
    ));



    await insertCours(Cours(
      nom: "HTML & CSS",
      resume:
      "Ce cours couvre les bases de HTML et CSS pour créer des pages web statiques et stylisées.",
      idModule: devweb,
    ));

    await insertCours(Cours(
      nom: "JavaScript",
      resume:
      "Ce cours explore les concepts avancés de JavaScript pour rendre les pages web interactives et dynamiques.",
      idModule: devweb,
    ));

    await insertCours(Cours(
      nom: "Frameworks Front-end",
      resume:
      "Ce cours présente les frameworks front-end modernes comme React, Angular et Vue.js pour le développement web.",
      idModule: devweb,
    ));



    await insertCours(Cours(
      nom: "UML",
      resume:
      "Ce cours présente le langage de modélisation unifié (UML) et ses différents diagrammes pour représenter des systèmes logiciels.",
      idModule: modelisation,
    ));

    await insertCours(Cours(
      nom: "Modélisation des Bases de Données",
      resume:
      "Ce cours explore les techniques de modélisation pour concevoir des bases de données efficaces.",
      idModule: modelisation,
    ));



    await insertCours(Cours(
      nom: "Syntaxe de Dart",
      resume: "Ce cours présente la syntaxe de base du langage Dart.",
      idModule: dart,
    ));

    await insertCours(Cours(
      nom: "Programmation Orientée Objet en Dart",
      resume:
      "Ce cours explore les concepts de programmation orientée objet en Dart.",
      idModule: dart,
    ));



    await insertCours(Cours(
      nom: "Communication Interpersonnelle",
      resume:
      "Ce cours se concentre sur les compétences de communication verbale et non verbale.",
      idModule: softskil,
    ));

    await insertCours(Cours(
      nom: "Gestion du Temps",
      resume:
      "Ce cours explore les techniques pour gérer efficacement son temps et ses priorités.",
      idModule: softskil,
    ));

    await insertCours(Cours(
      nom: "Résolution de Conflits",
      resume:
      "Ce cours examine les stratégies pour résoudre les conflits de manière constructive.",
      idModule: softskil,
    ));



  }

  //insertion daata base






  static Future<void> initDataForFirstTime() async {

    final int admin = await insertUtilisateur(
      Utilisateur(
        nom: 'Administration',
        email: 'admin@gmail.com',
        image: "assets/images/profil_6.jpg",
        password: 'admin',
        role: 0,
      ),
    );

    // Insert users (students and professors)
    final int sara = await insertUtilisateur(
      Utilisateur(
        nom: 'Sara Amhil',
        email: 'sara@gmail.com',
        image: "assets/images/profil_5.jpg",
        password: 'sara',
        role: 2, // Role for student
      ),
    );

    final int rajaaProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Rajaa',
        email: 'rajaa@gmail.com',
        image: "assets/images/profil_5.jpg",
        password: 'rajaa',
        role: 1, // Role for professor
      ),
    );

    final int elaaroubiProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Elaaroubi',
        email: 'elaaroubi@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'elaaroubi',
        role: 1,
      ),
    );

    final int chrayahProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Chrayah',
        email: 'chrayah@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'chrayah',
        role: 1,
      ),
    );

    final int mabroukProfId = await insertUtilisateur(
      Utilisateur(
        nom: 'Mabrouk',
        email: 'mabrouk@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'mabrouk',
        role: 1,
      ),
    );

    final int tabaaProfId1 = await insertUtilisateur(
      Utilisateur(
        nom: 'TABAA',
        email: 'tabaa1@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'tabaa',
        role: 1,
      ),
    );

    final int tabaaProfId2 = await insertUtilisateur(
      Utilisateur(
        nom: 'TABAA',
        email: 'tabaa2@gmail.com',
        image: "assets/images/profil_4.jpg",
        password: 'tabaa',
        role: 1,
      ),
    );

    // Insert fields of study
    final int masterMSIid = await insertFiliere(Filiere(
      nom: "Master MSI",
      semestre: "S8",
    ));

    // Insert modules with the corresponding professor
    final int managementProjets = await insertModule(Modules(
      nom: "Project Management",
      description: "This module covers the principles of project management, including planning, execution, and project tracking.",
      image: "assets/images/c1.jpg",
      idFiliere: masterMSIid,
      profId: rajaaProfId,
    ));

    final int gestionBudgetaire = await insertModule(Modules(
      nom: "Budget Management",
      description: "This module explores budgeting techniques, including planning, control, and budget analysis.",
      image: "assets/images/c2.jpg",
      idFiliere: masterMSIid,
      profId: elaaroubiProfId,
    ));

    final int dataMining = await insertModule(Modules(
      nom: "Data Mining",
      description: "This module introduces data mining techniques and their application to extract useful information from large databases.",
      image: "assets/images/c3.jpg",
      idFiliere: masterMSIid,
      profId: chrayahProfId,
    ));

    final int devmobile = await insertModule(Modules(
      nom: "Web and Mobile Application Development",
      description: "This module covers the technologies and tools used for developing web and mobile applications.",
      image: "assets/images/c4.jpg",
      idFiliere: masterMSIid,
      profId: mabroukProfId,
    ));

    final int progiciels = await insertModule(Modules(
      nom: "Advanced Integrated Management Software",
      description: "This module explores integrated management software and their use in managing business processes.",
      image: "assets/images/c5.jpg",
      idFiliere: masterMSIid,
      profId: tabaaProfId1,
    ));

    final int gouvernancesi = await insertModule(Modules(
      nom: "IT Governance",
      description: "This module covers the principles of IT governance and their importance for strategic IT management.",
      image: "assets/images/c6.jpg",
      idFiliere: masterMSIid,
      profId: tabaaProfId2,
    ));

    // Insert courses for each module
    await insertCours(Cours(
      nom: "Introduction to Project Management",
      resume: "The basics of project management.",
      idModule: managementProjets,
    ));

    await insertCours(Cours(
      nom: "Project Planning",
      resume: "Techniques and tools for project planning.",
      idModule: managementProjets,
    ));

    await insertCours(Cours(
      nom: "Budget Analysis",
      resume: "Techniques for budget analysis.",
      idModule: gestionBudgetaire,
    ));

    await insertCours(Cours(
      nom: "Budget Control",
      resume: "Control and management of budgets.",
      idModule: gestionBudgetaire,
    ));

    await insertCours(Cours(
      nom: "Data Mining Techniques",
      resume: "Commonly used data mining techniques.",
      idModule: dataMining,
    ));

    await insertCours(Cours(
      nom: "Applications of Data Mining",
      resume: "Practical applications of data mining.",
      idModule: dataMining,
    ));

    await insertCours(Cours(
      nom: "Web Development",
      resume: "Introduction to web application development.",
      idModule: devmobile,
    ));

    await insertCours(Cours(
      nom: "Mobile Development",
      resume: "Introduction to mobile application development.",
      idModule: devmobile,
    ));

    await insertCours(Cours(
      nom: "ERP Software",
      resume: "Introduction to integrated management software.",
      idModule: progiciels,
    ));

    await insertCours(Cours(
      nom: "Business Process Management",
      resume: "Using ERP to manage business processes.",
      idModule: progiciels,
    ));

    await insertCours(Cours(
      nom: "Principles of IT Governance",
      resume: "The principles of IT governance.",
      idModule: gouvernancesi,
    ));

    await insertCours(Cours(
      nom: "IT Governance Strategies",
      resume: "Strategies and best practices in IT governance.",
      idModule: gouvernancesi,
    ));

    // Insert assignments for each module
    await insertDevoir(Devoir(
      nom: "Final Project Management Assignment",
      description: "Create a complete project plan.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: managementProjets,
      rendue: 1,
      isProjet: 1,
    ));

    await insertDevoir(Devoir(
      nom: "Company Budget Analysis",
      description: "Perform a comprehensive budget analysis.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: gestionBudgetaire,
      rendue: 1,
      isProjet: 1,
    ));

    await insertDevoir(Devoir(
      nom: "Data Mining Case Study",
      description: "Analyze a dataset using data mining techniques.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: dataMining,
      rendue: 1,
      isProjet: 1,
    ));

    await insertDevoir(Devoir(
      nom: "Web Application Development",
      description: "Develop a simple web application.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: devmobile,
      rendue: 1,
      isProjet: 0,
    ));

    await insertDevoir(Devoir(
      nom: "ERP Implementation",
      description: "Implement an ERP in a case study.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: progiciels,
      rendue: 0,
      isProjet: 0,
    ));

    await insertDevoir(Devoir(
      nom: "IT Governance Audit",
      description: "Conduct an IT governance audit.",
      dateLimite: DateTime(2024, 5, 30),
      idModule: gouvernancesi,
      rendue: 0,
      isProjet: 0,
    ));

    // Insert notes
    List<Notes> notesList = [
      Notes(
        idEtudiant: sara,
        idModule: gouvernancesi,
        note: 18.5,
      ),
      Notes(
        idEtudiant: sara,
        idModule: progiciels,
        note: 17.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: devmobile,
        note: 19.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: managementProjets,
        note: 18.0,
      ),
      Notes(
        idEtudiant: sara,
        idModule: dataMining,
        note: 19.5,
      ),
      Notes(
        idEtudiant: sara,
        idModule: gestionBudgetaire,
        note: 17.5,
      ),
    ];
    Future<void> insertNotes(List<Notes> notes) async {
      final Database db = await database;
      for (var note in notes) {
        await db.insert(
          'notes',
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    // Insert projects for each module
    await insertDevoir(Devoir(
      nom: "Library Management System",
      description: "Develop a complete library management system using web technologies.",
      dateLimite: DateTime(2024, 6, 30),
      idModule: devmobile,
      rendue: 1,
      isProjet: 0, // Module ID for Web and Mobile Application Development
    ));

    await insertDevoir(Devoir(
      nom: "Sales Data Analysis",
      description: "Use data mining techniques to analyze sales data and extract useful information.",
      dateLimite: DateTime(2024, 6, 30),
      idModule: dataMining,
      rendue: 1,
      isProjet: 0, // Module ID for Data Mining
    ));

    await insertDevoir(Devoir(
      nom: "ERP Implementation for an SME",
      description: "Set up an ERP to manage the processes of a small and medium-sized enterprise.",
      dateLimite: DateTime(2024, 6, 30),
      idModule: progiciels,
      rendue: 1,
      isProjet: 0, // Module ID for Advanced Integrated Management Software
    ));

    // Function to insert a project
    Future<void> insertProjet(Projet projet) async {
      final Database db = await database;
      await db.insert(
        'projets',
        projet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await insertClassroom(
        Classroom(
            idEtudiant: sara,
            idFiliere: masterMSIid
        )
    );
    List<int> studentIds = [];
    List<String> studentNames = [
      'Lucas Kelly',
      'Natalie Morgan',
      'Noah Baker',
      'Stella Young',
      'Alexander Rivera',
      'Luna King'
    ];
    List<String> studentEmails = [
      'lucas.kelly@gmail.com',
      'natalie.morgan@gmail.com',
      'noah.baker@gmail.com',
      'stella.young@gmail.com',
      'alexander.rivera@gmail.com',
      'luna.king@gmail.com'
    ];
    List<String> studentImages = [
      "assets/images/profil_1.jpg",
      "assets/images/profil_2.jpg",
      "assets/images/profil_3.jpg",
      "assets/images/profil_4.jpg",
      "assets/images/profil_5.jpg",
      "assets/images/profil_6.jpg"
    ];

    for (int i = 0; i < studentNames.length; i++) {
      final int studentId = await insertUtilisateur(
        Utilisateur(
          nom: studentNames[i],
          email: studentEmails[i],
          image: studentImages[i],
          password: 'password', // Set a default password
          role: 2, // Role for student
        ),
      );
      studentIds.add(studentId);

      await insertClassroom(
        Classroom(
          idEtudiant: studentId,
          idFiliere: masterMSIid,
        ),
      );
    }
    await insertNotes(notesList);
  }






























  //insertion daata

  static Future<int> insertUtilisateur(Utilisateur utilisateur) async {
    final Database db = await database;

    return await db.insert(
      'utilisateurs',
      utilisateur.toMap(),
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
  static Future<List<Filiere>> getAllFilieres() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('filieres');

    return List.generate(maps.length, (i) {
      return Filiere.fromMap(maps[i]);
    });
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

    List<Map<String, dynamic>> rendue = await db.query('rendue');
    print('Table "Rendue":');
    rendue.forEach((row) => print(row));

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
    List<Map<String, dynamic>> cours = await db.query('cours');
    print('Table "cours":');
    cours.forEach((row) => print(row));

    List<Map<String, dynamic>> notes = await db.query('notes');
    print('Table "notes":');
    notes.forEach((row) => print(row));

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
        image: usersMap[index]['image'],
        email: usersMap[index]['email'],
        password: usersMap[index]['password'],
        role: usersMap[index]['role'],
      );
    });
  }

  static Future<List<Utilisateur>> getStudentsForclassroom(int idFiliere) async {
    final Database db = await database;
    final List<Map<String, dynamic>> studentsMap = await db.query(
      'utilisateurs',
      where: 'id IN (SELECT idEtudiant FROM classrooms WHERE idFiliere = ?)',
      whereArgs: [idFiliere],
    );

    // Convertir la liste de maps en une liste d'objets Utilisateur
    return List.generate(studentsMap.length, (index) {
      return Utilisateur(
        id: studentsMap[index]['id'],
        nom: studentsMap[index]['nom'],
        email: studentsMap[index]['email'],
        password: studentsMap[index]['password'],
        role: studentsMap[index]['role'],
        image: 'assets/images/profil_5.jpg',
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

  static Future<Classroom?> getStudentById(int id) async {
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
  static Future<List<Utilisateur>> getUserByRole(int role) async {
    final Database db = await database;
    final List<Map<String, dynamic>> userMaps = await db.query(
      'utilisateurs',
      where: 'role = ?',
      whereArgs: [role],
    );

    if (userMaps.isEmpty) {
      return []; // Retourner une liste vide si aucun utilisateur n'est trouvé avec ce rôle
    }

    // Utiliser la méthode map pour convertir chaque élément de userMaps en un objet Utilisateur
    return userMaps.map((userMap) => Utilisateur.fromMap(userMap)).toList();
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

  static Future<List<Notes>> getNotesByModule(int idModule) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'idModule = ?',
      whereArgs: [idModule],
    );

    return List.generate(maps.length, (i) {
      return Notes.fromMap(maps[i]);
    });
  }

  static Future<List<Notes>> getNotesForStudentFromDatabase(
      int idEtudiant) async {
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
  static Future<void> updateUserById(int id, String nom, String email, String password) async {
    // Récupérer une référence à la base de données
    final Database db = await database;

    // Construire les données de mise à jour
    final Map<String, dynamic> updateUser = {
      'nom': nom,
      'email': email,
      'password': password,

    };

    // Mettre à jour l'utilisateur dans la base de données
    await db.update(
      'utilisateurs',
      updateUser,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  static Future<List<Cours>> getCoursFromDatabase() async {
    final Database db = await database;

    final List<Map<String, dynamic>> coursMaps = await db.query('cours');

    // Convertir les résultats en une liste d'objets Cours
    var courChapitres = List.generate(coursMaps.length, (i) {
      return Cours(
        id: coursMaps[i]['id'],
        nom: coursMaps[i]['nom'],
        resume: coursMaps[i]['resume'],
        idModule: coursMaps[i]['idModule'],
      );
    });
    return courChapitres;
  }

  static Future<void> updateDevoirRendue(int devoirId, int newRendueStatus) async {
    final Database db = await database; // Assurez-vous que la fonction `database` est définie dans la même classe


    await db.update(
      'devoirs', // Nom de la table
      {'rendue': newRendueStatus}, // Valeur mise à jour
      where: 'id = ?', // Clause WHERE
      whereArgs: [devoirId], // Arguments de la clause WHERE
    );
  }

  static Future<int?> getFiliere(String nomFiliere) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'filieres',
      where: 'nom = ?',
      whereArgs: [nomFiliere],
    );

    if (result.isEmpty) {
      return null; // La filière n'existe pas dans la base de données
    } else {
      return result.first['id'] as int; // Retourner l'ID de la filière
    }
  }



  static Future<int> insertRendue(Rendue rendue) async {
    final db = await database;
    return await db.insert(
      'rendue',
      rendue.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  static  Future<Rendue?> getRendueByIdDevoirAndIdEtudiant(int idDevoir, int idEtudiant) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'rendue',
      where: 'idDevoir = ? AND idEtudiant = ?',
      whereArgs: [idDevoir, idEtudiant],
    );
    if (maps.isEmpty) {
      return null;
    }
    return Rendue.fromMap(maps.first);
  }
  //get all cours for a module
  static Future<List<Cours>> getCoursForModule(int idModule) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cours',
      where: 'idModule = ?',
      whereArgs: [idModule],
    );
    return List.generate(maps.length, (i) {
      return Cours.fromMap(maps[i]);
    });
  }

  //get module by prof id
  static Future<List<Modules>> getModulesForProf(int profId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'modules',
      where: 'profId = ?',
      whereArgs: [profId],
    );

    return List.generate(maps.length, (i) {
      return Modules.fromMap(maps[i]);
    });
  }

  static Future<List<Projet>> getProjectsForModule(int idModule) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'projets',
      where: 'idModule = ?',
      whereArgs: [idModule],
    );

    return List.generate(maps.length, (i) {
      return Projet.fromMap(maps[i]);
    });
  }

  static Future<void> updateCours(Cours cours) async {
    final Database db = await database;

    await db.update(
      'cours',
      cours.toMap(),
      where: 'id = ?',
      whereArgs: [cours.id],
    );
  }

  static Future<void> deleteCours(Cours chapter) async {
    final db = await database;

    await db.delete(
      'cours',
      where: 'id = ?',
      whereArgs: [chapter.id],
    );
  }

  static Future<void> updateProjet(Projet projet) async {
    final Database db = await database;

    await db.update(
      'projets',
      projet.toMap(),
      where: 'id = ?',
      whereArgs: [projet.id],
    );
  }

  static Future<void> deleteProjet(Projet projet) async {
    final db = await database;

    await db.delete(
      'projets',
      where: 'id = ?',
      whereArgs: [projet.id],
    );
  }

  static Future<void> updateDevoir(Devoir devoir) async {
    final Database db = await database;

    await db.update(
      'devoirs',
      devoir.toMap(),
      where: 'id = ?',
      whereArgs: [devoir.id],
    );
  }

  static Future<void> deleteDevoir(Devoir devoir) async {
    final db = await database;

    await db.delete(
      'devoirs',
      where: 'id = ?',
      whereArgs: [devoir.id],
    );
  }



  static Future<void> updateNoteInDatabase(Notes notes, newNote) async {
    final Database db = await database;

    await db.update(
      'notes',
      {'note': newNote},
      where: 'id = ?',
      whereArgs: [notes.id],
    );
  }

}