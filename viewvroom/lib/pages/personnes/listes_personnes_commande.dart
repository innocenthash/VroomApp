import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:viewvroom/models/personne.dart';
import 'package:viewvroom/options/options_couleurs.dart';

class ListesPersonnesCommande extends StatefulWidget {
  final List<Personne> listePersonnes;
  const ListesPersonnesCommande({super.key, required this.listePersonnes});

  @override
  State<ListesPersonnesCommande> createState() =>
      _ListesPersonnesCommandeState();
}

class _ListesPersonnesCommandeState extends State<ListesPersonnesCommande> {
  Color three = OptionsCouleurs.three;
  Color oneColor = OptionsCouleurs.oneColor;
  Color fort = OptionsCouleurs.fort;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes clients'),
        backgroundColor: three,
        elevation: 0,
      ),
      // backgroundColor:oneColor ,
      body: Column(
        children: [
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: fort,
            ),
            child: const Center(
              child: Text(
                'Leurs Informations',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:FontWeight.w900
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
            height: 400,
            // color: Colors.amber,
            child: ListView.builder(
                itemCount: widget.listePersonnes.length,
                itemBuilder: (context, index) {
                  return FlipCard(
                    fill: Fill.fillBack,
                    side: CardSide.FRONT,
                    direction: FlipDirection.VERTICAL,
                    front: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.amber,),
                        height: 100,
                        child: Center(
                          child: ListTile(
                            leading: Text(
                                'Nom :${widget.listePersonnes[index].nom} | Prenom : ${widget.listePersonnes[index].prenom}'),
                            // title: Text(
                            //     'Adresse : ${widget.listePersonnes[index].adresse} | Telephone : ${widget.listePersonnes[index].telephone}'),
                            // subtitle: Text(
                            //     'Avance :${widget.listePersonnes[index].argentAvance} | Nombre : ${widget.listePersonnes[index].commande} | Recuperation : ${widget.listePersonnes[index].dateRecuperation}'),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ),
                      ),
                    ),
                    back: Container(
                      // height: 300,
                      // width: double.maxFinite,
                      // color: Colors.amber,
                      child: Card(
                        color: fort,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.amber,),
                          height: 100,
                          child: Center(
                            child: ListTile(
                              leading: Text(
                                // 'Nom :${widget.listePersonnes[index].nom} | Prenom : ${widget.listePersonnes[index].prenom}'
                                'Adresse : ${widget.listePersonnes[index].adresse} | Telephone : ${widget.listePersonnes[index].telephone}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              // title: 
                              subtitle: Text(
                                'Avance :${widget.listePersonnes[index].argentAvance} | Nombre : ${widget.listePersonnes[index].commande} | Recuperation : ${widget.listePersonnes[index].dateRecuperation}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: const Icon(Icons.arrow_left),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
