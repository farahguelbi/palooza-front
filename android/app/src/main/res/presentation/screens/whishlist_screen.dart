// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // // // import 'package:front/presentation/controller/wishlist_controller.dart';
// // // // // // import 'package:get/get.dart';

// // // // // // class WishlistScreen extends StatelessWidget {
// // // // // //   const WishlistScreen({Key? key}) : super(key: key);

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     // Initialize controllers
// // // // // //     final WishlistController wishlistController = Get.put(WishlistController());
// // // // // //     final AuthenticationController authController = Get.find();

// // // // // //     // Get the current user's ID
// // // // // //     final currentUser = authController.currentUser;
// // // // // //     final userId = currentUser.id ?? '';

// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('${currentUser.firstName}\'s Wishlist'),
// // // // // //         centerTitle: true,
// // // // // //         backgroundColor: const Color(0xFF790303),
// // // // // //       ),
// // // // // //       backgroundColor: const Color(0xFFB17C46),
// // // // // //       body: GetBuilder<WishlistController>(
// // // // // //         initState: (_) {
// // // // // //           // Fetch the wishlist when the screen initializes
// // // // // //           wishlistController.fetchWishlist(userId);
// // // // // //         },
// // // // // //         builder: (controller) {
// // // // // //           // Loading state
// // // // // //           if (controller.isLoading) {
// // // // // //             return const Center(child: CircularProgressIndicator());
// // // // // //           }

// // // // // //           // Error state
// // // // // //           if (controller.errorMessage.isNotEmpty) {
// // // // // //             return Center(
// // // // // //               child: Text(
// // // // // //                 controller.errorMessage,
// // // // // //                 style: const TextStyle(color: Colors.red, fontSize: 16),
// // // // // //               ),
// // // // // //             );
// // // // // //           }

// // // // // //           final wishlist = controller.currentWishlist;

// // // // // //           // Empty state
// // // // // //           if (wishlist == null || wishlist.pizzaIds.isEmpty) {
// // // // // //             return Center(
// // // // // //               child: Column(
// // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                 children: [
// // // // // //                   Image.asset(
// // // // // //                     'assets/images/empty_wishlist.png', // Replace with your empty state image
// // // // // //                     height: 150,
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 16),
// // // // // //                   const Text(
// // // // // //                     'Your wishlist is empty!',
// // // // // //                     style: TextStyle(fontSize: 18, color: Colors.white),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 8),
// // // // // //                   const Text(
// // // // // //                     'Add your favorite pizzas to the wishlist.',
// // // // // //                     style: TextStyle(fontSize: 14, color: Colors.white70),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             );
// // // // // //           }

// // // // // //           // List of wishlist items
// // // // // //           return ListView.builder(
// // // // // //             padding: const EdgeInsets.all(16.0),
// // // // // //             itemCount: wishlist.pizzaIds.length,
// // // // // //             itemBuilder: (context, index) {
// // // // // //               final pizzaId = wishlist.pizzaIds[index];

// // // // // //               return Card(
// // // // // //                 margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // // // //                 shape: RoundedRectangleBorder(
// // // // // //                   borderRadius: BorderRadius.circular(16.0),
// // // // // //                 ),
// // // // // //                 child: ListTile(
// // // // // //                   title: Text(
// // // // // //                     'Pizza ID: $pizzaId',
// // // // // //                     style: const TextStyle(
// // // // // //                       fontSize: 16,
// // // // // //                       fontWeight: FontWeight.bold,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   subtitle: const Text(
// // // // // //                     'Click the delete icon to remove from wishlist.',
// // // // // //                   ),
// // // // // //                   trailing: IconButton(
// // // // // //                     icon: const Icon(Icons.delete, color: Colors.red),
// // // // // //                     onPressed: () {
// // // // // //                       wishlistController.removePizzaFromWishlist(userId, pizzaId);
// // // // // //                       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                         SnackBar(
// // // // // //                           content: Text('Pizza $pizzaId removed from wishlist.'),
// // // // // //                         ),
// // // // // //                       );
// // // // // //                     },
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               );
// // // // // //             },
// // // // // //           );
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // import 'package:flutter/material.dart';

// // // // // class WishlistPage extends StatelessWidget {
// // // // //   final List<Map<String, dynamic>> wishlistItems;

