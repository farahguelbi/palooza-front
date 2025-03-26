import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/pizza_controller.dart';
import 'package:front/presentation/screens/edit_profile_screen.dart';
import 'package:front/presentation/screens/login_page.dart';
import 'package:front/presentation/widget/app_bar.dart';
import 'package:front/presentation/widget/drawer_widget.dart';
import 'package:front/presentation/widget/pizza_item.dart';
import 'package:front/presentation/widget/search_input.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final PizzaController pizzaController = Get.put(PizzaController());
    final TextEditingController _searchController = TextEditingController();

     final List<String> carouselImages = [
    "assets/images/carrousel_part1.jpg",
    "assets/images/carrousel_part2.jpg",
    "assets/images/carrousel_part3.jpg"
  ];
  int currentSlideIndex = 0;
@override
  void initState() {
    super.initState();
    pizzaController.getAllpizzas(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      // AppBar en haut
      appBar:  const CustomAppBar(),
      // Drawer pour la navigation
      drawer: const CustomDrawer(),

         body: Column(
          
         
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
                Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), 
 child: SearchInput(
              controller: _searchController,
              onChanged: pizzaController.searchPizzas, // Calls search function
            ),            
          ),
          const SizedBox(height: 20,),
         // Carousel slider
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0, // Height of the carousel
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  currentSlideIndex = index; // Update the current slide index
                });
              },
            ),
            items: carouselImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          // Dots as indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  currentSlideIndex = entry.key;
                }),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentSlideIndex == entry.key
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
 Expanded(
            child: GetBuilder<PizzaController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(), 
                  );
                }

                if (controller.allPizzas.isEmpty) {
                  return const Center(
                    child: Text(
                      "No pizzas available!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.allPizzas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre d'éléments par ligne
                    crossAxisSpacing: 10, // Espacement horizontal
                    mainAxisSpacing: 10, // Espacement vertical
                    childAspectRatio: 0.75, // Proportion largeur/hauteur
                  ),
                  itemBuilder: (context, index) {
                    return PizzaItem(pizza: controller.allPizzas[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}