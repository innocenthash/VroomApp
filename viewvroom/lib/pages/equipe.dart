import 'package:flutter/material.dart';
import 'package:viewvroom/options/image_caroussel.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/pages/employer/employer.dart';
import 'package:viewvroom/pages/poste/create_poste.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glassmorphism/glassmorphism.dart';
class Equipe extends StatefulWidget {
  const Equipe({super.key});

  @override
  State<Equipe> createState() => _EquipeState();
}

class _EquipeState extends State<Equipe> {
  Color three = OptionsCouleurs.three;
  Color white = OptionsCouleurs.primaryColor;

  Color blueF = OptionsCouleurs.blueF ;
  CarouselController buttonCarouselController = CarouselController();
  List<Map<String, dynamic>> img = ImageCaroussel.imageCarosseul;

  @override
  Widget build(BuildContext context) {
    // ButtonStyle style = ElevatedButton.styleFrom();
    // Color buttonC = style.backgroundColor;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                'Gerez vos personnel',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: three,
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
                        decoration: BoxDecoration(color: Colors.transparent,
                        border: Border.all(color: Colors.white,width: 10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 20 , 
                          
                            color:  Color.fromARGB(221, 212, 212, 212), 
    
                           
    
                            spreadRadius: 20
                          )
                        ] , borderRadius: BorderRadius.circular(30)
                        ),
                        child: Image.asset(i['image']));
                  },
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                 autoPlayCurve: Curves.linearToEaseOut,
              //  autoPlayInterval: Duration(milliseconds: 1),
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                aspectRatio: 2.0,
                initialPage: 2,
                autoPlayAnimationDuration: Duration(milliseconds: 200),
                // scrollDirection: Axis.horizontal,
              ),
            ),
            // OutlinedButton(
            //   onPressed: () => buttonCarouselController.previousPage(
            //       duration: Duration(milliseconds: 300), curve: Curves.linear),
            //   child: Text('→'),
            // ),
            // OutlinedButton(
            //   onPressed: () => buttonCarouselController.previousPage(
            //       duration: Duration(milliseconds: 300), curve: Curves.linear),
            //   child: Text('→'),
            // ),
            // OutlinedButton(
            //   onPressed: () => buttonCarouselController.nextPage(
            //       duration: Duration(milliseconds: 300), curve: Curves.linear),
            //   child: Text('→'),
            // ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 20, right: 50, left: 50),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePoste()));
                },
                icon: Icon(Icons.work),
                label: Text('Poste'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: three,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: white, style: BorderStyle.solid, width: 2)),
                ),
                // style: ButtonStyle(
                //     backgroundColor: ElevatedButton.styleFrom(backgroundColor: ),
                //   side: MaterialStatePropertyAll(
                //     BorderSide(
                //       color: three,
                //       style: BorderStyle.solid,
                //       width: 3
                //     ),
                //   ),
                //   // minimumSize: MaterialStatePropertyAll(Size(100 , 10)),
                //   shape: MaterialStatePropertyAll(
                //     RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
    
                //     ),
                //   ),
                // ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 20, right: 50, left: 50),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder:(context)=>const CreatePoste()) ) ;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Employer()));
                },
                icon: Icon(Icons.person_add),
                label: Text('Employer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: three,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: white, style: BorderStyle.solid, width: 2)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 20, right: 50, left: 50, bottom: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.folder_shared_rounded),
                label: Text('Fiche de renseignement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: three,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: white, style: BorderStyle.solid, width: 2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
