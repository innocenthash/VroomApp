// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/personnes/reservation_personne.dart';
import 'package:viewvroom/pages/voitures/edit.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';

class VoirPlusVoiture extends StatefulWidget {
  final Voiture voiture;
  final List<Voiture> listesVoitures;
  final bool afficheImagesPermission;

  final Function afficheVoiture;
  // final Function(dynamic newListesVoitures) function;
  const VoirPlusVoiture({
    Key? key,
    required this.voiture,
    required this.afficheImagesPermission,
    required this.listesVoitures,
    required this.afficheVoiture,
    // required this.function
  }) : super(key: key);

  @override
  State<VoirPlusVoiture> createState() => _VoirPlusVoitureState();
}

class _VoirPlusVoitureState extends State<VoirPlusVoiture> {
  @override
  void initState() {
    super.initState();
    // widget.afficheVoiture();
    // widget.voiture;
    // listesVoitures;
  }

  final database = SqliteDatabase();
  Color twoColor = OptionsCouleurs.twoColor;
  Color oneColor = OptionsCouleurs.oneColor;
  Color three = OptionsCouleurs.three;
  Color five = Color.fromRGBO(192, 212, 255, 1);
  final Color bluef = OptionsCouleurs.blueF;

  Widget image(Voiture voiture) {
    // if (widget.afficheImagesPermission == false) {
    if (voiture.imageUrl != null) {
      return Container(
        margin: const EdgeInsets.only(top: 35, left: 20, right: 20),

        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 5,
                style: BorderStyle.solid),
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
            borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.memory(
              voiture.imageUrl!,
              fit: BoxFit.fill,

              //  cacheHeight:,
            ),
          ),
        ),
        // Image.file(
        //   File(voiture.imageUrl!),
        //   fit: BoxFit.cover,

        //   width: 200,
        //   height: 200,
        // ),
      );
    } else {
      return Text('image non disponnible');
    }
    // }
    // else {
    //   return Container(
    //     decoration: BoxDecoration(
    //         border: Border.all(
    //             style: BorderStyle.solid,
    //             color: const Color.fromARGB(255, 255, 255, 255),
    //             width: 10),
    //         color: Color.fromARGB(255, 221, 221, 221),
    //         borderRadius: BorderRadius.circular(20)),
    //     margin: EdgeInsets.all(20),
    //     height: 200,
    //     width: double.infinity,
    //     child: ClipOval(
    //       child: Image.asset(
    //         'assets/images_autos/loader1.gif',
    //         height: 100,
    //         width: 200,
    //       ),
    //     ),
    //   );
    // }
  }

  // alert  suppression

  alertSuppression(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation de suppression"),
          content: const Text(
              'Êtes-vous sûr de vouloir supprimer cet élément ? Cette action est irréversible.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                confirmerSuppression(id);

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('supprimer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmerSuppression(int id) async {
    await database.deleteVoiture(id);
    await database.deletePersonne(id);
    // setState(() {
    //   final newtab = database.getVoitures();

    //   widget.function(newtab);
    // });

    widget.afficheVoiture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.voiture.marque,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 35,
              fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReservationPersonne(
                        listesVoitures: widget.afficheVoiture,
                        stock: widget.voiture.stock!,
                        idVoiture: widget.voiture.id.toString())),
              );
            },
            icon: const Icon(Icons.person_add),
          ),
        ],
        backgroundColor: three,
      ),
      backgroundColor: oneColor,
      body: Container(
        decoration: BoxDecoration(
          color: bluef.withOpacity(0.3),
          image: DecorationImage(
            image: ExactAssetImage(
                "assets/image_caroussel/andre-tan-79-SQCseV08-unsplash-removebg-preview.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              child: Column(children: [
                Container(
                  child: image(widget.voiture),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 5,
                        style: BorderStyle.solid),
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white.withOpacity(0.2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 100,
                          child: Center(
                            child: ListTile(
                              leading: const Text(
                                'Nom de la voiture :',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(widget.voiture.nom),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white.withOpacity(0.2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 100,
                          child: Center(
                            child: ListTile(
                              leading: const Text(
                                'Année de fabrication de la voiture :',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(widget.voiture.anneedefabrication),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white.withOpacity(0.2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: 120,
                          child: ListTile(
                            leading: const Text(
                              'Description :',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: SingleChildScrollView(
                                child: Text(
                              widget.voiture.description,
                              maxLines: 50,
                              overflow: TextOverflow.visible,
                            )),
                            // trailing: Text(widget.voiture.id.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                  height: 100,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.white  , width: 5)),
                  child: Card(
                    elevation: 2,
                    color: Colors.white.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  style: BorderStyle.solid,
                                  width: 5),
                              borderRadius: BorderRadius.circular(50),
                              color: three,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(
                                            afficheVoiture:
                                                widget.afficheVoiture,
                                            afficheImagesPermission:
                                                widget.afficheImagesPermission,
                                            voiture: widget.voiture)),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 40,
                                ))),
                        Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  style: BorderStyle.solid,
                                  width: 5),
                              borderRadius: BorderRadius.circular(50),
                              color: twoColor,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  alertSuppression(context, widget.voiture.id!);
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.white,
                                  size: 40,
                                )))
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
