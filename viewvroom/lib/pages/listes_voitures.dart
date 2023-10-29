import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/image_caroussel.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/voir_plus_voiture.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';

class ListesVoitures extends StatefulWidget {
  final List<Voiture> rechercheVoiture;
  const ListesVoitures({super.key, required this.rechercheVoiture});

  @override
  State<ListesVoitures> createState() => _ListesVoituresState();
}

class _ListesVoituresState extends State<ListesVoitures> {
  CarouselController buttonCarouselController = CarouselController();

  Color twoColor = OptionsCouleurs.twoColor;
  Color primaryColor = OptionsCouleurs.primaryColor;
  final Color three = OptionsCouleurs.three;
  final sqliteDatabase = SqliteDatabase();
  List<Voiture> listesVoitures = [];
  List<Map<String, dynamic>> img = ImageCaroussel.imageCarosseulMenu;

  bool afficheImagesPermission = false;
  @override
  void initState() {
    super.initState();
    _afficheVoiture();
    // listesVoitures;
  }

  Future<void> _afficheVoiture() async {
    final afficheVoitures = await sqliteDatabase.getVoitures();
    setState(() {
      listesVoitures = afficheVoitures;
      // afficheImagesPermission = afficheImagesPermission;
    });
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    //   final afficheVoitures = await sqliteDatabase.getVoitures();
    //   setState(() {
    //     listesVoitures = afficheVoitures;
    //     afficheImagesPermission = afficheImagesPermission;
    //   });
    // } else if (status.isDenied) {
    //   // L'utilisateur a refusé les autorisations, vous pouvez afficher un message d'explication.
    //   _showPermissionDeniedDialog();

    //   afficheImagesPermission = true;
    //   final afficheVoitures = await sqliteDatabase.getVoitures();
    //   setState(() {
    //     listesVoitures = afficheVoitures;
    //     // afficheImagesPermission = afficheImagesPermission;
    //   });
    // } else if (status.isPermanentlyDenied) {
    //   // L'utilisateur a définitivement refusé les autorisations, vous pouvez rediriger vers les paramètres.
    //   _openAppSettings();
    //   // afficheImagesPermission = false;
    // }
  }
  // // Future<void> _afficheVoiture() async {
  // //   final afficheVoitures = await sqliteDatabase.getVoitures();
  // //   setState(() {
  // //     listesVoitures = afficheVoitures;
  // //   });
  // }

  Widget image(Voiture voiture) {
    // if (afficheImagesPermission == false) {
    if (voiture.imageUrl != null) {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amber,
        ),
        child: ClipOval(
          child: Image.memory(
            voiture.imageUrl!,
            fit: BoxFit.cover,
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
    //     // color: Colors.amber,
    //     height: 50,
    //     width: 50,
    //     child: ClipOval(
    //       child: Image.asset(
    //         'assets/images_autos/loader1.gif',
    //         fit: BoxFit.cover,
    //         width: 200,
    //         height: 200,
    //       ),
    //     ),
    //   );
    // }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Autorisations requises"),
          content: const Text(
              "L'accès au stockage est nécessaire pour charger les images."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _openAppSettings() {
    openAppSettings();
  }

  Color five = OptionsCouleurs.five;
  @override
  Widget build(BuildContext context) {
    Color bleuFonce = Theme.of(context).primaryColor;
    return widget.rechercheVoiture.isEmpty
        ? Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: bleuFonce,
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
                          'Liste de voitures en cours',
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
              CarouselSlider(
                // options: CarouselOptions(height: 400.0),
                items: img.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(color: Colors.white, width: 10),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Color.fromARGB(221, 212, 212, 212),
                                    spreadRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.asset(i['image']));
                    },
                  );
                }).toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayCurve: Curves.linearToEaseOut,
                  //  autoPlayInterval: Duration(milliseconds: 1),
                  enlargeCenterPage: true,
                  viewportFraction: 0.3,
                  aspectRatio: 2.0,
                  initialPage: 2,
                  autoPlayAnimationDuration: Duration(milliseconds: 200),
                  // scrollDirection: Axis.horizontal,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  // height: 500,
                  // width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),

                  // FutureBuilder(future: sqliteDatabase.getVoitures(), builder:(context , snapshot){
                  //   if(!sna)
                  // },) ,

                  child: listesVoitures.isNotEmpty
                      ? ListView.builder(
                          itemCount: listesVoitures.length,
                          itemBuilder: (context, index) {
                            Voiture voiture = listesVoitures[index];
                            return Card(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      child: Container(
                                        height: 120.0,
                                        child: Center(
                                          child: ListTile(
                                            leading: image(voiture),
                                            title: Text('Nom : ${voiture.nom}'),
                                            subtitle: Text(
                                                'Marque : ${voiture.marque}'),
                                            trailing:
                                                const Icon(Icons.arrow_forward),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VoirPlusVoiture(
                                                            // function :(newListesVoitures ){
                                                            //     listesVoitures = newListesVoitures ;
                                                            // } ,
                                                            afficheVoiture:
                                                                _afficheVoiture,
                                                            listesVoitures:
                                                                listesVoitures,
                                                            afficheImagesPermission:
                                                                afficheImagesPermission,
                                                            voiture: voiture)),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: const Text('La liste de voitures est vide ')),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  // height: 500,
                  // width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),

                  // FutureBuilder(future: sqliteDatabase.getVoitures(), builder:(context , snapshot){
                  //   if(!sna)
                  // },) ,

                  child: listesVoitures.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.rechercheVoiture.length,
                          itemBuilder: (context, index) {
                            Voiture voiture = widget.rechercheVoiture[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 120.0,
                                  child: Center(
                                    child: ListTile(
                                      leading: image(voiture),
                                      title: Text('Nom : ${voiture.nom}'),
                                      subtitle:
                                          Text('Marque : ${voiture.marque}'),
                                      trailing: const Icon(Icons.arrow_forward),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VoirPlusVoiture(
                                                      // function :(newListesVoitures ){
                                                      //     listesVoitures = newListesVoitures ;
                                                      // } ,
                                                      afficheVoiture:
                                                          _afficheVoiture,
                                                      listesVoitures:
                                                          listesVoitures,
                                                      afficheImagesPermission:
                                                          afficheImagesPermission,
                                                      voiture: voiture)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: const Text('La liste de voitures est vide ')),
                ),
              ),
            ],
          );
  }
}
