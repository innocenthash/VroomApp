import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:viewvroom/models/personne.dart';
import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/personnes/listes_personnes_commande.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';

class ReservationPersonne extends StatefulWidget {
  final String idVoiture;
  final int stock;
  final Function listesVoitures;
  const ReservationPersonne(
      {super.key,
      required this.idVoiture,
      required this.stock,
      required this.listesVoitures});

  @override
  State<ReservationPersonne> createState() => _ReservationPersonneState();
}

class _ReservationPersonneState extends State<ReservationPersonne> {
  final sqliteDatabase = SqliteDatabase();

  List<Personne> listePersonnes = [];
  final TextEditingController nomPersonne = TextEditingController();
  final TextEditingController prenomPersonne = TextEditingController();
  final TextEditingController telephonePersonne = TextEditingController();
  final TextEditingController adressePersonne = TextEditingController();
  final TextEditingController argentAvancePersonne = TextEditingController();
  final TextEditingController commandePersonne = TextEditingController();
  final TextEditingController dateRecuperationPersonne =
      TextEditingController();
  final TextEditingController voitureIdPersonne = TextEditingController();

  Color three = OptionsCouleurs.three;
  Color oneColor = OptionsCouleurs.oneColor;
  Color twoColor = OptionsCouleurs.twoColor;
  // Color fort = OptionsCouleurs.fort;
  Color fort = OptionsCouleurs.five;
  final Color bluef = OptionsCouleurs.blueF;
  List<Voiture> newListes = [];
  Future<void> _affichesPersonnes() async {
    int idVoiture = int.parse(widget.idVoiture);
    final affichesPersonne = await sqliteDatabase.getPersonne(idVoiture);

    setState(() {
      listePersonnes = affichesPersonne;
    });
  }

