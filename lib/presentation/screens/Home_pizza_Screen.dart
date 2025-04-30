
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
    "assets/images/carrousel_part3.jpg",
    "assets/images/paloozap.jpg",
    "assets/images/pizzapalozza.png",
    "assets/images/imagee.png",
    "assets/images/imaage.png",
  ];
  int currentSlideIndex = 0;
  bool _showTopWidgets = true; // Controls visibility of carousel, search, and filters
  late ScrollController _scrollController; // ScrollController for detecting scroll events

  @override
  void initState() {
    super.initState();
    pizzaController.getAllpizzas();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener); // Add scroll listener
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener); // Remove scroll listener
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll listener to hide/show top widgets
  void _scrollListener() {
    if (_scrollController.offset > 100 && _showTopWidgets) {
      setState(() {
        _showTopWidgets = false; // Hide top widgets when scrolling up
      });
    } else if (_scrollController.offset <= 100 && !_showTopWidgets) {
      setState(() {
        _showTopWidgets = true; // Show top widgets when scrolling down
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFede8d0),
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Search Input (conditionally visible)
          if (_showTopWidgets)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SearchInput(
                controller: _searchController,
                onChanged: pizzaController.searchPizzas,
              ),
            ),
          if (_showTopWidgets) const SizedBox(height: 20),

          // Carousel Slider (conditionally visible)
          if (_showTopWidgets)
            CarouselSlider(
              options: CarouselOptions(
                height: 210.0, 
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentSlideIndex = index;
                  });
                },
                viewportFraction: 0.8, // Adjust for more cards visible
                aspectRatio: 16 / 9, // Standard aspect ratio
              ),
              items: carouselImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          if (_showTopWidgets) const SizedBox(height: 10),

          // Carousel Dots (conditionally visible)
          if (_showTopWidgets)
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
                          ? const Color(0xFF790303)
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          if (_showTopWidgets) const SizedBox(height: 20),

          // Filter Buttons (conditionally visible)
          if (_showTopWidgets)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: GetBuilder<PizzaController>(
                builder: (controller) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterButton(
                          label: '🍽️ All',
                          isSelected: controller.selectedType == 'All',
                          onPressed: () {
                            controller.filterPizzasByType('All');
                          },
                        ),
                        const SizedBox(width: 10),
                        FilterButton(
                          label: '🫓 Full Pizza',
                          isSelected: controller.selectedType == 'Full Pizza',
                          onPressed: () {
                            controller.filterPizzasByType('Full Pizza');
                          },
                        ),
                        const SizedBox(width: 10),
                        FilterButton(
                          label: '🍕 Slice',
                          isSelected: controller.selectedType == 'Slice',
                          onPressed: () {
                            controller.filterPizzasByType('Slice');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 20),

          // GridView of Pizzas
          Expanded(
            child: GetBuilder<PizzaController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredPizzas.isEmpty) {
                  return const Center(
                    child: Text(
                      "No pizzas available!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  controller: _scrollController, 
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.filteredPizzas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return PizzaItem(pizza: controller.filteredPizzas[index]);
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

// Custom Filter Button Widget
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF790303) : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}