import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:viewvroom/models/empoye.dart';
import 'package:viewvroom/models/personne.dart';
import 'package:viewvroom/models/poste.dart';
import 'package:viewvroom/models/voiture.dart';

class SqliteDatabase {
  static Database? _database;

  Future get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    final path = join(await getDatabasesPath(), 'viewvroom.db');
    return await openDatabase(
      path,
      version: 20,
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

// debut table voiture
  Future _createTables(Database db, int version) async {
    try {
      // on cree la table voiture
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS Voiture (id INTEGER PRIMARY KEY,stock INTEGER,nom TEXT,marque TEXT,annee_de_fabrication TEXT,description TEXT, image BLOB)''');
      //  on cree la table Personne
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS Personne (id INTEGER PRIMARY KEY,nom TEXT ,prenom TEXT ,telephone TEXT ,adresse TEXT,argent_avance TEXT,commande TEXT, date_recuperation TEXT,Voiture_id INTEGER ,FOREIGN KEY (Voiture_id) REFERENCES Voiture(id))''');
      // on cree la table poste
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS Poste (id INTEGER PRIMARY KEY , poste TEXT)''');
      // creation de la table employe
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS Employe (id INTEGER PRIMARY KEY,nom TEXT,prenom TEXT,numero TEXT,mail TEXT, adresse TEXT,date_dembauche TEXT,image BLOB,Poste_id INTEGER,FOREIGN KEY (Poste_id) REFERENCES Poste(id))''');
    } catch (e) {
      print(e);
    }
    // on cree la table Voiture
  }

  // creer une voiture
  Future<int> createVoiture(Voiture voiture) async {
    final db = await database; // Attendre que la Future soit résolue
    var result = await db.insert('Voiture', voiture.toMap());
    return result;
  }

// afficher tout les voitures
  Future<List<Voiture>> getVoitures() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("Voiture");

    return List.generate(maps.length, (index) {
      return Voiture.fromMap(maps[index]);
    });
    // var results = await db.query("")
  }

// afficher une voiture specifique
  Future<Voiture?> getVoiture(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Voiture',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Voiture.fromMap(maps.first);
    } else {
      return null;
    }
  }

// mettre a jour une voiture
  Future<int> updateVoiture(Voiture voiture) async {
    final db = await database;
    final result = await db.update('Voiture', voiture.toMap(),
        where: 'id = ?', whereArgs: [voiture.id]);

    return result;
  }
  // mise a jour specifique

  Future<int> updateVoitureColonne(
      String columnName, dynamic value, int voitureId) async {
    final db = await database;
    Map<String, dynamic> updateData = {columnName: value};
    final result = await db
        .update('Voiture', updateData, where: 'id = ?', whereArgs: [voitureId]);

    return result;
  }