  void afficherAlerteEnregistrementReussi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enregistrement réussi'),
          content: Text('Client enregistré avec succès.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // setState(() {
                widget.listesVoitures();
                // });
                Navigator.of(context).pop(); // Fermer l'alerte
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    voitureIdPersonne.text = widget.idVoiture;
    _affichesPersonnes();
    //  widget.stock - 1;
    // newListes;
    // widget.listesVoitures;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: widget.stock == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.white,
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.white,
                        child: Icon(
                          Icons.verified_user_outlined,
                          color: fort,
                        ),
                      ),
                    ),
                  ),
          )
        ],
        elevation: 0,
        title: const Text('Reservation'),
        backgroundColor: three,
      ),
      // backgroundColor: oneColor,
      body: Container(
        // margin: const EdgeInsets.all(10),
        // decoration: const BoxDecoration(
        //     // borderRadius: BorderRadius.circular(30),
        //     color: Color.fromARGB(255, 255, 0, 0),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color.fromARGB(255, 220, 220, 220),
        //         blurRadius: 4,
        //         // spreadRadius: 2
        //       ),
        //     ]),

        decoration: BoxDecoration(
          color: three.withOpacity(0.3),
          image: const DecorationImage(
            image: ExactAssetImage(
                "assets/images_profil_employe/adolescent-amusant-dessin-anime-3d-removebg-preview.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: fort,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 3),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.white,
                            // blurStyle: BlurStyle.solid,
                            spreadRadius: 3),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: const Center(
                            child: Text(
                              'Commande',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //   Container(child:Text('Nouvelle commande par : ') ,) ,
                  //    Container(child:Text('Nouvelle commande par : ') ,) ,

                  Expanded(
                    child: Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        color:Colors.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        // image: const DecorationImage(
                        //   image: ExactAssetImage(
                        //       "assets/image_caroussel/goh-rhy-yan-f_SDCASisgs-unsplash-removebg-preview.png"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            // color: Colors.grey.withOpacity(0.2),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 0),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: nomPersonne,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.assignment_ind),
                                        label: Text('Son nom'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: prenomPersonne,
                                    decoration: InputDecoration(
                                        label: Text('son prenom'),
                                        prefixIcon: Icon(Icons.assignment_ind),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: telephonePersonne,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        label: Text('Son numéro telephone'),
                                        prefixIcon: Icon(Icons.contact_phone),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: adressePersonne,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.place),
                                        label: Text('Son adresse'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: argentAvancePersonne,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.money),
                                        label: Text('Argent déjà payé'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: TextField(
                                    controller: commandePersonne,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.car_repair),
                                        label:
                                            Text('Nombre de voiture commandé'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20, bottom: 10),
                                  child: TextField(
                                    controller: dateRecuperationPersonne,
                                    // keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.calendar_today),
                                        label: Text('Date de recuperation'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 220),
                                    child: TextField(
                                      controller: voitureIdPersonne,
                                      decoration: InputDecoration(
                                          label: Text('id_de voiture commandé'),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 2),
                                          )),
                                    ),
                                  ),
                                ),
                                // Container(child: Text(widget.idVoiture),),
                                widget.stock == 0
                                    ? Container(
                                        child: ElevatedButton(
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'stock epuisé !',
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            )),
                                      )
                                    : Container(
                                      width: double.infinity,
                                      height: 70,
                                        padding: EdgeInsets.only(bottom: 10),
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              String nomPerson =
                                                  nomPersonne.text;
                                              String prenomPerson =
                                                  prenomPersonne.text;
                                              String telephonePerson =
                                                  telephonePersonne.text;
                                              String adressePerson =
                                                  adressePersonne.text;
                                              String argentAvancePerson =
                                                  argentAvancePersonne.text;
                                              String commandePerson =
                                                  commandePersonne.text;
                                              String dateRecuperationPerson =
                                                  dateRecuperationPersonne.text;
                                              String voitureIdPerson =
                                                  voitureIdPersonne.text;

                                              int idVoiture =
                                                  int.parse(voitureIdPerson);

                                              if (nomPerson.isEmpty ||
                                                  prenomPerson.isEmpty ||
                                                  telephonePerson.isEmpty ||
                                                  adressePerson.isEmpty ||
                                                  argentAvancePerson.isEmpty ||
                                                  commandePerson.isEmpty ||
                                                  dateRecuperationPerson
                                                      .isEmpty ||
                                                  voitureIdPerson.isEmpty) {
                                                // Affichez un message d'erreur si un champ est vide
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Veuillez remplir tous les champs.'),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              } else {
                                                Personne personne = Personne(
                                                    id: null,
                                                    nom: nomPerson,
                                                    prenom: prenomPerson,
                                                    telephone: telephonePerson,
                                                    adresse: adressePerson,
                                                    argentAvance:
                                                        argentAvancePerson,
                                                    commande: commandePerson,
                                                    dateRecuperation:
                                                        dateRecuperationPerson,
                                                    voitureId: idVoiture);

                                                int personneId =
                                                    await sqliteDatabase
                                                        .createPersonne(
                                                            personne);
                                                await sqliteDatabase
                                                    .updateVoitureColonne(
                                                        'stock',
                                                        widget.stock - 1,
                                                        idVoiture);

                                                if (personneId != -1) {
                                                  afficherAlerteEnregistrementReussi();

                                                  nomPersonne.clear();
                                                  prenomPersonne.clear();
                                                  telephonePersonne.clear();
                                                  adressePersonne.clear();
                                                  argentAvancePersonne.clear();
                                                  commandePersonne.clear();
                                                  dateRecuperationPersonne
                                                      .clear();
                                                } else {
                                                  // Affichez un message d'erreur
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Erreur lors de l\'enregistrement du client.'),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              }
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Erreur lors de l\'enregistrement du client'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                              print(
                                                  'Erreur lors de l\'enregistrement du client : $e');
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // disabledBackgroundColor: ,
                                              foregroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 255, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                    side: const BorderSide(color:Colors.white , width:4 )
                                              ),
                                              backgroundColor:three.withOpacity(0.9)),
                                          child: Text('Ajouter'),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: PopupMenuButton(
        iconSize: 65,
        // elevation: 50,
        // tooltip: 'edede',
        icon: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: three,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 15,
                  blurStyle: BlurStyle.solid,
                  color: Color.fromARGB(255, 130, 255, 123))
            ],
          ),
          child: Icon(Icons.more_vert,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.edit),
                  // muni:true ;
                ),
              ),
              value: 1,
            ),
            PopupMenuItem(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListesPersonnesCommande(
                            listePersonnes: listePersonnes),
                      ),
                    );
                  },
                  child: Container(
                    child: const Icon(Icons.group),
                  ),
                ),
              ),
              value: 2,
            )
          ];
        },
        color: Colors.transparent,
        elevation: 0,
        onSelected: (value) {
          if (value == 1) {
          } else if (value == 2) {}
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
