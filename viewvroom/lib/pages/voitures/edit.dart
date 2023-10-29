import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:viewvroom/sqlite_database/sqlite_database.dart';

class Edit extends StatefulWidget {
  final Voiture voiture;
  final bool afficheImagesPermission;
  final Function afficheVoiture;
  const Edit(
      {super.key,
      required this.voiture,
      required this.afficheImagesPermission,
      required this.afficheVoiture});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  // @override
  // void initState() {
  //   super.initState();
  //    widget.afficheVoiture();
  //   // listesVoitures;
  // }

  final sqliteDatabase = SqliteDatabase();

  Color three = OptionsCouleurs.three;
  Color oneColor = OptionsCouleurs.oneColor;
  final Color bluef = OptionsCouleurs.blueF;
  bool isVisible = false;
  TextEditingController nomVoiture = TextEditingController();
  TextEditingController marqueVoiture = TextEditingController();
  TextEditingController anneeDeFabricationVoiture = TextEditingController();
  TextEditingController descriptionVoiture = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController stock = TextEditingController();
  String? imageBytes;
  // File? _image;

  // late String extension;
  // //  selectionner une image
  // final selectImage = ImagePicker();

  // Future<void> _selectionner() async {
  //   final img = await selectImage.pickImage(source: ImageSource.gallery);

  //   if (img != null) {
  //     setState(() {
  //       _image = File(img.path);
  //     });

  //     // on va extraire l'extension de l'image

  //     extension = path.extension(img.path);
  //   }
  // }
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

        // extension = path.extension(selectImageGallery.path);
      }
    }
  }

// alert sans image apres modification
  void afficherAlertUpdateReussiAvecImagePrecedent() {}
