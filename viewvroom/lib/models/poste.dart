class Poste {
  int? id;

  String poste;

  Poste({ required this.id, required this.poste});

     Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poste': poste,
      
    };
  }

  factory Poste.fromMap(Map<String, dynamic> map) {
    return Poste(
        id: map['id'] ,
      poste:map['poste'] ,
    );
  }

  // void clear() {}


}
