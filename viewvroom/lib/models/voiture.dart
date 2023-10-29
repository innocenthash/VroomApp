import 'dart:typed_data';

class Voiture {
  int? id;
  int? stock;
  String nom;
  String marque;
  String anneedefabrication;
  String description;
 Uint8List? imageUrl;
  Voiture(
      {required this.id,
      required this.stock ,
      required this.nom,
      required this.marque,
      required this.anneedefabrication,
      required this.description,
       this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'stock': stock,
      'marque': marque,
      'annee_de_fabrication': anneedefabrication,
      'description': description,
      'image': imageUrl
    };
  }

  factory Voiture.fromMap(Map<String, dynamic> map) {
    return Voiture(
      id: map['id'],
      nom: map['nom'],
      stock: map['stock'],
      marque: map['marque'],
      anneedefabrication: map['annee_de_fabrication'],
      description: map['description'],
       imageUrl: map['image']
    );
  }
}
