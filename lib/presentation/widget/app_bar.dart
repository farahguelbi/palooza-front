import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(120.0), // Hauteur ajustée
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
            backgroundColor: const Color(0xFFede8d0), 

      elevation: 0, 
      automaticallyImplyLeading: true, 
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    fontFamily: 'Lobster', 
                  ),
                ),
                SizedBox(height: 3), 
               Padding(
      padding: EdgeInsets.only(left: 40.0), 
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
            const CircleAvatar(
              radius: 38, 
              backgroundImage: AssetImage('assets/images/pizza logo.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
