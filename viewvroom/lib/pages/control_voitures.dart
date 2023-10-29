// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:viewvroom/models/voiture.dart';
// import 'package:viewvroom/options/options_couleurs.dart';
// import 'package:viewvroom/sqlite_database/sqlite_database.dart';
// import 'package:path/path.dart' as path;

// class ControlVoitures extends StatefulWidget {
//   const ControlVoitures({super.key});

//   @override
//   State<ControlVoitures> createState() => _ControlVoituresState();
// }

// class _ControlVoituresState extends State<ControlVoitures> {
//   final sqliteDatabase = SqliteDatabase();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController marque = TextEditingController();
//   final TextEditingController anneeDeFabrication = TextEditingController();
//   final TextEditingController description = TextEditingController();
//   final TextEditingController stock = TextEditingController();
//   Color twoColor = OptionsCouleurs.twoColor;
//   final Color bluef = OptionsCouleurs.blueF;
//  File? _image;
//   late String extension;
//   //  selectionner une image
//   final selectImage = ImagePicker();

//   late Uint8List _imageBytes;

// // ancien version pour selectionner l'image
//   // Future<void> _selectionner() async {
//   //   final img = await selectImage.pickImage(source: ImageSource.gallery);

//     if (img != null) {
//       setState(() {
//         _image = File(img.path);
//       });

//       // on va extraire l'extension de l'image

//       extension = path.extension(img.path);
//     }
//   }

// // nouvelle version avec Uint8List

//   // Future<void> selectionnerEtAfficher() async {
//   //   final selectImageGallery =
//   //       await selectImage.pickImage(source: ImageSource.gallery);
//   //       if (selectImageGallery!=null) {
//   //         final Uint8List imageBytes = await PickedFile.readAsBytes();
//   //       }
        
//   // }
//   Future<void> selectionnerEtAfficher() async {
//   final selectImageGallery =
//       await selectImage.pickImage(source: ImageSource.gallery);
  
//   if (selectImageGallery != null) {
//     final File imageFile = File(selectImageGallery.path);
//     if (await imageFile.exists()) {
//       final Uint8List imageBytes = await imageFile.readAsBytes();
//       // Maintenant, vous avez les données de l'image en bytes.
//       setState(() {
//         _imageBytes = imageBytes;
//       });
//   }
// }

//   void afficherAlerteEnregistrementReussi() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Enregistrement réussi'),
//           content: Text('La voiture a été enregistrée avec succès.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Fermer l'alerte
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // get id => null;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
          // Container(
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
//           // Divider(
//           //   endIndent: 52,
//           //   indent: 52,
//           //   height: 2,
//           // ),
//           Container(
//             margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 color: const Color.fromARGB(255, 255, 255, 255)),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(top: 10),
//                   margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
//                   child: TextField(
//                     controller: name,
//                     decoration: InputDecoration(
//                       labelText: 'Nom',
//                       hintText: 'Entrez le nom de la voiture',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
//                   child: TextField(
//                     controller: marque,
//                     decoration: InputDecoration(
//                       labelText: 'Marque',
//                       hintText: 'Entrez la marque de la voiture',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(color: Colors.black)),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 150,
//                       margin:
//                           const EdgeInsets.only(top: 10, left: 20, right: 20),
//                       child: TextField(
//                         controller: anneeDeFabrication,
//                         decoration: InputDecoration(
//                           labelText: 'Année de fabrication',
//                           hintText: 'Entrez l\'année de fabrication',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   const BorderSide(color: Colors.black)),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       margin:
//                           const EdgeInsets.only(top: 10, left: 20, right: 20),
//                       child: TextField(
//                         // keyboardType: TextInputType.number,
//                         controller: stock,
//                         decoration: InputDecoration(
//                           labelText: 'stock',
//                           hintText: 'voiture en stock',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide:
//                                   const BorderSide(color: Colors.black)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
//                   child: TextField(
//                     maxLines: 5,
//                     controller: description,
//                     decoration: InputDecoration(
//                       labelText: 'Description',
//                       hintText: 'Entrez la description de la voiture ',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(color: Colors.black)),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 10, right: 20, top: 10),
//                   // color: Colors.amber,
//                   width: double.infinity,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           // if(_image != null){
//                           //          Image.file(File(_image!.path))
//                           // } else{

