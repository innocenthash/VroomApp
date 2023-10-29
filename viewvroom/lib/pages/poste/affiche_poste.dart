import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:viewvroom/models/poste.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/poste/afficheEmploye.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class AffichePoste extends StatefulWidget {
  const AffichePoste({super.key});

  @override
  State<AffichePoste> createState() => _AffichePosteState();
}

class _AffichePosteState extends State<AffichePoste> {
  SqliteDatabase sqliteDatabase = SqliteDatabase();
  Color three = OptionsCouleurs.three;
  Color blueF = OptionsCouleurs.blueF;
  Color oneColor = OptionsCouleurs.oneColor;
  List<Poste> postes = [];
  void deletePoste(BuildContext context) {}

  void editPoste(BuildContext context) {
    print('2');
  }

  void afficheEmploye(BuildContext context, Poste poste) {}

  Future<void> affichePoste() async {
    final donnees = await sqliteDatabase.getPostes();
    setState(() {
      postes = donnees;
    });
  }

  @override
  void initState() {
    affichePoste();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de postes'),
        backgroundColor: three,
        elevation: 0,
      ),
      backgroundColor: oneColor,
      body: Column(
        children: [
          GlassmorphicContainer(
            margin: EdgeInsets.all(15),
            width: double.infinity, // Largeur du conteneur
            height: 100, // Hauteur du conteneur
            borderRadius: 30, // Rayon des coins
            linearGradient: LinearGradient(
              // Dégradé de couleurs
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.15),
              ],
            ),
            border: 5, // Épaisseur de la bordure
            blur: 50, // Niveau de flou
            borderGradient: LinearGradient(
              // Dégradé de la bordure
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.4), // Couleur de la bordure
              ],
            ),
            child: Center(
              child: Text(
                'POSTES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: three,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: blueF.withOpacity(0.3),
                image: const DecorationImage(
                  image: ExactAssetImage(
                      "assets/image_container/homme-rendu-3d-solution-creative-lampe-enorme-removebg-preview (1).png"),
                  fit: BoxFit.cover,
                ),
              ),

              // ny anasina ny blur entre cote 2 , premier cote lay ray asina blur faharoa le ray tsy misy
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20.0,
                    sigmaY: 20.0,
                  ),

                  // cette container qui affa=ecte la couleur pour le blur
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    child: ListView.builder(
                        itemCount: postes.length,
                        itemBuilder: (context, index) {
                          Poste poste = postes[index];
                          return Container(
                            height: 100,
                            // margin: EdgeInsets.all(50),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              // child: ListTile(
                              //   leading: Text('Poste : ${poste.poste}'),
                              // //  trailing:  ,
                              // ),
                              child: Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(0),

                                // The start action pane is the one at the left or the top side.
                                endActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  // A pane can dismiss the Slidable.
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),

                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: (BuildContext context) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AfficheEmploye(poste: poste),
                                          ),
                                        );
                                      },
                                      // backgroundColor: three,
                                      foregroundColor: blueF,
                                      icon: Icons.list_alt_rounded,
                                      label: 'Afficher',
                                      borderRadius: BorderRadius.circular(100),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    SlidableAction(
                                      onPressed: editPoste,
                                      // backgroundColor: blueF,
                                      foregroundColor: three,
                                      icon: Icons.edit,
                                      label: 'Editer',
                                      padding: EdgeInsets.all(2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    SlidableAction(
                                      onPressed: deletePoste,
                                      // backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor:
                                          const Color.fromARGB(255, 255, 0, 0),
                                      icon: Icons.delete,
                                      label: 'Supprimer',
                                      borderRadius: BorderRadius.circular(100),
                                      padding: EdgeInsets.all(2),
                                    ),
                                  ],
                                ),

                                child: ListTile(
                                  title: Text(
                                      '${poste.id} | ${poste.poste.toUpperCase()}',
                                      style: TextStyle(color: blueF)),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