// // // // //   const WishlistPage({Key? key, required this.wishlistItems}) : super(key: key);

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text(
// // // // //           'Wish List',
// // // // //           style: const TextStyle(
// // // // //             fontFamily: 'LilitaOne',
// // // // //             fontSize: 25,
// // // // //             color: Color.fromARGB(255, 13, 11, 11),
// // // // //           ),
// // // // //         ),
// // // // //         centerTitle: true,
// // // // //       ),
// // // // //       body: wishlistItems.isEmpty
// // // // //           ? Center(
// // // // //               child: Column(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 crossAxisAlignment: CrossAxisAlignment.center,
// // // // //                 children: [
// // // // //                   Image.asset(
// // // // //                     'assets/images/empty_wishlist.png',
// // // // //                     height: 100,
// // // // //                   ),
// // // // //                   const SizedBox(height: 10),
// // // // //                   const Text(
// // // // //                     'No favored product yet. What are you waiting for? Add one!',
// // // // //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // //                     textAlign: TextAlign.center,
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             )
// // // // //           : ListView.builder(
// // // // //               padding: const EdgeInsets.all(16.0),
// // // // //               itemCount: wishlistItems.length,
// // // // //               itemBuilder: (context, index) {
// // // // //                 final item = wishlistItems[index];
// // // // //                 return Dismissible(
// // // // //                   key: Key(item['id']),
// // // // //                   direction: DismissDirection.endToStart,
// // // // //                   onDismissed: (direction) {
// // // // //                     wishlistItems.removeAt(index);
// // // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // // //                       SnackBar(
// // // // //                         content:
// // // // //                             Text('${item['title']} removed from wishlist'),
// // // // //                       ),
// // // // //                     );
// // // // //                   },
// // // // //                   background: Container(
// // // // //                     alignment: Alignment.centerRight,
// // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.transparent,
// // // // //                       borderRadius: BorderRadius.circular(16.0),
// // // // //                     ),
// // // // //                     child: Row(
// // // // //                       mainAxisAlignment: MainAxisAlignment.end,
// // // // //                       children: [
// // // // //                         const Icon(
// // // // //                           Icons.delete,
// // // // //                           color: Color.fromARGB(255, 125, 33, 33),
// // // // //                           size: 30.0,
// // // // //                         ),
// // // // //                         const SizedBox(width: 10.0),
// // // // //                         const Text(
// // // // //                           'Remove',
// // // // //                           style: TextStyle(
// // // // //                             color: Color.fromARGB(255, 125, 33, 33),
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                             fontSize: 16.0,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                   child: WishlistCard(
// // // // //                     id: item['id'],
// // // // //                     title: item['title'],
// // // // //                     description: item['description'],
// // // // //                     price: item['price'],
// // // // //                     imageUrl: item['imageUrl'],
// // // // //                   ),
// // // // //                 );
// // // // //               },
// // // // //             ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class WishlistCard extends StatelessWidget {
// // // // //   final String id;
// // // // //   final String title;
// // // // //   final String description;
// // // // //   final String price;
// // // // //   final String imageUrl;

// // // // //   const WishlistCard({
// // // // //     Key? key,
// // // // //     required this.id,
// // // // //     required this.title,
// // // // //     required this.description,
// // // // //     required this.price,
// // // // //     required this.imageUrl,
// // // // //   }) : super(key: key);

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Card(
// // // // //       color: const Color(0xFFD9D9D9),
// // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
// // // // //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Row(
// // // // //           children: [
// // // // //             ClipRRect(
// // // // //               borderRadius: BorderRadius.circular(16.0),
// // // // //               child: Image.network(
// // // // //                 imageUrl,
// // // // //                 width: 80,
// // // // //                 height: 80,
// // // // //                 fit: BoxFit.cover,
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(width: 16.0),
// // // // //             Expanded(
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Text(
// // // // //                     title,
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 16.0,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 4.0),
// // // // //                   Text(
// // // // //                     description,
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 14.0,
// // // // //                       color: Colors.grey[700],
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 8.0),
// // // // //                   Text(
// // // // //                     '\$${price}',
// // // // //                     style: const TextStyle(
// // // // //                       fontSize: 16.0,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: Colors.green,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:front/domain/entities/pizza.dart';
// // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // import 'package:front/presentation/controller/wishlist_controller.dart';
// // // // import 'package:get/get.dart';

// // // // class WishlistPage extends StatefulWidget {
// // // //   const WishlistPage({super.key});

// // // //   @override
// // // //   State<WishlistPage> createState() => _WishlistPageState();
// // // // }

// // // // class _WishlistPageState extends State<WishlistPage> {
// // // //   late WishlistController _wishlistController;
// // // //   late PizzaController _pizzaController;
// // // //   late String currentUserId;
// // // //   bool isLoading = true;
// // // //   String errorMessage = '';
// // // //   List<Pizza?> wishlistPizzas = [];

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _wishlistController = Get.find();
// // // //     _pizzaController = Get.find();

// // // //     // Récupérer l'ID utilisateur à partir du contrôleur d'authentification
// // // //     final AuthenticationController authenticationController = Get.find();
// // // //     currentUserId = authenticationController.currentUser.id!;

// // // //     // Charger la wishlist et ses produits
// // // //     _loadWishlist();
// // // //   }

// // // //   void _loadWishlist() async {
// // // //     setState(() {
// // // //       isLoading = true;
// // // //       errorMessage = '';
// // // //     });

// // // //     // Récupérer la wishlist utilisateur
// // // //     final success = await _wishlistController.getWishlistByUserId(currentUserId);
// // // //     if (success) {
// // // //       // await _loadProducts(); // Charger les produits liés
// // // //     } else {
// // // //       setState(() {
// // // //         isLoading = false;
// // // //         errorMessage = 'Failed to load wishlist';
// // // //       });
// // // //     }
// // // //   }
// // // //   //  Future<void> _loadProducts() async {
// // // //   //   setState(() {
// // // //   //     isLoading = true;
// // // //   //   });

// // // //   //   final productIds = _wishlistController.userWishlist?.pizzaIds;

// // // //   //   if (productIds!.isEmpty) {
// // // //   //     setState(() {
// // // //   //       wishlistPizzas = []; // No products to display
// // // //   //       isLoading = false;
// // // //   //     });
// // // //   //     return;
// // // //   //   }

// // // //   //   List<Pizza?> fetchedProducts = [];

// // // //   //   for (String productId in productIds) {
// // // //   //     final success = await _pizzaController.getPizzatById(productId);
// // // //   //     print(success);
// // // //   //     if (success && _pizzaController.selectedPizza != null) {
// // // //   //       // Only add the product if it's valid
// // // //   //       fetchedProducts.add(_pizzaController.selectedPizza);
// // // //   //     } else {
// // // //   //       // Optionally, handle the case when product is not found
// // // //   //       print('Product with ID $productId not found.');
// // // //   //     }
// // // //   //   }

// // // //   //   setState(() {
// // // //   //     wishlistPizzas = fetchedProducts;
// // // //   //     isLoading = false;
// // // //   //   });
// // // //   // }


// // // // // Future<void> _loadProducts() async {
// // // // //   setState(() {
// // // // //     isLoading = true;
// // // // //   });

// // // // //   final pizzaIds = _wishlistController.userWishlist?.pizzaIds;

// // // // //   if (pizzaIds == null || pizzaIds.isEmpty) {
// // // // //     setState(() {
// // // // //       wishlistPizzas = []; // No data to display
// // // // //       isLoading = false;
// // // // //     });
// // // // //     return;
// // // // //   }

// // // // //   List<Pizza?> fetchedProducts = [];

// // // // //   for (String pizzaId in pizzaIds) {
// // // // //     final success = await _pizzaController.getPizzatById(pizzaId);
// // // // //     if (success && _pizzaController.selectedPizza != null) {
// // // // //       fetchedProducts.add(_pizzaController.selectedPizza);
// // // // //     }
// // // // //   }

// // // // //   setState(() {
// // // // //     wishlistPizzas = fetchedProducts;
// // // // //     isLoading = false;
// // // // //   });
// // // // // }

// // // // // //   Future<void> _loadProducts() async {
// // // // // //   setState(() {
// // // // // //     isLoading = true;
// // // // // //   });

// // // // // //   // Get the pizza objects directly from the wishlist
// // // // // //   final pizzaIds = _wishlistController.userWishlist?.pizzaIds;

// // // // // //   if (pizzaIds == null || pizzaIds.isEmpty) {
// // // // // //     // If there are no pizzas, set an empty list
// // // // // //     setState(() {
// // // // // //       wishlistPizzas = [];
// // // // // //       isLoading = false;
// // // // // //     });
// // // // // //     return;
// // // // // //   }

// // // // // //   // Since pizzaIds is already a List<Pizza>, assign it directly
// // // // // //   setState(() {
// // // // // //     wishlistPizzas = List.from(pizzaIds); // Copy the list to avoid mutation issues
// // // // // //     isLoading = false;
// // // // // //   });
// // // // // // }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Color(0xFFB17C46),
// // // //       appBar: AppBar(
// // // //         title: const Text(
// // // //           'Wishlist',
// // // //           style: TextStyle(
// // // //             fontFamily: 'LilitaOne',
// // // //             fontSize: 25,
// // // //             color: Colors.black,
// // // //           ),
          
// // // //         ),
// // // //         backgroundColor:const Color(0xFF790303) ,
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: isLoading
// // // //           ? const Center(child: CircularProgressIndicator())
// // // //           : errorMessage.isNotEmpty
// // // //               ? Center(
// // // //                   child: Text(
// // // //                     errorMessage,
// // // //                     style: const TextStyle(fontSize: 18, color: const Color(0xFF790303)),
// // // //                   ),
// // // //                 )
// // // //               : wishlistPizzas.isNotEmpty
// // // //                   ? ListView.builder(
// // // //                       padding: const EdgeInsets.all(16.0),
// // // //                       itemCount: wishlistPizzas.length,
// // // //                       itemBuilder: (context, index) {
// // // //                         final pizza = wishlistPizzas[index];
// // // //                         return pizza != null
// // // //                             ? Dismissible(
// // // //                                 key: Key(pizza.id),
// // // //                                 direction: DismissDirection.endToStart,
// // // //                                 onDismissed: (direction) async {
// // // //                                   await _wishlistController.removePizzaFromWishlist(
// // // //                                       currentUserId, pizza.id);

// // // //                                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                                     SnackBar(
// // // //                                       content: Text('${pizza.name} removed from wishlist'),
// // // //                                     ),
// // // //                                   );

// // // //                                   _loadWishlist(); // Recharger la wishlist
// // // //                                 },
// // // //                                 background: Container(
// // // //                                   alignment: Alignment.centerRight,
// // // //                                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // // //                                   color:const Color(0xFF790303),
// // // //                                   child: const Icon(Icons.delete, color: Colors.white),
// // // //                                 ),
// // // //                                 child: WishlistCard(
// // // //                                   title: pizza.name!,
// // // //                                   description: pizza.reference!,
// // // //                                   price: pizza.sizes.small!,
// // // //                                   imageUrl: pizza.image,
// // // //                                 ),
// // // //                               )
// // // //                             : const SizedBox.shrink();
// // // //                       },
// // // //                     )
// // // //                   : const Center(
// // // //                       child: Column(
// // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // //                         children: [
// // // //                           Icon(Icons.favorite_border, size: 100, color: Colors.grey),
// // // //                           SizedBox(height: 10),
// // // //                           Text(
// // // //                             'No products in your wishlist yet!',
// // // //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // //                             textAlign: TextAlign.center,
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //     );
// // // //   }
// // // // }

// // // // class WishlistCard extends StatelessWidget {
// // // //   final String title;
// // // //   final String description;
// // // //   final double price;
// // // //   final String imageUrl;

// // // //   const WishlistCard({
// // // //     super.key,
// // // //     required this.title,
// // // //     required this.description,
// // // //     required this.price,
// // // //     required this.imageUrl,
// // // //   });

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Card(
// // // //       color: const Color(0xFFF9F9F9),
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
// // // //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Row(
// // // //           children: [
// // // //             ClipRRect(
// // // //               borderRadius: BorderRadius.circular(16.0),
// // // //               child: Image.network(
// // // //                 imageUrl,
// // // //                 width: 80,
// // // //                 height: 80,
// // // //                 fit: BoxFit.cover,
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 16.0),
// // // //             Expanded(
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     title,
// // // //                     style: const TextStyle(
// // // //                       fontSize: 16.0,
// // // //                       fontWeight: FontWeight.bold,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 4.0),
// // // //                   Text(
// // // //                     description,
// // // //                     style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
// // // //                   ),
// // // //                   const SizedBox(height: 8.0),
// // // //                   Text(
// // // //                     '\$${price.toStringAsFixed(2)}',
// // // //                     style: const TextStyle(
// // // //                       fontSize: 16.0,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.black,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:front/domain/entities/pizza.dart';
// // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // import 'package:front/presentation/controller/wishlist_controller.dart';
// // // // import 'package:get/get.dart';

// // // // class WishlistPage extends StatefulWidget {
// // // //   const WishlistPage({super.key});

// // // //   @override
// // // //   State<WishlistPage> createState() => _WishlistPageState();
// // // // }

// // // // class _WishlistPageState extends State<WishlistPage> {
// // // //   late WishlistController _wishlistController;
// // // //   late String currentUserId;
// // // //   bool isLoading = true;
// // // //   String errorMessage = '';
// // // //   List<Pizza> wishlistPizzas = [];
// // // //   bool isDisposed = false; // Track widget disposal state

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //       _initializeControllers();
// // // //       _loadWishlist();
// // // //     });
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     isDisposed = true; // Mark the widget as disposed
// // // //     super.dispose();
// // // //   }

// // // //   void _initializeControllers() {
// // // //     _wishlistController = Get.find<WishlistController>();
// // // //     final authController = Get.find<AuthenticationController>();
// // // //     currentUserId = authController.currentUser.id!;
// // // //   }

// // // //   Future<void> _loadWishlist() async {
// // // //     if (isDisposed) return; // Prevent unnecessary actions if disposed

// // // //     setState(() {
// // // //       isLoading = true;
// // // //       errorMessage = '';
// // // //     });

// // // //     final success = await _wishlistController.getWishlistByUserId(currentUserId);
// // // //     if (success && !isDisposed) {
// // // //       setState(() {
// // // //         wishlistPizzas = List.from(_wishlistController.userWishlist?.pizzas ?? []);
// // // //         isLoading = false;
// // // //       });
// // // //     } else if (!isDisposed) {
// // // //       setState(() {
// // // //         errorMessage = 'Failed to load wishlist';
// // // //         isLoading = false;
// // // //       });
// // // //     }
// // // //   }

// // // //   Future<void> _removePizza(int index, String pizzaId) async {
// // // //     setState(() {
// // // //       wishlistPizzas.removeAt(index); // Remove locally for better UX
// // // //     });

// // // //     await _wishlistController.removePizzaFromWishlist(currentUserId, pizzaId);

// // // //     if (mounted) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Pizza removed from wishlist')),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFFB17C46),
// // // //       appBar: AppBar(
// // // //         title: const Text(
// // // //           'Wishlist',
// // // //           style: TextStyle(
// // // //             fontFamily: 'LilitaOne',
// // // //             fontSize: 25,
// // // //             color: Colors.black,
// // // //           ),
// // // //         ),
// // // //         backgroundColor: const Color(0xFF790303),
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: isLoading
// // // //           ? const Center(child: CircularProgressIndicator())
// // // //           : errorMessage.isNotEmpty
// // // //               ? Center(
// // // //                   child: Text(
// // // //                     errorMessage,
// // // //                     style: const TextStyle(fontSize: 18, color: Color(0xFF790303)),
// // // //                   ),
// // // //                 )
// // // //               : wishlistPizzas.isNotEmpty
// // // //                   ? ListView.builder(
// // // //                       padding: const EdgeInsets.all(16.0),
// // // //                       itemCount: wishlistPizzas.length,
// // // //                       itemBuilder: (context, index) {
// // // //                         final pizza = wishlistPizzas[index];
// // // //                         return Dismissible(
// // // //                           key: Key(pizza.id),
// // // //                           direction: DismissDirection.endToStart,
// // // //                           onDismissed: (direction) async {
// // // //                             await _removePizza(index, pizza.id); // Handle removal
// // // //                           },
// // // //                           background: Container(
// // // //                             alignment: Alignment.centerRight,
// // // //                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // // //                             color: const Color(0xFF790303),
// // // //                             child: const Icon(Icons.delete, color: Colors.white),
// // // //                           ),
// // // //                           child: WishlistCard(
// // // //                             title: pizza.name,
// // // //                             description: pizza.reference,
// // // //                             price: pizza.price,
// // // //                             imageUrl: pizza.image,
// // // //                           ),
// // // //                         );
// // // //                       },
// // // //                     )
// // // //                   : const Center(
// // // //                       child: Column(
// // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // //                         children: [
// // // //                           Icon(Icons.favorite_border, size: 100, color: Colors.grey),
// // // //                           SizedBox(height: 10),
// // // //                           Text(
// // // //                             'No products in your wishlist yet!',
// // // //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // //                             textAlign: TextAlign.center,
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:front/domain/entities/pizza.dart';
// // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // import 'package:front/presentation/controller/wishlist_controller.dart';
// // // import 'package:get/get.dart';

// // // class WishlistPage extends StatefulWidget {
// // //   const WishlistPage({super.key});

// // //   @override
// // //   State<WishlistPage> createState() => _WishlistPageState();
// // // }

// // // class _WishlistPageState extends State<WishlistPage> {
  
// // //   late WishlistController _wishlistController;
// // //   late String currentUserId;
// // //   bool isLoading = true;
// // //   String errorMessage = '';
// // //   List<Pizza> wishlistPizzas = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       _initializeControllers();
// // //       _loadWishlist();
// // //     });
// // //   }

// // //   void _initializeControllers() {
// // //     _wishlistController = Get.find<WishlistController>();
// // //     final authController = Get.find<AuthenticationController>();
// // //     currentUserId = authController.currentUser.id!;
// // //   }

// // //   Future<void> _loadWishlist() async {
// // //     setState(() {
// // //       isLoading = true;
// // //       errorMessage = '';
// // //     });

// // //     final success = await _wishlistController.getWishlistByUserId(currentUserId);
// // //     if (success) {
// // //       setState(() {
// // //         wishlistPizzas = List.from(_wishlistController.userWishlist?.pizzas ?? []);
// // //         isLoading = false;
// // //       });
// // //     } else {
// // //       setState(() {
// // //         errorMessage = 'Failed to load wishlist';
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }
  

  

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFB17C46),
// // //       appBar: AppBar(
// // //         title: const Text(
// // //           'Wishlist',
// // //           style: TextStyle(
// // //             fontFamily: 'LilitaOne',
// // //             fontSize: 25,
// // //             color: Colors.black,
// // //           ),
// // //         ),
// // //         backgroundColor: const Color(0xFF790303),
// // //         centerTitle: true,
// // //       ),
// // //       body: isLoading
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : errorMessage.isNotEmpty
// // //               ? Center(
// // //                   child: Text(
// // //                     errorMessage,
// // //                     style: const TextStyle(fontSize: 18, color: Color(0xFF790303)),
// // //                   ),
// // //                 )
// // //               : wishlistPizzas.isNotEmpty
// // //                   ? ListView.builder(
// // //                       padding: const EdgeInsets.all(16.0),
// // //                       itemCount: wishlistPizzas.length,
// // //                       itemBuilder: (context, index) {
// // //                         final pizza = wishlistPizzas[index];
// // //                         return Dismissible(
// // //                           key: Key(pizza!.id),
// // //                           direction: DismissDirection.endToStart,
// // //                           onDismissed: (direction) async {
// // //                             // setState(() {
// // //                             //   wishlistPizzas.removeAt(index);
// // //                             // });
// // //                             await _wishlistController.removePizzaFromWishlist(
// // //                               currentUserId, 
// // //                               pizza.id);

