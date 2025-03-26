import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // Required for PreferredSizeWidget

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(120.0), // Hauteur ajustée
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFB17C46), // Couleur de fond marron
      elevation: 0, // Suppression de l'ombre
      automaticallyImplyLeading: true, // Affiche le bouton de menu par défaut
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Titre et sous-titre alignés à gauche
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Pizza Palooza',
                  style: TextStyle(
                    color: Color(0xFF790303),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lobster', // Police personnalisée
                  ),
                ),
                SizedBox(height: 3), // Espacement entre le titre et le sous-titre
               Padding(
      padding: EdgeInsets.only(left: 40.0), // Décale le texte vers la droite
      child: Text(
        'Order your favourite pizza',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Yesteryear',
          fontSize: 20,
        ),
        )
        )
              ],
            ),
            // Image du logo
            const CircleAvatar(
              radius: 38, // Taille ajustée pour correspondre au design
              backgroundImage: AssetImage('assets/images/pizza logo.jpg'), // Chemin de l'image
            ),
          ],
        ),
      ),
    );
  }
}
