import 'package:flutter/material.dart';
import 'package:viewvroom/models/voiture.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/control_voitures.dart';
import 'package:viewvroom/pages/equipe.dart';
import 'package:viewvroom/pages/listes_voitures.dart';
import 'package:viewvroom/pages/voitures/create_voiture.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';
import 'package:viewvroom/widgets/bottom_navigation_bar_widget.dart';

class PrincipalePage extends StatefulWidget {
  const PrincipalePage({super.key});

  @override
  State<PrincipalePage> createState() => _PrincipalePageState();
}

class _PrincipalePageState extends State<PrincipalePage> {
  final sqliteDatabase = SqliteDatabase();
  List<String> nomDesPages = ['Accueil', 'Ajouter', "Equipe"];
  int currentPage = 0;

  List<Voiture> rechercheVoiture = [];
  // void recupCurrentPage(valeur) {
  //   setState(() {
  //     currentPage = valeur;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Color bottom = OptionsCouleurs.tertiaryColor;
    Color bgColor = OptionsCouleurs.bgColor;
    Color oneColor = OptionsCouleurs.oneColor;
    Color five = OptionsCouleurs.five;
    Color bleuFonce = Theme.of(context).primaryColor ;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8 , right:8  , left:1 ),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: const Text(
                    'ViewVroom',
                    style: TextStyle(
                        color: Color.fromRGBO(26, 99, 255, 0.8)  ,  fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              TextField(
                onChanged: (query) async {
                  List<Voiture> rechercheVoitureR =
                      await sqliteDatabase.rechercheVoiture(query);

                  setState(() {
                    if (query.isEmpty) {
                         rechercheVoiture = [];
                    }else {
                         rechercheVoiture = rechercheVoitureR;
                    }
                    
                     
                  });
                  // print(rechercheVoitureR[0].description);
                },
                decoration: const InputDecoration(
                    hintText: 'Rechercher...', prefixIcon: Icon(Icons.search)),
              ),
            ],
          ),
          // bottom:PreferredSize(preferredSize:Size(20, 500), child: child)  ,backgroundColor: five,
          // actions: const [
          //   TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Rechercher...',
          //       prefixIcon: Icon(Icons.search)
          //     ),
          //   ),
          // ],
          toolbarHeight: 80,
          elevation: 0,
          // backgroundColor: Colors.transparent,
        ),
        // extendBodyBehindAppBar: true,
        // backgroundColor: ,
        body: Stack(
          children: [
            // Container(
            //   //  color: Color.fromARGB(255, 255, 255, 255),
            //   height: double.infinity,
            //   // child: Column(children: [Container()]),
            // ),
            Positioned(
              // AppBar().preferredSize.height
              top: 10,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  color: oneColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    // bottomLeft: Radius.circular(20),
                    // bottomRight: Radius.circular(20),
                  ),
                ),
                child: currentPage == 1
                    ? const CreateVoiture()
                    : currentPage == 0
                        ? ListesVoitures(rechercheVoiture: rechercheVoiture)
                        : const Equipe(),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        bottomNavigationBar: BottomNavigationBarWidget(
            function: (valeur) {
              setState(() {
                currentPage = valeur;
              });
            },
            nomDesPages: nomDesPages));
  }
}