// // //                             // ignore: use_build_context_synchronously
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               SnackBar(
// // //                                 content: Text('${pizza.name} removed from wishlist'),
// // //                               ),
// // //                             );
// // //                           },
// // //                           background: Container(
// // //                             alignment: Alignment.centerRight,
// // //                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // //                             color: const Color(0xFF790303),
// // //                             child: const Icon(Icons.delete, color: Colors.white),
// // //                           ),
// // //                           child: WishlistCard(
// // //                             title: pizza.name!,
// // //                             description: pizza.reference!,
// // //                             price: pizza.sizes.medium!,
// // //                             imageUrl: pizza.image,
// // //                           ),
// // //                         );
// // //                       },
// // //                     )
// // //                   : const Center(
// // //                       child: Column(
// // //                         mainAxisAlignment: MainAxisAlignment.center,
// // //                         children: [
// // //                           Icon(Icons.favorite_border, size: 100, color: Colors.grey),
// // //                           SizedBox(height: 10),
// // //                           Text(
// // //                             'No products in your wishlist yet!',
// // //                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //                             textAlign: TextAlign.center,
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //     );
// // //   }
// // // }

// // // class WishlistCard extends StatelessWidget {
// // //   final String title;
// // //   final String description;
// // //   final double price;
// // //   final String imageUrl;

// // //   const WishlistCard({
// // //     super.key,
// // //     required this.title,
// // //     required this.description,
// // //     required this.price,
// // //     required this.imageUrl,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Card(
// // //       color: const Color(0xFFF9F9F9),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
// // //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Row(
// // //           children: [
// // //             ClipRRect(
// // //               borderRadius: BorderRadius.circular(16.0),
// // //               child: Image.network(
// // //                 imageUrl,
// // //                 width: 80,
// // //                 height: 80,
// // //                 fit: BoxFit.cover,
// // //               ),
// // //             ),
// // //             const SizedBox(width: 16.0),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     title,
// // //                     style: const TextStyle(
// // //                       fontSize: 16.0,
// // //                       fontWeight: FontWeight.bold,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 4.0),
// // //                   Text(
// // //                     description,
// // //                     style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
// // //                   ),
// // //                   const SizedBox(height: 8.0),
// // //                   Text(
// // //                     '\$${price.toStringAsFixed(2)}',
// // //                     style: const TextStyle(
// // //                       fontSize: 16.0,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Colors.black,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // class WishlistCard extends StatelessWidget {
// // // //   final String title;
// // // //   final String description;
// // // //   final double price;
// // // //   final String imageUrl;

// // // //   const WishlistCard({
// // // //     super.key,
// // // //     required this.title,
// // // //     required this.description,
// // // //     required this.price,
// // // //     required this.imageUrl,
// // // //   });

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Card(
// // // //       color: const Color(0xFFF9F9F9),
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
// // // //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Row(
// // // //           children: [
// // // //             ClipRRect(
// // // //               borderRadius: BorderRadius.circular(16.0),
// // // //               child: Image.network(
// // // //                 imageUrl,
// // // //                 width: 80,
// // // //                 height: 80,
// // // //                 fit: BoxFit.cover,
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 16.0),
// // // //             Expanded(
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     title,
// // // //                     style: const TextStyle(
// // // //                       fontSize: 16.0,
// // // //                       fontWeight: FontWeight.bold,
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 4.0),
// // // //                   Text(
// // // //                     description,
// // // //                     style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
// // // //                   ),
// // // //                   const SizedBox(height: 8.0),
// // // //                   Text(
// // // //                     '\$${price.toStringAsFixed(2)}',
// // // //                     style: const TextStyle(
// // // //                       fontSize: 16.0,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.black,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // import 'package:flutter/material.dart';
// // import 'package:front/domain/entities/pizza.dart';
// // import 'package:front/presentation/controller/authentification_controller.dart';
// // import 'package:front/presentation/controller/wishlist_controller.dart';
// // import 'package:get/get.dart';
// // import 'package:lottie/lottie.dart';

