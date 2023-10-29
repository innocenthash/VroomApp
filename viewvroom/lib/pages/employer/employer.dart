import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viewvroom/models/empoye.dart';
import 'package:viewvroom/models/poste.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Employer extends StatefulWidget {
  const Employer({super.key});

  @override
  State<Employer> createState() => _EmployerState();
}

class _EmployerState extends State<Employer> {
  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  // TextEditingController posteId = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController dateDembauche = TextEditingController();
  Color bluef = OptionsCouleurs.blueF;
  Color three = OptionsCouleurs.three;
  Color oneColor = OptionsCouleurs.oneColor;
  SqliteDatabase sqliteDatabase = SqliteDatabase();
  List<Poste> postesChoix = [];
  List<Poste> postes = [];
  String? selectedValue = '1';

  // File? _image;

  final selectImage = ImagePicker();
  late String extension;

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
  // Future<void> _selectionner() async {
  //   final img = await selectImage.pickImage(source: ImageSource.gallery);

  //   if (img != null) {
  //     setState(() {
  //       _image = File(img.path);
  //     });

  //     extension = path.extension(img.path);
  //   }

  // }

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

  void afficherAlerteEnregistrementReussi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enregistrement réussi'),
          content: Text('Nouveau employé enregistrée avec succès.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: oneColor,
      appBar: AppBar(
        title: Text('Employer'),
        backgroundColor: three,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              // color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: three.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 3),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.white,
                              // blurStyle: BlurStyle.solid,
                              spreadRadius: 1),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: const Center(
                            child: Text(
                              'Nouveau membre',
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

                  // Container(
                  //   // ignore: prefer_if_null_operators
                  //   child: postes.isNotEmpty
                  //       ? selectedValue != null
                  //           ? Text(selectedValue!)
                  //           : Text('data')
                  //       : const Text('data'),
                  // ),
                  Container(
                    // margin: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: bluef.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      image: const DecorationImage(
                        image: ExactAssetImage(
                            "assets/image_container/vue-homme-affaires-confiant-3d-removebg-preview.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.2),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: nom,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: 'Entrez le nom',
                                    labelText: 'Nom de l\'emplyé',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: prenom,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    hintText: 'Entrez le prenom',
                                    labelText: 'Premon de l\'employé ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: postes.isNotEmpty
                                    ? DropdownButton<String>(
                                        value:
                                            selectedValue, // La valeur sélectionnée (doit être unique parmi les éléments)
                                        items: postes.map((Poste poste) {
                                          return DropdownMenuItem<String>(
                                            value: poste.id
                                                .toString(), // La valeur de cet élément (doit être unique)
                                            child: Text(poste
                                                .poste), // Le texte affiché dans le menu déroulant
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                      )
                                    : Text('data'),
                              ),
                              //               Container(
                              //                 margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                              //                 child: ChipsChoice<Poste>.multiple(
                              //   value: postesChoix,
                              //   onChanged: (val) => setState(() => postesChoix = val),
                              //   choiceItems: C2Choice.listFrom<Poste, Poste>(
                              //     source: postes,
                              //     value: (i, v) => v,
                              //     label: (i, v) => v.poste,
                              //   ),
                              // ),
                              //               ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: numero,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Entrez le contact',
                                    labelText: 'Numero',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: mail,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Entrez l\'adresse e-mail',
                                    labelText: 'Son adresse e-mail',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: adresse,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Entrez son adresse',
                                    labelText: 'Adresse',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20),
                                child: TextField(
                                  controller: dateDembauche,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    hintText: 'Entez la date d\'embauche',
                                    labelText: 'Date d\'embauche',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 3),
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 20, top: 10),
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // if(_image != null){
                                        //          Image.file(File(_image!.path))
                                        // } else{

                                        // }
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
                                                    right: 40, left: 60),
                                                child: Text(
                                                    'Aucune image sélectionnée',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50, left: 10),
                                          child: OutlinedButton.icon(
                                            style: ButtonStyle(
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20)))),
                                            onPressed: selectionnerEtAfficher,
                                            icon: const Icon(Icons.image,color: Color.fromARGB(255, 255, 255, 255)),
                                            label: const Text('image',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 10, right: 20, left: 20, bottom: 200),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.white, width: 3)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      String n = nom.text;
                                      print(n);
                                      String p = prenom.text;
                                      // String pid = posteId.text;
                                      int posteInt = int.parse(selectedValue!);
                                      String num = numero.text;
                                      String m = mail.text;
                                      String ad = adresse.text;
                                      String date = dateDembauche.text;

                                      if (_imageBytes == null ||
                                          n.isEmpty ||
                                          p.isEmpty ||
                                          selectedValue == null ||
                                          num.isEmpty ||
                                          m.isEmpty ||
                                          ad.isEmpty ||
                                          date.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Veuillez remplir tous le champs.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        // print('object');
                                      } else {
                                        // on cree un repertoire pour stocker l'image s'il n'existe pas encore

                                        // final directory =
                                        //     await getApplicationDocumentsDirectory();
                                        // final imageDirectory =
                                        //     Directory('${directory.path}/images_employe');

                                        // if (!imageDirectory.existsSync()) {
                                        //   imageDirectory.createSync(recursive: true);
                                        // }

                                        // // on genere un nom de fichier unique pour l'image

                                        // final uniqueFichier =
                                        //     DateTime.now().microsecondsSinceEpoch.toString() +
                                        //         extension;

                                        // final imagePath =
                                        //     '${imageDirectory.path}/$uniqueFichier';
                                        //   // print('rrr');

                                        Employe employe = Employe(
                                            id: null,
                                            nom: n,
                                            prenom: p,
                                            posteId: posteInt,
                                            numero: num,
                                            mail: m,
                                            adresse: ad,
                                            dateDembauche: date,
                                            imageUrl: _imageBytes);

                                        int employeId = await sqliteDatabase
                                            .createEmploye(employe);

                                        if (employeId != -1) {
                                          afficherAlerteEnregistrementReussi();
                                          nom.clear();

                                          prenom.clear();
                                          // String pid = posteId.text;
                                          // int posteInt = int.parse(selectedValue!);
                                          numero.clear();
                                          mail.clear();
                                          adresse.clear();
                                          dateDembauche.clear();
                                          setState(() {
                                            _imageBytes = null;
                                          });
                                        }
                                      }
                                    } catch (e) {
                                      print('erreur $e');
                                    }
                                  },
                                  child: const Text('Ajoutez'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
