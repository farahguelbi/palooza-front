
import 'package:flutter/material.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
import 'package:front/presentation/screens/pizza_details_screen.dart'; 
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late WishlistController _wishlistController;
  late String currentUserId;
  bool isLoading = true;
  String errorMessage = '';
  List<Pizza> wishlistPizzas = [];

  @override
  void initState() {
    super.initState();
    //sert à exécuter une fonction après que le cadre  de l'interface utilisateur soit complètement construit.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
      _loadWishlist();
    });
  }

  void _initializeControllers() {
    _wishlistController = Get.find<WishlistController>();
    final authController = Get.find<AuthenticationController>();
    currentUserId = authController.currentUser.id!;
  }

  Future<void> _loadWishlist() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final success = await _wishlistController.getWishlistByUserId(currentUserId);
    if (success) {
      setState(() {
        wishlistPizzas = List.from(_wishlistController.userWishlist?.pizzas ?? []);
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = 'Failed to load wishlist';
        isLoading = false;
      });
    }
  }

  Future<void> _removePizza(int index, String pizzaId) async {
    setState(() {
      wishlistPizzas.removeAt(index);
    });

    final success = await _wishlistController.removePizzaFromWishlist(currentUserId, pizzaId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pizza removed from wishlist')),
      );
    } else {
      setState(() {
        // remet pizza au meme index ! 
        wishlistPizzas.insert(index, _wishlistController.userWishlist!.pizzas[index]);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove pizza from wishlist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFede8d0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFede8d0),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF790303)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: const Text(
              'Your Wishlist',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF790303),
                fontFamily: 'Yellowtail',
              ),
            ),
          ),
                      //pour prendre tout espace restant 
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(fontSize: 18, color: Color(0xFF790303)),
                        ),
                      )
                    : wishlistPizzas.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: wishlistPizzas.length,

                            itemBuilder: (context, index) {
                              //recupere le pizza qui se trouve a l'index 
                              final pizza = wishlistPizzas[index];
                              return Dismissible(
                                key: Key(pizza!.id),
                                //glissement de droit vers gauche 
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {
                                  await _removePizza(index, pizza.id);
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  color: const Color(0xFF790303).withOpacity(0.7),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PizzaDetailsScreen(pizza: pizza),
                                      ),
                                    );
                                  },
                                  child: WishlistCard(
                                    title: pizza.name!,
                                    description: pizza.reference!,
                                    price: pizza.sizes.medium!,
                                    imageUrl: pizza.image,
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/animation/heart_animation1.json',
                                  width: 200,
                                  height: 200,
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'No products in your wishlist yet!',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                    fontFamily: "Italianno",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

class WishlistCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  const WishlistCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFD9D9D9).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            //image arrondis 
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
              //remplir zone d'image sans deformation 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),
              ),
            ),
            const SizedBox(width: 16.0),
            //pour prendre tout espace restant 
            Expanded(
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Italianno',
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "Lobster",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}