// affichage d'image qui n'a pas de permis
  Widget image(Voiture voiture) {
    if (widget.afficheImagesPermission == false) {
      if (voiture.imageUrl != null) {
        return Container(
          color: Colors.amber,
          height: 50,
          width: 50,
          child: Image.memory(
            voiture.imageUrl!,
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
          // Image.file(
          //   File(voiture.imageUrl!),
          //   fit: BoxFit.cover,
          //   width: 20,
          //   height: 20,
          // ),
        );
      } else {
        return Text('image non disponnible');
      }
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid,
                color: const Color.fromARGB(255, 255, 255, 255),
                width: 10),
            color: Color.fromARGB(255, 221, 221, 221),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(20),
        height: 50,
        width: double.infinity,
        child: ClipOval(
          child: Image.asset(
            'assets/images_autos/loader1.gif',
            height: 10,
            width: 20,
          ),
        ),
      );
    }
  }

  // function update
  Widget updateVoiture() {
    return ElevatedButton(
      onPressed: () async {
        try {
          widget.voiture.nom = nomVoiture.text;
          widget.voiture.marque = marqueVoiture.text;
          widget.voiture.anneedefabrication = anneeDeFabricationVoiture.text;
          widget.voiture.description = descriptionVoiture.text;
          // convertir string en Uint8List
          Uint8List imageByt = Uint8List.fromList(imageUrl.text.codeUnits);

          widget.voiture.imageUrl = imageByt;
          widget.voiture.stock = int.tryParse(stock.text);

          if (
              // _image == null ||
              nomVoiture.text.isEmpty ||
                  marqueVoiture.text.isEmpty ||
                  anneeDeFabricationVoiture.text.isEmpty ||
                  descriptionVoiture.text.isEmpty) {
            // Affichez un message d'erreur si un champ est vide
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez remplir tous les champs.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            // on cree un repertoire pour stocker l'image s'il n'existe pas encore
            if (_imageBytes == null) {
              Voiture voiture = Voiture(
                  id: null,
                  stock: widget.voiture.stock,
                  nom: widget.voiture.nom,
                  marque: widget.voiture.marque,
                  anneedefabrication: widget.voiture.anneedefabrication,
                  description: widget.voiture.description,
                  imageUrl: widget.voiture.imageUrl);

              int voitureUpdateId = await sqliteDatabase.updateVoiture(voiture);
              // Voiture voiture = Voiture(
              //     id: null,
              //     nom: nomVoiture,
              //     marque: marqueVoiture,
              //     anneedefabrication: anneeVoiture,
              //     description: descriptionVoiture,
              //     imageUrl: imagePath);

              // int voitureId = await sqliteDatabase.createVoiture(voiture);

              // ignore: unnecessary_null_comparison
              if (voitureUpdateId != null && voitureUpdateId != -1) {
                // L'enregistrement a réussi
                // Affichez l'alerte d'enregistrement réussi
                afficherAlertUpdateReussi();
//
                //  setState(() {
                //      widget.afficheVoiture();
                //  });
                // Effacez les champs de texte après l'enregistrement
                // nomVoiture.clear();
                // marqueVoiture.clear();
                // anneeDeFabricationVoiture.clear();
                // descriptionVoiture.clear();
                // setState(() {
                //   _image = null;
                // });
              } else {
                // L'enregistrement a échoué
                // Affichez un message d'erreur
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Erreur lors de la mise à jour de la voiture.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              // final directory = await getApplicationDocumentsDirectory();
              // final imageDirectory = Directory('${directory.path}/images');

              // if (!imageDirectory.existsSync()) {
              //   imageDirectory.createSync(recursive: true);
              // }
              // final uniqueFichier =
              //     DateTime.now().microsecondsSinceEpoch.toString() + extension;

              // final imagePath = '${imageDirectory.path}/$uniqueFichier';

              Voiture voiture = Voiture(
                  id: null,
                  stock: widget.voiture.stock,
                  nom: widget.voiture.nom,
                  marque: widget.voiture.marque,
                  anneedefabrication: widget.voiture.anneedefabrication,
                  description: widget.voiture.description,
                  imageUrl: _imageBytes);

              int voitureUpdateId = await sqliteDatabase.updateVoiture(voiture);
              // Voiture voiture = Voiture(
              //     id: null,
              //     nom: nomVoiture,
              //     marque: marqueVoiture,
              //     anneedefabrication: anneeVoiture,
              //     description: descriptionVoiture,
              //     imageUrl: imagePath);

              // int voitureId = await sqliteDatabase.createVoiture(voiture);

              // ignore: unnecessary_null_comparison
              if (voitureUpdateId != null && voitureUpdateId != -1) {
                // L'enregistrement a réussi
                // Affichez l'alerte d'enregistrement réussi
                afficherAlertUpdateReussi();

                // setState(() {
                //      widget.afficheVoiture();
                // });

                // Effacez les champs de texte après l'enregistrement
                // nomVoiture.clear();
                // marqueVoiture.clear();
                // anneeDeFabricationVoiture.clear();
                // descriptionVoiture.clear();
                // setState(() {
                //   _image = null;
                // });
              } else {
                // L'enregistrement a échoué
                // Affichez un message d'erreur
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Erreur lors de la mise à jour de la voiture.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          }
          // final directory = await getApplicationDocumentsDirectory();
          // final imageDirectory = Directory('${directory.path}/images');

          // if (!imageDirectory.existsSync()) {
          //   imageDirectory.createSync(recursive: true);
          // }
          // final uniqueFichier =
          //     DateTime.now().microsecondsSinceEpoch.toString() + extension;

          // final imagePath = '${imageDirectory.path}/$uniqueFichier';
          // Voiture voiture = Voiture(
          //     id: null,
          //     nom: widget.voiture.nom,
          //     marque: widget.voiture.marque,
          //     anneedefabrication: widget.voiture.anneedefabrication,
          //     description: widget.voiture.description,
          //     imageUrl: _image == null ? widget.voiture.imageUrl : imagePath);

          // int voitureUpdateId = await sqliteDatabase.updateVoiture(voiture);

          // on genere un nom de fichier unique pour l'image

          //   // Voiture voiture = Voiture(
          //   //     id: null,
          //   //     nom: nomVoiture,
          //   //     marque: marqueVoiture,
          //   //     anneedefabrication: anneeVoiture,
          //   //     description: descriptionVoiture,
          //   //     imageUrl: imagePath);

          //   // int voitureId = await sqliteDatabase.createVoiture(voiture);

          //   // ignore: unnecessary_null_comparison
          //   if (voitureUpdateId != null && voitureUpdateId != -1) {
          //     // L'enregistrement a réussi
          //     // Affichez l'alerte d'enregistrement réussi
          //     afficherAlertUpdateReussi();

          //     // Effacez les champs de texte après l'enregistrement
          //     nomVoiture.clear();
          //     marqueVoiture.clear();
          //     anneeDeFabricationVoiture.clear();
          //     descriptionVoiture.clear();
          //     setState(() {
          //       _image = null;
          //     });
          //   } else {
          //     // L'enregistrement a échoué
          //     // Affichez un message d'erreur
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Erreur lors de la mise à jour de la voiture.'),
          //         duration: Duration(seconds: 2),
          //       ),
          //     );
          //   }
          // }
        } catch (e) {
          // En cas d'erreur, affichez un message d'erreur
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors de la mise à jour de la voiture'),
              duration: Duration(seconds: 2),
            ),
          );
          print('Erreur lors de l\'enregistrement de la voiture : $e');
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.white, width: 3)),
        backgroundColor: three,
        elevation: 5,
      ),
      child: const Text('Modifiez'),
    );
  }

  void afficherAlertUpdateReussi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mise à jour réussi'),
          content: _imageBytes == null
              ? const Text(
                  'La voiture a été modifiée avec succès mais sans changer son ancienne image')
              : const Text('La voiture a été modifiée avec succès.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // Fermer l'alerte
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
    super.initState();

    // isVisible = !isVisible ;
    nomVoiture.text = widget.voiture.nom;
    marqueVoiture.text = widget.voiture.marque;
    anneeDeFabricationVoiture.text = widget.voiture.anneedefabrication;
    descriptionVoiture.text = widget.voiture.description;

    // if (widget.voiture.imageUrl != null) {
    //  imageBytes = utf8.decode(widget.voiture.imageUrl!);
    //   // Utilisez imageBytes ici
    // } else {
    //   // Gérez le cas où imageUrl est nul
    // }

    imageUrl.text = String.fromCharCodes(widget.voiture.imageUrl!);

    stock.text = widget.voiture.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: oneColor,
      appBar: AppBar(
        title: Text('Voiture à modifier'),
        backgroundColor: three,
      ),
      body: Container(
        // height: 500,
        // margin: EdgeInsets.all(20),
        // margin: EdgeInsets.only(top: 10),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(30),
        //   color: const Color.fromARGB(255, 255, 255, 255),
        //   boxShadow: const [
        //     BoxShadow(
        //         color: Color.fromARGB(255, 220, 220, 220),
        //         spreadRadius: 2,
        //         blurRadius: 10),
        //   ],
        // ),
        decoration: BoxDecoration(
          color: bluef.withOpacity(0.3),
          image: const DecorationImage(
            image: ExactAssetImage(
                "assets/image_caroussel/goh-rhy-yan-f_SDCASisgs-unsplash-removebg-preview.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: bluef.withOpacity(0.5),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.6),
                            width: 5),
                      ),
                      margin: const EdgeInsets.only(
                          top: 15, left: 20, right: 20, bottom: 10),
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          'Modification',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10),
                      margin:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextField(
                        controller: nomVoiture,
                        decoration: InputDecoration(
                          label: Text('Nom de la voiture'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                        controller: marqueVoiture,
                        decoration: InputDecoration(
                          label: Text('Marque de la voiture'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextField(
                            controller: anneeDeFabricationVoiture,
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
                              top: 20, left: 20, right: 20),
                          child: TextField(
                            keyboardType: TextInputType.number,
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
                    Visibility(
                      visible: isVisible,
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextField(
                          controller: imageUrl,
                          decoration: InputDecoration(
                            label: Text('image recent'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                        controller: descriptionVoiture,
                        decoration: InputDecoration(
                          label: Text('Description'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   child: image(widget.voiture) ,
                    //   ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      // color: Colors.amber,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // if(_image != null){
                              //          Image.file(File(_image!.path))
                              // } else{

                              // }
                              // if (_image != null)
                              //   Padding(
                              //     padding: const EdgeInsets.only(right: 10, left: 70),
                              //     child: ClipOval(
                              //         child: Image.file(
                              //       File(_image!.path),
                              //       fit: BoxFit.cover,
                              //       width: 50,
                              //       height: 50,
                              //     )),
                              //   )
                              // else
                              //   const Padding(
                              //     padding: EdgeInsets.only(right: 10, left: 20),
                              //     child: Text('Aucune image sélectionnée'),
                              //   ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 50, left: 10),
                              //   child: OutlinedButton.icon(
                              //     style: ButtonStyle(
                              //         shape: MaterialStatePropertyAll(
                              //             RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(20)))),
                              //     onPressed: selectionnerEtAfficher,
                              //     icon: const Icon(Icons.image),
                              //     label: const Text('image'),
                              //   ),
                              // ),
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
                                      padding:
                                          EdgeInsets.only(right: 10, left: 60),
                                      child: Text(
                                        'Aucune image sélectionnée',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, left: 10),
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  onPressed: selectionnerEtAfficher,
                                  icon: const Icon(Icons.image , color: Colors.white,),
                                  label: const Text('image',style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      width: double.infinity,
                      height: 70,
                      child: updateVoiture(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
