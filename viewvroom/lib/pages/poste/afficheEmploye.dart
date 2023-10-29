import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viewvroom/models/empoye.dart';
import 'package:viewvroom/models/poste.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';
import 'package:glassmorphism/glassmorphism.dart';

class AfficheEmploye extends StatefulWidget {
  final Poste poste;
  const AfficheEmploye({super.key, required this.poste});

  @override
  State<AfficheEmploye> createState() => _AfficheEmployeState();
}

class _AfficheEmployeState extends State<AfficheEmploye> {
  SqliteDatabase sqliteDatabase = SqliteDatabase();
  Color three = OptionsCouleurs.three;
  Color blueF = OptionsCouleurs.blueF;
  Color oneColor = OptionsCouleurs.oneColor;
  List<Employe> afficheCadres = [];

  bool afficheImagesPermission = false;

  Future<void> afficheEmploye() async {
    final cadre = await sqliteDatabase.getEmploye(widget.poste.id!);
    setState(() {
      afficheCadres = cadre;

      // afficheImagesPermission = afficheImagesPermission;
    });
    // //  permission de stockage pour afficher les images
    // final status = await Permission.storage.request();

    // if (status.isGranted) {
    //   // on reçoit la permission
    //   final cadre = await sqliteDatabase.getEmploye(widget.poste.id!);

    //   setState(() {
    //     afficheCadres = cadre;

    //     afficheImagesPermission = afficheImagesPermission;
    //   });
    // } else if (status.isDenied) {
    //   _showPermissionDeniedDialog();

    //   afficheImagesPermission = true;

    //   final cadre = await sqliteDatabase.getEmploye(widget.poste.id!);

    //   setState(() {
    //     afficheCadres = cadre;
    //   });
    // } else if (status.isPermanentlyDenied) {
    //   _openAppSettings();
    // }
  }

  Widget image(Employe employe) {
    // if (afficheImagesPermission == false) {
    return Container(
      // color: Colors.amber,

      height: 200,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: 10 ,
                style: BorderStyle.solid
              ),

              borderRadius: BorderRadius.circular(110)
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.memory(
                  employe.imageUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // }

    //  else {
    //   return Container(
    //     // color: Colors.amber,
    //     height: 200,
    //     width: double.infinity,
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: Container(
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(50),
    //           child: Container(
    //             height: 150,
    //             width: 150,
    //             decoration: BoxDecoration(
    //               // color: Colors.orange,
    //               color: three,
    //               borderRadius: BorderRadius.circular(100),
    //               border: Border.all(
    //                   color: Colors.white, style: BorderStyle.solid, width: 3),
    //             ),
    //             child: Image.asset(
    //               'assets/images_profil_employe/profil.png',
    //               cacheHeight: 100,
    //               width: 100,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  // void _showPermissionDeniedDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Autorisations requises"),
  //         content: const Text(
  //             "L'accès au stockage est nécessaire pour charger les images."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Fermer la boîte de dialogue
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _openAppSettings() {
  //   openAppSettings();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    afficheEmploye();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadre ${widget.poste.id}'),
        backgroundColor: three,
        elevation: 0,
      ),
      backgroundColor: oneColor,
      body: Column(
        children: [
          Container(),
          GlassmorphicContainer(
            margin: EdgeInsets.all(20),
            width: double.infinity, // Largeur du conteneur
            height: 100, // Hauteur du conteneur
            borderRadius: 16, // Rayon des coins
            linearGradient: LinearGradient(
              // Dégradé de couleurs
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                blueF.withOpacity(0.9),
                blueF.withOpacity(0.5),
              ],
            ),
            border: 5, // Épaisseur de la bordure
            blur: 50, // Niveau de flou
            borderGradient: LinearGradient(
              // Dégradé de la bordure
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.9),
                Color((0xFFFFFFFF)).withOpacity(0.9), // Couleur de la bordure
              ],
            ),
            child: Center(
              child: Text(
                'Fiche des employés',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(2),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemCount: afficheCadres.length,
                itemBuilder: (context, index) {
                  Employe employe = afficheCadres[index];
                  return Container(
                    // height: 400,
                    child: Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                color: Colors.black12,
                                // color: blueF,
                                width: double.infinity,
                                height: 200,
                              ),
                              image(employe),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nom :'),
                                Text(employe.nom),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('prenom :'),
                                Text(employe.prenom),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Numero telephone :'),
                                Text(employe.numero),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('E-mail :'),
                                Text(employe.mail),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Adresse :'),
                                Text(employe.adresse),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date d\'embauche :'),
                                Text(employe.dateDembauche),
                              ],
                            ),
                          ),

                          //  avec true et false
                          Container(
                            margin: EdgeInsets.only(
                                right: 10, left: 10, bottom: 10 ,top: 20),
                            width: double.infinity,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Evaluation annuel :'),
                                // Text(employe.dateDembauche),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
