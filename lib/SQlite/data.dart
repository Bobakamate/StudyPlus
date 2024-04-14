class Utilisateur {
    int? id;
      String nom;
    String email;
    String password;
    int role;
    String image;

  Utilisateur({
    this.id, // Rendre l'ID optionnel
    required this.nom,
    required this.image,
    required this.email,
    required this.password,
    required this.role,
  });

  factory Utilisateur.fromMap(Map<String, dynamic> map) {
    return Utilisateur(
      id: map['id'],
      image: map['image'],
      nom: map['nom'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      "image" : image,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}

class Modules {
  final int? id;
  final String nom;
  final int profId;
  final String description;
  final String image;
  final int idFiliere;

  Modules({
    this.id, // Rendre l'ID optionnel
    required this.nom,
    required this.profId,
    required this.description,
    required this.image,
    required this.idFiliere,
  });

  factory Modules.fromMap(Map<String, dynamic> map) {
    return Modules(
      id: map['id'],
      nom: map['nom'],
      profId: map['profId'],
      description: map['description'],
      image: map['image'],
      idFiliere: map['idFiliere'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'profId': profId,
      'description': description,
      'image': image,
      'idFiliere': idFiliere,
    };
  }
}

class Devoir {
  final int? id;
  final String nom;
    int rendue ;
    int isProjet ;

  final DateTime dateLimite;
  final String description;

  final int idModule;

  Devoir({
    this.id, // Rendre l'ID optionnel
    required this.rendue,
    required this.nom,
    required this.isProjet,
    required this.dateLimite,
    required this.description,

    required this.idModule,
  });

  factory Devoir.fromMap(Map<String, dynamic> map) {
    return Devoir(
      id: map['id'],
      nom: map['nom'],
        isProjet : map['isProjet'],
      dateLimite: DateTime.parse(map['dateLimite']),
      description: map['description'],
      idModule: map['idModule'],
      rendue: map["rendue"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      "rendue" :rendue,
      "isProjet" : isProjet,
      'dateLimite': dateLimite.toIso8601String(),
      'description': description,

      'idModule': idModule,
    };
  }
}

class Filiere {
  final int? id;
  final String nom;
  final String semestre;

  Filiere({
    this.id, // Rendre l'ID optionnel
    required this.nom,
    required this.semestre,
  });

  factory Filiere.fromMap(Map<String, dynamic> map) {
    return Filiere(
      id: map['id'],
      nom: map['nom'],
      semestre: map['semestre'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'semestre': semestre,
    };
  }
}

class Classroom {
  final int? id;
  final int idEtudiant;
  final int idFiliere;

  Classroom({
    this.id, // Rendre l'ID optionnel
    required this.idEtudiant,
    required this.idFiliere,
  });

  factory Classroom.fromMap(Map<String, dynamic> map) {
    return Classroom(
      id: map['id'],
      idEtudiant: map['idEtudiant'],
      idFiliere: map['idFiliere'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'idEtudiant': idEtudiant,
      'idFiliere': idFiliere,
    };
  }
}

class Notes {
  final int? id;
  final int idEtudiant;
  final int idModule;
  final double note;

  Notes({
    this.id, // Rendre l'ID optionnel
    required this.idEtudiant,
    required this.idModule,
    required this.note,
  });

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      idEtudiant: map['idEtudiant'],
      idModule: map['idModule'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'idEtudiant': idEtudiant,
      'idModule': idModule,
      'note': note,
    };
  }
}

class Cours {
  final int? id;
  final String nom;
  final String resume;
  final int idModule;

  Cours({
    this.id, // Rendre l'ID optionnel
    required this.nom,
    required this.resume,
    required this.idModule,
  });

  factory Cours.fromMap(Map<String, dynamic> map) {
    return Cours(
      id: map['id'],
      nom: map['nom'],
      resume: map['resume'],
      idModule: map['idModule'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'resume': resume,
      'idModule': idModule,
    };
  }
}

class Projet {
  final int? id;
  final String titre;
  final String description;
  final String image;
  final int idModule ;
  final int idEtudiant;

  Projet({
    this.id, // Rendre l'ID optionnel
    required this.idModule,
    required this.titre,
    required this.description,
    required this.image,
    required this.idEtudiant,
  });

  factory Projet.fromMap(Map<String, dynamic> map) {
    return Projet(
      id: map['id'],
      titre: map['titre'],
      idModule : map['idModule'],
      description: map['description'],
      image: map['image'],
      idEtudiant: map['idEtudiant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titre': titre,
      'description': description,
      "idModule":idModule,
      'image': image,
      'idEtudiant': idEtudiant,
    };
  }


}

class Rendue {
  final int? id;
  final int idDevoir;
  final int idEtudiant;
  final bool rendue;

  Rendue({
     this.id,
    required this.idDevoir,
    required this.idEtudiant,
    required this.rendue,
  });

  factory Rendue.fromMap(Map<String, dynamic> map) {
    return Rendue(
      id: map['id'],
      idDevoir: map['idDevoir'],
      idEtudiant: map['idEtudiant'],
      rendue: map['rendue'] == 1, // Convertir le rendue en booléen
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idDevoir': idDevoir,
      'idEtudiant': idEtudiant,
      'rendue': rendue ? 1 : 0, // Convertir le booléen en entier (0 ou 1)
    };
  }
}

