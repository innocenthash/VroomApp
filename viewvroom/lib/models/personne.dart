class Personne {
  int? id;
  String nom;
  String prenom;
  String telephone;
  String adresse;
  String argentAvance;
  String commande;
  String dateRecuperation;
  int voitureId;

  Personne(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.telephone,
      required this.adresse,
      required this.argentAvance,
      required this.commande,
      required this.dateRecuperation,
      required this.voitureId});
// TextEditingController nomPersonne = TextEditingController() ;
//   TextEditingController prenomPersonne = TextEditingController() ;
//   TextEditingController telephonePersonne = TextEditingController() ;
//   TextEditingController adressePersonne = TextEditingController() ;
//   TextEditingController argentAvancePersonne = TextEditingController() ;
//   TextEditingController commandePersonne = TextEditingController() ;
//   TextEditingController dateRecuperationPersonne = TextEditingController() ;
//   TextEditingController voitureIdPersonne = TextEditingController() ;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'adresse': adresse,
      'argent_avance': argentAvance,
      'commande': commande,
      'date_recuperation': dateRecuperation,
      'Voiture_id': voitureId
    };
  }

  factory Personne.fromMap(Map<String, dynamic> map) {
    return Personne(
      id: map['id'] ,
      nom :map['nom'] ,
      prenom :map['prenom'], 
      telephone:map['telephone'] ,
      adresse:map['adresse'] ,
      argentAvance:map['argent_avance'] ,
      commande: map['commande'],
      dateRecuperation: map['date_recuperation'],
      voitureId:map['Voiture_id'
      ] 
    );
  }
}