// // class WishlistPage extends StatefulWidget {
// //   const WishlistPage({super.key});

// //   @override
// //   State<WishlistPage> createState() => _WishlistPageState();
// // }

// // class _WishlistPageState extends State<WishlistPage> {
// //   late WishlistController _wishlistController;
// //   late String currentUserId;
// //   bool isLoading = true;
// //   String errorMessage = '';
// //   List<Pizza> wishlistPizzas = [];

// //   @override
// //   void initState() {
// //     super.initState();

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _initializeControllers();
// //       _loadWishlist();
// //     });
// //   }

// //   void _initializeControllers() {
// //     _wishlistController = Get.find<WishlistController>();
// //     final authController = Get.find<AuthenticationController>();
// //     currentUserId = authController.currentUser.id!;
// //   }

// //   Future<void> _loadWishlist() async {
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });

// //     final success = await _wishlistController.getWishlistByUserId(currentUserId);
// //     if (success) {
// //       setState(() {
// //         wishlistPizzas = List.from(_wishlistController.userWishlist?.pizzas ?? []);
// //         isLoading = false;
// //       });
// //     } else {
// //       setState(() {
// //         errorMessage = 'Failed to load wishlist';
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFB17C46),
// //       appBar: AppBar(
        
      
      
// //         backgroundColor: const Color(0xFFB17C46),
// //         centerTitle: true,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : errorMessage.isNotEmpty
// //               ? Center(
// //                   child: Text(
// //                     errorMessage,
// //                     style: const TextStyle(fontSize: 18, color: Color(0xFF790303)),
// //                   ),
// //                 )
// //               : wishlistPizzas.isNotEmpty
// //                   ? ListView.builder(
// //                       padding: const EdgeInsets.all(16.0),
// //                       itemCount: wishlistPizzas.length,
// //                       itemBuilder: (context, index) {
// //                         final pizza = wishlistPizzas[index];
// //                         return Dismissible(
// //                           key: Key(pizza!.id),
// //                           direction: DismissDirection.endToStart,
// //                           onDismissed: (direction) async {
// //                             await _wishlistController.removePizzaFromWishlist(
// //                               currentUserId, 
// //                               pizza.id);

