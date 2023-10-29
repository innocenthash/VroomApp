import 'package:flutter/material.dart';
import 'package:viewvroom/options/options_couleurs.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final List<String> nomDesPages;
  final Function(int valeur) function;
  const BottomNavigationBarWidget(
      {super.key,
      required this.nomDesPages,
      required this.function});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int index = 0;
  Color oneColor = OptionsCouleurs.oneColor;
  Color twoColor = OptionsCouleurs.twoColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      
      height: 130,
      decoration: BoxDecoration(
      //  color: Colors.black,
        // borderRadius: BorderRadius.all(Radius.circular(16)),
        // border: const Border(
        //   top: BorderSide(
        //     color: Colors.transparent,
        //     style: BorderStyle.none,width: 0
        //   ),
        // ),
        boxShadow: [
          BoxShadow(
            color: oneColor,
            spreadRadius: 2,
            //  blurRadius: 5,
            //  offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
       
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          
        ),
        // borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          selectedItemColor: twoColor,
          
          // unselectedItemColor: Colors.black45,
          onTap: (variableInt) {
            setState(() {
              index = variableInt;
              widget.function(variableInt);
            });
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              label: widget.nomDesPages[0],
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: widget.nomDesPages[1],
              icon: Icon(Icons.add_circle, size: 50),
            ),
            BottomNavigationBarItem(
              label: widget.nomDesPages[2],
              icon: Icon(Icons.supervised_user_circle),
            ),
          ],
        ),
      ),
    );
  }
}