// supprimer une voiture

  Future<int> deleteVoiture(int id) async {
    final db = await database;
    final result = await db.delete('Voiture', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  // Recherche voiture

  Future<List<Voiture>> rechercheVoiture(String query) async {
    final db = await database;

// on recupere le donnees sous forme de map et la transformant en objet voiture
    List<Map<String, dynamic>> maps = await db.query(
      'Voiture',
      where: "marque LIKE ?",
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (index) {
      return Voiture.fromMap(maps[index]);
    });
  }

  // fin table voiture

  // debut table Personnee
  // creation d'une personne
  Future<int> createPersonne(Personne personne) async {
    final db = await database;
    var result = await db.insert('Personne', personne.toMap());

    return result;
  }

  // affichage specifique de personnes selon la voiture ou il  a commandé

  Future<List<Personne>> getPersonne(int voitureId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Personne',
      where: 'Voiture_id = ?',
      whereArgs: [voitureId],
    );

    return List.generate(maps.length, (index) {
      return Personne.fromMap(maps[index]);
    });
  }

  Future<int> deletePersonne(int idVoiture) async {
    final db = await database;
    final result = await db
        .delete('Personne', where: 'Voiture_id = ?', whereArgs: [idVoiture]);

    return result;
  }

  // fin model personne

  // debut model poste
  Future<int> createPoste(Poste poste) async {
    final db = await database;
    var result = await db.insert('Poste', poste.toMap());

    return result;
  }

  // affichage de poste

  Future<List<Poste>> getPostes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("Poste");

    return List.generate(maps.length, (index) {
      return Poste.fromMap(maps[index]);
    });
    // var results = await db.query("")
  }

  // CREATION DE L'employé

  Future <int> createEmploye(Employe employe) async {
    final db = await database;

    var result = await db.insert('Employe', employe.toMap());

// soit 1 ou -1 si c'est en echec
    return result;
  }


  // affiche de l'employé selon son poste

  Future<List<Employe>> getEmploye(int posteId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Employe',
      where: 'Poste_id = ?',
      whereArgs: [posteId],
    );
  return List.generate(maps.length, (index) {
      return Employe.fromMap(maps[index]);
    });
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      // //  les mises à jour de schéma de base de données
      // await db.execute('ALTER TABLE Voiture ADD COLUMN IF NOT EXISTS image TEXT');
      // Vérifiez si la colonne "image" existe dans la table "Voiture"
      final result = await db.rawQuery("PRAGMA table_info('Voiture');");
      final columnExists = result.any((column) => column['name'] == 'image');
      final columnStock = result.any((column) => column['name'] == 'stock');

// Vérifiez si la colonne "image" existe dans la table "EMPLOYE"
      final imageEmploye = await db.rawQuery("PRAGMA table_info('Employe');");
      final imageExists = imageEmploye.any((column) => column['name'] == 'image');
      // Si la colonne n'existe pas, ajoutez-la
      if (!imageExists) {
        await db.execute('ALTER TABLE Employe ADD COLUMN image TEXT');
      }
      // Si la colonne n'existe pas, ajoutez-la
      if (!columnExists) {
        await db.execute('ALTER TABLE Voiture ADD COLUMN image TEXT');
      }
      if (!columnStock) {
        await db.execute('ALTER TABLE Voiture ADD COLUMN stock INTEGER');
      }

      // Vérifiez si la table "Personne" existe
      final results = await db.rawQuery("PRAGMA table_info('Personne');");
      final poste = await db.rawQuery("PRAGMA table_info('Poste');");
      final employe = await db.rawQuery("PRAGMA table_info('Employe');");
      final voiture = await db.rawQuery("PRAGMA table_info('Voiture');");

      final voitureExists = voiture.isNotEmpty;
      final tableExists = results.isNotEmpty;
      final posteExists = poste.isNotEmpty;
      final employeExists = employe.isNotEmpty;

if (!employeExists) {
        // La table "Employe" n'existe pas, créez-la avec la nouvelle structure
        await _createTables(db, newVersion);
      }

      if (!voitureExists) {
        // La table "Employe" n'existe pas, créez-la avec la nouvelle structure
        await _createTables(db, newVersion);
      }


      


      if (!posteExists) {
        // La table "Personne" n'existe pas, créez-la avec la nouvelle structure
        await _createTables(db, newVersion);
      }


      if (!tableExists) {
        // La table "Personne" n'existe pas, créez-la avec la nouvelle structure
        await _createTables(db, newVersion);
      } else {
        // La table "Personne" existe, effectuez les mises à jour nécessaires
        // if (newVersion == 2) {
        //   // Exemple de mise à jour pour la version 2
        //   await db.execute('ALTER TABLE Personne ADD COLUMN nouvelle_colonne TEXT');
        // }
        // Ajoutez d'autres mises à jour ici pour des versions ultérieures si nécessaire.

        // Mettez à jour la version de la base de données
      }
      await db.execute('PRAGMA user_version = $newVersion');
    }

    //   if (newVersion > oldVersion) {

    // }
  }
}