// //                             // ignore: use_build_context_synchronously
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               SnackBar(
// //                                 content: Text('${pizza.name} removed from wishlist'),
// //                               ),
// //                             );
// //                           },
// //                           background: Container(
// //                             alignment: Alignment.centerRight,
// //                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //                             color: const Color(0xFF790303),
// //                             child: const Icon(Icons.delete, color: Colors.white),
// //                           ),
// //                           child: WishlistCard(
// //                             title: pizza.name!,
// //                             description: pizza.reference!,
// //                             price: pizza.sizes.medium!,
// //                             imageUrl: pizza.image,
// //                           ),
// //                         );
// //                       },
// //                     )
// //                   : Center(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           // Replace the Icon with an Image from assets
// //                            Lottie.asset(
// //                             'assets/animation/heart_animation1.json', // Path to your Lottie file
// //                             width: 200, // Adjust the size if necessary
// //                             height: 200,
// //                           ),
// //                           const SizedBox(height: 30),
// //                           const Text(
// //                             'No products in your wishlist yet!',
// //                             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: const Color(0xFF790303),
// //                             fontFamily: "Yellowtail"),
// //                             textAlign: TextAlign.center,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //     );
// //   }
// // }

// // class WishlistCard extends StatelessWidget {
// //   final String title;
// //   final String description;
// //   final double price;
// //   final String imageUrl;

// //   const WishlistCard({
// //     super.key,
// //     required this.title,
// //     required this.description,
// //     required this.price,
// //     required this.imageUrl,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       color: const Color(0xFFF9F9F9),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
// //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Row(
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(16.0),
// //               child: Image.network(
// //                 imageUrl,
// //                 width: 80,
// //                 height: 80,
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //             const SizedBox(width: 16.0),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     title,
// //                     style: const TextStyle(
// //                       fontSize: 16.0,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4.0),
// //                   Text(
// //                     description,
// //                     style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
// //                   ),
// //                   const SizedBox(height: 8.0),
// //                   Text(
// //                     '\$${price.toStringAsFixed(2)}',
// //                     style: const TextStyle(
// //                       fontSize: 16.0,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:front/domain/entities/pizza.dart';
// import 'package:front/presentation/controller/authentification_controller.dart';
// import 'package:front/presentation/controller/wishlist_controller.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';

// class WishlistPage extends StatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   late WishlistController _wishlistController;
//   late String currentUserId;
//   bool isLoading = true;
//   String errorMessage = '';
//   List<Pizza> wishlistPizzas = [];

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeControllers();
//       _loadWishlist();
//     });
//   }

//   void _initializeControllers() {
//     _wishlistController = Get.find<WishlistController>();
//     final authController = Get.find<AuthenticationController>();
//     currentUserId = authController.currentUser.id!;
//   }

//   Future<void> _loadWishlist() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     final success = await _wishlistController.getWishlistByUserId(currentUserId);
//     if (success) {
//       setState(() {
//         wishlistPizzas = List.from(_wishlistController.userWishlist?.pizzas ?? []);
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         errorMessage = 'Failed to load wishlist';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFB17C46),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFB17C46),
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Add the "Your Wishlist" title here
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
//             child: const Text(
//               'Your Wishlist',
//               style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF790303),
//                 fontFamily: 'Yellowtail',
//               ),
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : errorMessage.isNotEmpty
//                     ? Center(
//                         child: Text(
//                           errorMessage,
//                           style: const TextStyle(fontSize: 18, color: Color(0xFF790303)),
//                         ),
//                       )
//                     : wishlistPizzas.isNotEmpty
//                         ? ListView.builder(
//                             padding: const EdgeInsets.all(16.0),
//                             itemCount: wishlistPizzas.length,
//                             itemBuilder: (context, index) {
//                               final pizza = wishlistPizzas[index];
//                               return Dismissible(
//                                 key: Key(pizza!.id),
//                                 direction: DismissDirection.endToStart,
//                                 onDismissed: (direction) async {
//                                   await _wishlistController.removePizzaFromWishlist(
//                                     currentUserId, 
//                                     pizza.id);