//                           // }
//                           if (_imageBytes != null)
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: 10, left: 70),
//                               child: ClipOval(
//                                   child: Image.memory(_imageBytes) ,
                               
//                                 fit: BoxFit.cover,
//                                 width: 50,
//                                 height: 50,
//                               )),
//                             )
//                           else
//                             const Padding(
//                               padding: EdgeInsets.only(right: 10, left: 20),
//                               child: Text('Aucune image sélectionnée'),
//                             ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 50, left: 10),
//                             child: OutlinedButton.icon(
//                               style: ButtonStyle(
//                                   shape: MaterialStatePropertyAll(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20)))),
//                               onPressed: selectionnerEtAfficher,
//                               icon: const Icon(Icons.image),
//                               label: const Text('image'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.only(bottom: 10),
//                   margin: const EdgeInsets.only(left: 20, right: 20),
//                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),

//                   child: OutlinedButton(
//                     onPressed: () async {
//                       try {
//                         String nomVoiture = name.text;
//                         String marqueVoiture = marque.text;
//                         String anneeVoiture = anneeDeFabrication.text;
//                         String descriptionVoiture = description.text;
//                         String stockVoiture = stock.text;
//                         int stockInt = int.parse(stockVoiture);

//                         if (_image == null ||
//                             nomVoiture.isEmpty ||
//                             marqueVoiture.isEmpty ||
//                             anneeVoiture.isEmpty ||
//                             descriptionVoiture.isEmpty ||
//                             stockVoiture.isEmpty) {
//                           // Affichez un message d'erreur si un champ est vide
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content:
//                                   Text('Veuillez remplir tous les champs.'),
//                               duration: Duration(seconds: 2),
//                             ),
//                           );
//                         } else {
//                           // on cree un repertoire pour stocker l'image s'il n'existe pas encore

//                           final directory =
//                               await getApplicationDocumentsDirectory();
//                           final imageDirectory =
//                               Directory('${directory.path}/images');

//                           if (!imageDirectory.existsSync()) {
//                             imageDirectory.createSync(recursive: true);
//                           }

//                           // on genere un nom de fichier unique pour l'image

//                           final uniqueFichier =
//                               DateTime.now().microsecondsSinceEpoch.toString() +
//                                   extension;

//                           final imagePath =
//                               '${imageDirectory.path}/$uniqueFichier';
//                           Voiture voiture = Voiture(
//                               id: null,
//                               stock: stockInt,
//                               nom: nomVoiture,
//                               marque: marqueVoiture,
//                               anneedefabrication: anneeVoiture,
//                               description: descriptionVoiture,
//                               imageUrl: imagePath);

//                           int voitureId =
//                               await sqliteDatabase.createVoiture(voiture);

//                           // ignore: unnecessary_null_comparison
//                           if (voitureId != null && voitureId != -1) {
//                             // L'enregistrement a réussi
//                             // Affichez l'alerte d'enregistrement réussi
//                             afficherAlerteEnregistrementReussi();

//                             // Effacez les champs de texte après l'enregistrement
//                             name.clear();
//                             marque.clear();
//                             anneeDeFabrication.clear();
//                             description.clear();
//                             setState(() {
//                               _image = null;
//                             });
//                           } else {
//                             // L'enregistrement a échoué
//                             // Affichez un message d'erreur
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'Erreur lors de l\'enregistrement de la voiture.'),
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//                           }
//                         }
//                       } catch (e) {
//                         // En cas d'erreur, affichez un message d'erreur
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text(
//                                 'Erreur lors de l\'enregistrement de la voiture'),
//                             duration: Duration(seconds: 2),
//                           ),
//                         );
//                         print(
//                             'Erreur lors de l\'enregistrement de la voiture : $e');
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: const Color.fromARGB(255, 255, 255, 255),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       backgroundColor: twoColor,
//                     ),
//                     child: const Text('Enregistrez'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     // Container(

//     //   color: Colors.amber,
//     //   margin: EdgeInsets.all(30),
//     //   // height: 200,
//     //   child: const Text('data'),
//     // );
//   }
// }
