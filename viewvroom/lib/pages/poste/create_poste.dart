import 'package:flutter/material.dart';
import 'package:viewvroom/models/poste.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/poste/affiche_poste.dart';
import 'package:viewvroom/sqlite_database/sqlite_database.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CreatePoste extends StatefulWidget {
  const CreatePoste({super.key});

  @override
  State<CreatePoste> createState() => _CreatePosteState();
}

class _CreatePosteState extends State<CreatePoste> {
  final sqliteDatabase = SqliteDatabase();
  final TextEditingController asa = TextEditingController();
  Color three = OptionsCouleurs.three;
  Color oneColor = OptionsCouleurs.oneColor;
    Color blueF = OptionsCouleurs.blueF;
  void afficherAlerteEnregistrementReussi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Création de Poste'),
          content: Text('Poste créé avec succès.'),
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
      appBar: AppBar(
        title: const Text('Les Postes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AffichePoste()));
              },
              icon: Icon(Icons.assignment_ind_rounded))
        ],
        backgroundColor: three,
        elevation: 0,
      ),
      backgroundColor: oneColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GlassmorphicContainer(
            margin: EdgeInsets.all(15),
            width: double.infinity, // Largeur du conteneur
            height: 100, // Hauteur du conteneur
            borderRadius: 50, // Rayon des coins
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
                'Enregistrement de poste',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: three,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30), topRight: Radius.circular(30))),
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
              
                margin: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                     
                      width: double.infinity,
                      child: Icon(
                        Icons.star,
                        shadows: [
                          Shadow(color: Colors.black , blurRadius: 2)
                        ],size: 50,color: blueF,
          
                       
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 255, 255, 255))),
                      margin: const EdgeInsets.only(
                          top: 20, left: 50, right: 50, bottom: 30),
                      child: TextField(
                        controller: asa,
                        decoration: InputDecoration(
                          hintText: 'Vous pouvez ajouter le poste',
                          labelText: 'Poste',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 70,
                        margin:
                            const EdgeInsets.only(top: 0, left: 50, right: 50),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            side: const MaterialStatePropertyAll(
                              BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  style: BorderStyle.solid,
                                  width: 3),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              String postes = asa.text;
                              print(postes);
                              if (postes.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Veuillez remplir le champ.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                Poste poste = Poste(id: null, poste: postes);
                                int p = await sqliteDatabase.createPoste(poste);
          
                                if (p != -1) {
                                  afficherAlerteEnregistrementReussi();
          
                                  asa.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Erreur lors de l\'enregistrement de cette poste.'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Erreur lors de la creation.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text('Créez'),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