//                                   // ignore: use_build_context_synchronously
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('${pizza.name} removed from wishlist'),
//                                     ),
//                                   );
//                                 },
//                                 background: Container(
//                                   alignment: Alignment.centerRight,
//                                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                                   color: const Color(0xFF790303).withOpacity(0.7),
//                                   child: const Icon(Icons.delete, color: Colors.white),
//                                 ),
//                                 child: WishlistCard(
//                                   title: pizza.name!,
//                                   description: pizza.reference!,
//                                   price: pizza.sizes.medium!,
//                                   imageUrl: pizza.image,
//                                 ),
//                               );
//                             },
//                           )
//                         : Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Lottie.asset(
//                                   'assets/animation/heart_animation1.json', // Path to your Lottie file
//                                   width: 200, // Adjust the size if necessary
//                                   height: 200,
//                                 ),
//                                 const SizedBox(height: 30),
//                                 const Text(
//                                   'No products in your wishlist yet!',
//                                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color:Colors.amber,
//                                   fontFamily: "Italianno"),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WishlistCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final double price;
//   final String imageUrl;

//   const WishlistCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//           color: const Color(0xFFFD9D9D9).withOpacity(0.8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Image.network(
//                 imageUrl,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 16.0),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Italianno'
//                     ),
//                   ),
//                   const SizedBox(height: 4.0),
//                   Text(
//                     description,
//                     style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     '\$${price.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontFamily: "Lobster"
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
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
    // Remove the pizza from the local list immediately for a smooth UI experience
    setState(() {
      wishlistPizzas.removeAt(index);
    });

    // Remove the pizza from the backend
    final success = await _wishlistController.removePizzaFromWishlist(currentUserId, pizzaId);

    if (success) {
      // Show a snackbar to confirm the removal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pizza removed from wishlist'),
        ),
      );
    } else {
      // If the removal fails, add the pizza back to the list
      setState(() {
        wishlistPizzas.insert(index, _wishlistController.userWishlist!.pizzas[index]);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove pizza from wishlist'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB17C46),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Add the "Your Wishlist" title here
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
                              final pizza = wishlistPizzas[index];
                              return Dismissible(
                                key: Key(pizza!.id),
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
                                child: WishlistCard(
                                  title: pizza.name!,
                                  description: pizza.reference!,
                                  price: pizza.sizes.medium!,
                                  imageUrl: pizza.image,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/animation/heart_animation1.json', // Path to your Lottie file
                                  width: 200, // Adjust the size if necessary
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
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