import 'package:flutter/material.dart';
import 'package:front/presentation/screens/AddScreen.dart';
import 'package:front/presentation/screens/AddScreen.dart';
import 'package:front/presentation/screens/CartScreen.dart';
import 'package:front/presentation/screens/Home_pizza_Screen.dart';
import 'package:front/presentation/screens/whishlist_screen.dart';
import 'package:front/presentation/widget/custom_bottom_nav_bar.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // To keep track of the selected tab

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    HomeScreen(),
    WishlistPage(),
    AddScreen(),
    CartScreen(),
  ];
  void _onTap(int index) {
        print('page :$_currentIndex');
    setState(() {
      _currentIndex = index; 

    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),

      

      // Contenu principal
    body: _pages[_currentIndex], // Display the selected page

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
        
    
  
    );
    
  }
}

