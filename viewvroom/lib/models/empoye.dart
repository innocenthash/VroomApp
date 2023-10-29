import 'dart:typed_data';
class Employe {
  int? id;
  String nom;
  String prenom;
  int posteId;
  String numero;
  String mail;
  String adresse;
  String dateDembauche;
  Uint8List? imageUrl;

  Employe(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.posteId,
      required this.numero,
      required this.mail,
      required this.adresse,
      required this.dateDembauche,
      required this.imageUrl
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'Poste_id': posteId,
      'numero': numero,
      'mail': mail,
      'adresse': adresse,
      'date_dembauche': dateDembauche ,
      'image':imageUrl
    };
  }

  factory Employe.fromMap(Map<String, dynamic> map) {
    return Employe(
        id: map['id'],
        nom: map['nom'],
        prenom: map['prenom'],
        posteId: map['Poste_id'],
        numero: map['numero'],
        mail: map['mail'],
        adresse: map['adresse'],
        dateDembauche: map['date_dembauche'],
        imageUrl: map['image']
        );
  }
}
