import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';

import 'package:path/path.dart' as path;

class CreateVoiture extends StatefulWidget {
  const CreateVoiture({super.key});

  @override
  State<CreateVoiture> createState() => _CreateVoitureState();
}

class _CreateVoitureState extends State<CreateVoiture> {
  final TextEditingController name = TextEditingController();
  final TextEditingController marque = TextEditingController();
  final TextEditingController anneeDeFabrication = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController stock = TextEditingController();
  final sqlitedatabase = SqliteDatabase();

  Color twoColor = OptionsCouleurs.twoColor;
  final Color bluef = OptionsCouleurs.blueF;
  final Color primaryColor = OptionsCouleurs.primaryColor;
  final Color three = OptionsCouleurs.three;
  late String extension;
  final selectImage = ImagePicker();

  Uint8List? _imageBytes;

  Future<void> selectionnerEtAfficher() async {
    final selectImageGallery =
        await selectImage.pickImage(source: ImageSource.gallery);

    if (selectImageGallery != null) {
      final File imageFile = File(selectImageGallery.path);
      if (await imageFile.exists()) {
        final Uint8List imageBytes = await imageFile.readAsBytes();
        setState(() {
          _imageBytes = imageBytes;
        });

        extension = path.extension(selectImageGallery.path);
      }
    }
  }

  void afficherAlerteEnregistrementReussi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enregistrement réussi'),
          content: Text('La voiture a été enregistrée avec succès.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer l'alerte
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // get id =>
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: bluef.withOpacity(0.8),
              border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255), width: 5),
            ),
            margin:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
            width: double.infinity,
            child: Center(
              child: Text(
                'Nouvelle',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),

          // contenue

          Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: three.withOpacity(0.1),
              image: const DecorationImage(
                image: ExactAssetImage(
                    "assets/image_container/voiture-roulant-herbe-verte-entouree-par-nature-ai-generative-removebg-preview.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.grey.withOpacity(0.3),
                  child: Column(
                    children: [
                      //       Container(
                      //   margin: const EdgeInsets.only(top: 10, left: 80, right: 80),
                      //   width: double.infinity,
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(30),
                      //     color: bluef,
                      //     border: Border.all(
                      //         color: const Color.fromARGB(255, 255, 255, 255), width: 3),
                      //   ),
                      //   child: const Center(
                      //     child: Text(
                      //       'Nouvelle Voiture',
                      //       style: TextStyle(
                      //           color: Color.fromARGB(255, 255, 255, 255),
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.w800),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                              labelText: 'Nom',
                              hintText: 'Entrez le nom de la voiture',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              focusColor: Colors.amber,
                              fillColor: Colors.amber,
                              hoverColor: Colors.amber),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextField(
                          controller: marque,
                          decoration: InputDecoration(
                            labelText: 'Marque',
                            hintText: 'Entrez la marque de la voiture',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: TextField(
                              controller: anneeDeFabrication,
                              decoration: InputDecoration(
                                labelText: 'Année de fabrication',
                                hintText: 'Entrez l\'année de fabrication',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: TextField(
                              // keyboardType: TextInputType.number,
                              controller: stock,
                              decoration: InputDecoration(
                                labelText: 'stock',
                                hintText: 'voiture en stock',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextField(
                          maxLines: 5,
                          controller: description,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Entrez la description de la voiture ',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, right: 20, top: 10),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _imageBytes != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 70),
                                        child: ClipOval(
                                          child: Image.memory(
                                            _imageBytes!,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 20),
                                        child: Text('Aucune image sélectionnée',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255))),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 10),
                                  child: OutlinedButton.icon(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20)))),
                                    onPressed: selectionnerEtAfficher,
                                    icon: const Icon(Icons.image,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    label: const Text('image',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        //                   padding: EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                        child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              backgroundColor: three,
                            ),
                            onPressed: () async {
                              try {
                                String nomVoiture = name.text;
                                String marqueVoiture = marque.text;
                                String anneeVoiture = anneeDeFabrication.text;
                                String descriptionVoiture = description.text;
                                String stockVoiture = stock.text;
                                int stockInt = int.parse(stockVoiture);

                                if (_imageBytes == null ||
                                    nomVoiture.isEmpty ||
                                    marqueVoiture.isEmpty ||
                                    anneeVoiture.isEmpty ||
                                    descriptionVoiture.isEmpty ||
                                    stockVoiture.isEmpty) {
                                  // Affichez un message d'erreur si un champ est vide
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Veuillez remplir tous les champs.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  // on cree un repertoire pour stocker l'image s'il n'existe pas encore

                                  // final directory = await getTemporaryDirectory();

                                  // final imageDirectory =
                                  //     Directory('${directory.path}/images');

                                  // if (!imageDirectory.existsSync()) {
                                  //   imageDirectory.createSync(recursive: true);
                                  // }

                                  // on genere un nom de fichier unique pour l'image

                                  //                       final uniqueFichier =
                                  //                           DateTime.now().microsecondsSinceEpoch.toString() +
                                  //                               extension;
                                  // final directory = await getTemporaryDirectory();
                                  //   final file = File('${directory.path}/$uniqueFichier');
                                  //   await file.writeAsBytes(_imageBytes!);
                                  //                      final imagePath = '${directory.path}/$uniqueFichier';

                                  Voiture voiture = Voiture(
                                      id: null,
                                      stock: stockInt,
                                      nom: nomVoiture,
                                      marque: marqueVoiture,
                                      anneedefabrication: anneeVoiture,
                                      description: descriptionVoiture,
                                      imageUrl: _imageBytes);

                                  int voitureId = await sqlitedatabase
                                      .createVoiture(voiture);

                                  // ignore: unnecessary_null_comparison
                                  if (voitureId != null && voitureId != -1) {
                                    // L'enregistrement a réussi
                                    // Affichez l'alerte d'enregistrement réussi
                                    afficherAlerteEnregistrementReussi();

                                    // Effacez les champs de texte après l'enregistrement
                                    name.clear();
                                    marque.clear();
                                    anneeDeFabrication.clear();
                                    description.clear();
                                    setState(() {
                                      _imageBytes = null;
                                    });
                                  } else {
                                    // L'enregistrement a échoué
                                    // Affichez un message d'erreur
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Erreur lors de l\'enregistrement de la voiture.'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                // En cas d'erreur, affichez un message d'erreur
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Erreur lors de l\'enregistrement de la voiture'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                print(
                                    'Erreur lors de l\'enregistrement de la voiture : $e');
                              }
                            },
                            child: Text('Sauvegardez')),
                      )
                    ],
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
