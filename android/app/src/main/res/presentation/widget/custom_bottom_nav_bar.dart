import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onTap;
  final int currentIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent, // For transparent effect above
      color: const Color(0xFF800000), 
      buttonBackgroundColor: const Color(0xFF800000), 
      height: 60,
      items: const [
        Icon(Icons.home, size: 30, color: Colors.amber), // Home icon
        Icon(Icons.favorite, size: 30, color: Colors.amber), // Heart icon
        Icon(Icons.add, size: 30, color: Colors.amber), // Add icon
        Icon(Icons.shopping_cart, size: 30, color: Colors.amber), // Cart icon
      ],
      index: widget.currentIndex,
      onTap: widget.onTap,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
    );
  }
}
