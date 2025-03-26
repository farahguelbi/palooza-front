// // // import 'dart:math';
// // // import 'package:flutter/material.dart';
// // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // import 'package:get/get.dart';
// // // import '../controller/ingredient_controller.dart';
// // // import '../controller/custom_pizza_controller.dart';  // Import CustomPizzaController

// // // class AddScreen extends StatefulWidget {
// // //   @override
// // //   _AddScreenState createState() => _AddScreenState();
// // // }

// // // class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
// // //   String selectedSize = 'S'; // Default size selection
// // //   late AnimationController _controller; // Animation controller
// // //   late Animation<double> _rotationAnimation;
// // //   late Animation<double> _sizeAnimation;
// // //   final IngredientController ingredientController = Get.put(IngredientController());
// // //   final CustomPizzaController customPizzaController = Get.put(CustomPizzaController()); 

// // //   List<Map<String, dynamic>> selectedIngredients = []; // To store the selected ingredients and their quantities
// // //   double totalPrice = 0;

// // //   // Pizza sizes
// // //   final Map<String, double> sizeMap = {
// // //     'S': 200,
// // //     'M': 250,
// // //     'L': 300,
// // //   };

// // //   Map<String, double> selectedPizzaPrices = {
// // //     'S': 8.0,  // Initial price for small pizza
// // //     'M': 10.0, // Initial price for medium pizza
// // //     'L': 12.0, // Initial price for large pizza
// // //   };

// // //   String getSize(String S){
// // //     switch (S) {
// // //       case 'S':return 'small';
// // //        case 'M':return 'medium';
// // //        case 'L':return 'large';
// // //       default:
// // //       return 'small';
// // //     }

// // //   }

// // //   double currentSize = 200; // Default pizza size

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     //initialize the total price
// // //     totalPrice = selectedPizzaPrices['S'] ?? 8.0;

// // //     // Initialize the animation controller
// // //     _controller = AnimationController(
// // //       duration: const Duration(milliseconds: 500), // Animation duration
// // //       vsync: this,
// // //     );

// // //     // Initialize the rotation animation
// // //     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
// // //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// // //     );

// // //     // Initialize the size animation
// // //     _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
// // //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// // //     );

// // //     // Fetch ingredients
// // //     ingredientController.getAllIngredients();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _controller.dispose(); // Dispose of the controller
// // //     super.dispose();
// // //   }

// // //   void _updatePizzaSize(String size) {
// // //     if (size == selectedSize) return; // Skip if the size is the same

// // //     setState(() {
// // //       selectedSize = size;
// // //       double newSize = sizeMap[size] ?? 200;

// // //       // Update the size animation
// // //       _sizeAnimation = Tween<double>(begin: currentSize, end: newSize).animate(
// // //         CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// // //       );

// // //       currentSize = newSize; // Update the current size
// // //     });
// // //     // Update the total price based on the selected size
// // //     totalPrice = selectedPizzaPrices[selectedSize] ?? 0;
// // //     // Start the animation
// // //     _controller.forward(from: 0);
// // //   }

// // //   void _addIngredient(String ingredient) {
// // //     // Check if the ingredient is already added, and increase the quantity if it is
// // //     bool ingredientExists = false;
// // //     for (var item in selectedIngredients) {
// // //       if (item['ingredient'] == ingredient) {
// // //         item['quantity']++;
// // //         ingredientExists = true;
// // //         break;
// // //       }
// // //     }

// // //     if (!ingredientExists) {
// // //       selectedIngredients.add({'ingredient' : ingredient , 'quantity': 1});
    

// // //     // // Update the total price
// // //     // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
// // //     // selectedIngredients.forEach((item) {
// // //     //   totalPrice += item['ingredient'].price * item['quantity'];
// // //     // }
// // //     // );

// // //     setState(() {});
// // //   }
// // //   }
// // //   void _removeIngredient(ingredient) {
// // //     // Check if the ingredient exists, and decrease the quantity if it's more than 1, otherwise remove it
// // //     for (var item in selectedIngredients) {
// // //       if (item['ingredient'] == ingredient['ingredient']) {
// // //         if (item['quantity'] > 1) {
// // //           item['quantity']--;
// // //         } else {
// // //           selectedIngredients.remove(item);
// // //         }
// // //         break;
// // //       }
// // //     }

// // //     // // Update the total price
// // //     // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
// // //     // selectedIngredients.forEach((item) {
// // //     //   totalPrice += item['ingredient'].price * item['quantity'];
// // //     // });

// // //     setState(() {});
// // //   }

// // //   // Call the createCustomPizza function from the CustomPizzaController
// // //   void _addToCart(String selectedSize,List<Map<String,dynamic>>ingredients) async {
    
// // //   Map<String, dynamic> ingredientsData = {
// // //         'selectedSize':selectedSize ,  
// // //         'ingredients':ingredients
// // //       };

// // //     // Call the createPizza usecase via the controller
// // //     bool result = await customPizzaController.createCustomPizza( getSize(selectedSize) , ingredients);

// // //     if (result) {
// // //       // Handle success, maybe navigate to a new screen or show a success message
// // //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pizza added to cart!")));
// // //     } else {
// // //       // Handle failure (e.g., show an error message)
// // //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add pizza")));
// // //     }
// // //   }
  
  
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFB17C46), // Background color
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.transparent,
// // //         elevation: 0,
// // //         leading: Icon(Icons.arrow_back, color: Colors.black),
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Padding(
// // //           padding: const EdgeInsets.symmetric(vertical: 20.0),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.center,
// // //             children: [
// // //               // Animated Pizza on Plate
// // //               Center(
// // //                 child: Stack(
// // //                   alignment: Alignment.center,
// // //                   children: [
// // //                     // Wooden Plate
// // //                     Container(
// // //                       height: 350,
// // //                       width: 350,
// // //                       decoration: BoxDecoration(
// // //                         shape: BoxShape.circle,
// // //                         image: DecorationImage(
// // //                           image: AssetImage('assets/images/plate.png'), // Plate image
// // //                           fit: BoxFit.cover,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     // Animated Pizza
// // //                     AnimatedBuilder(
// // //                       animation: _controller,
// // //                       builder: (context, child) {
// // //                         return Transform.rotate(
// // //                           angle: _rotationAnimation.value * 6.2832, // Full rotation (2 * pi)
// // //                           child: Container(
// // //                             height: _sizeAnimation.value,
// // //                             width: _sizeAnimation.value,
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               image: DecorationImage(
// // //                                 image: AssetImage('assets/images/pizza_main.png'),
// // //                                 fit: BoxFit.cover,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                     // Stack to display the ingredients added on top of the pizza
// // //                     ...selectedIngredients.map((item) {
// // //                       return Positioned(
// // //                         top: sizeMap[selectedSize]! / 2, // Adjust based on pizza size
// // //                         left:sizeMap[selectedSize]! / 2-10 , // Adjust based on pizza size
// // //                         child: Image.network(
// // //                           item['ingredient'].image,
// // //                           height: 130, // Adjust the size of the ingredient image
// // //                           width: 130,  // Adjust the size of the ingredient image
// // //                           errorBuilder: (context, error, stackTrace) =>
// // //                               Icon(Icons.error),
// // //                         ),
// // //                       );
// // //                     }).toList(),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //               // Size Selector
// // //               Container(
// // //                 height: 40,
// // //                 width: 300,
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.grey.shade300,
// // //                   borderRadius: BorderRadius.circular(20),
// // //                 ),
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                   children: [
// // //                     _buildSizeOption('S'),
// // //                     _buildSizeOption('M'),
// // //                     _buildSizeOption('L'),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //               // Ingredients Table
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: GetBuilder<IngredientController>(builder: (controller) {
// // //                   if (controller.isLoading) {
// // //                     return const Center(child: CircularProgressIndicator());
// // //                   }
// // //                   if (controller.allingredients.isEmpty) {
// // //                     return Center(
// // //                       child: Text("No ingredients available."),
// // //                     );
// // //                   }

// // //                   return SingleChildScrollView(
// // //                     scrollDirection: Axis.horizontal,
// // //                     child: DataTable(
// // //                       columnSpacing: 30.0, // Slightly increased column spacing
// // //                       dataRowHeight: 70.0, // Moderately increased row height
// // //                       headingRowHeight: 50.0, // Moderately increased header height
// // //                       columns: const [
// // //                         DataColumn(
// // //                           label: Text("Image", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         ),
// // //                         DataColumn(
// // //                           label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         ),
// // //                         DataColumn(
// // //                           label: Text("Price (\$)", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         ),
// // //                         DataColumn(
// // //                           label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         ),
// // //                       ],
// // //                       rows: controller.allingredients.map((ingredient) {
// // //                         return DataRow(
// // //                           cells: [
// // //                             DataCell(
// // //                               Container(
// // //                                 width: 80, // Adjusted width for image
// // //                                 height: 80, // Adjusted height for image
// // //                                 decoration: BoxDecoration(
// // //                                   shape: BoxShape.circle,
// // //                                   image: DecorationImage(
// // //                                     image: NetworkImage(ingredient.image),
// // //                                     fit: BoxFit.cover,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                             DataCell(Text(ingredient.name ?? "Unknown", style: TextStyle(fontSize: 16))),
// // //                             DataCell(Text(ingredient.price.toStringAsFixed(2), style: TextStyle(fontSize: 16))),
// // //                             DataCell(
// // //                               Row(
// // //                                 children: [
// // //                                   IconButton(
// // //                                     icon: Icon(Icons.add),
// // //                                     onPressed: () {
// // //                                       _addIngredient(ingredient.id);
// // //                                     },
// // //                                   ),
// // //                                   IconButton(
// // //                                     icon: Icon(Icons.remove),
// // //                                     onPressed: () {
// // //                                       // _removeIngredient(ingredient);
// // //                                     },
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         );
// // //                       }).toList(),
// // //                     ),
// // //                   );
// // //                 }),
// // //               ),
// // //               const SizedBox(height: 40),
// // //               // Add to Cart Button
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //                 child: ElevatedButton(
// // //                   onPressed:( ){_addToCart(selectedSize,selectedIngredients);}, // Call the create pizza method
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: const Color(0xFF790303),
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(20),
// // //                     ),
// // //                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
// // //                   ),
// // //                   child: const Text(
// // //                     "Add to Cart",
// // //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 20),
// // //               // Total Price Display
// // //               Text(
// // //                 'Total: \$${totalPrice.toStringAsFixed(2)}',
// // //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildSizeOption(String size) {
// // //     bool isSelected = size == selectedSize;
// // //     return GestureDetector(
// // //       onTap: () {
// // //         _updatePizzaSize(size);
// // //       },
// // //       child: Container(
// // //         height: 50,
// // //         width: 100,
// // //         decoration: BoxDecoration(
// // //           color: isSelected ? const Color(0xFF790303) : Colors.transparent,
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         alignment: Alignment.center,
// // //         child: Text(
// // //           size,
// // //           style: TextStyle(
// // //             color: isSelected ? Colors.white : Colors.orange.shade800,
// // //             fontSize: 16,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:front/presentation/controller/authentification_controller.dart';
// // import 'package:front/presentation/controller/pizza_controller.dart';
// // import 'package:get/get.dart';
// // import '../controller/ingredient_controller.dart';
// // import '../controller/custom_pizza_controller.dart';  // Import CustomPizzaController

// // class AddScreen extends StatefulWidget {
// //   @override
// //   _AddScreenState createState() => _AddScreenState();
// // }

// // class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
// //   String selectedSize = 'S'; // Default size selection
// //   late AnimationController _controller; // Animation controller
// //   late Animation<double> _rotationAnimation;
// //   late Animation<double> _sizeAnimation;
// //   final IngredientController ingredientController = Get.put(IngredientController());
// //   final CustomPizzaController customPizzaController = Get.put(CustomPizzaController()); 

// //   List<Map<String, dynamic>> selectedIngredients = []; // To store the selected ingredients and their quantities
// //   double totalPrice = 0;

// //   // Pizza sizes
// //   final Map<String, double> sizeMap = {
// //     'S': 200,
// //     'M': 250,
// //     'L': 300,
// //   };

// //   Map<String, double> selectedPizzaPrices = {
// //     'S': 8.0,  // Initial price for small pizza
// //     'M': 10.0, // Initial price for medium pizza
// //     'L': 12.0, // Initial price for large pizza
// //   };

// //   String getSize(String S){
// //     switch (S) {
// //       case 'S':return 'small';
// //        case 'M':return 'medium';
// //        case 'L':return 'large';
// //       default:
// //       return 'small';
// //     }

// //   }

// //   double currentSize = 200; // Default pizza size

// //   @override
// //   void initState() {
// //     super.initState();
// //     //initialize the total price
// //     totalPrice = selectedPizzaPrices['S'] ?? 8.0;

// //     // Initialize the animation controller
// //     _controller = AnimationController(
// //       duration: const Duration(milliseconds: 500), // Animation duration
// //       vsync: this,
// //     );

// //     // Initialize the rotation animation
// //     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// //     );

// //     // Initialize the size animation
// //     _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// //     );

// //     // Fetch ingredients
// //     ingredientController.getAllIngredients();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose(); // Dispose of the controller
// //     super.dispose();
// //   }

// //   void _updatePizzaSize(String size) {
// //     if (size == selectedSize) return; // Skip if the size is the same

// //     setState(() {
// //       selectedSize = size;
// //       double newSize = sizeMap[size] ?? 200;

// //       // Update the size animation
// //       _sizeAnimation = Tween<double>(begin: currentSize, end: newSize).animate(
// //         CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// //       );

// //       currentSize = newSize; // Update the current size
// //     });
// //     // Update the total price based on the selected size
// //     totalPrice = selectedPizzaPrices[selectedSize] ?? 0;
// //     // Start the animation
// //     _controller.forward(from: 0);
// //   }
// //   double getTotalPrice(){
// //     double res = 0;
// //     selectedIngredients.forEach((item) {
// //       res += ingredientController.allingredients.firstWhere((e)=>e.id == item['ingredient']).price * item['quantity'];
// //     });
// //     return res +double.parse( selectedPizzaPrices[selectedSize].toString()) ;
// //   }
// //   void _addIngredient(String ingredient) {
// //     print(ingredient);
// //     // Check if the ingredient is already added, and increase the quantity if it is
// //     bool ingredientExists = false;
// //     for (var item in selectedIngredients) {
// //       if (item['ingredient'] == ingredient) {
// //         item['quantity']++;
        
// //         ingredientExists = true;
// //         break;
// //       }
// //     }

// //     if (!ingredientExists) {
// //       selectedIngredients.add({'ingredient' : ingredient , 'quantity': 1});
    

// //     // Update the total price
// //     // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
// //     // selectedIngredients.forEach((item) {
// //     //   totalPrice += ingredientController.allingredients.firstWhere((e)=>e.id == item['ingredient']).price * item['quantity'];
// //     // }
// //    // );

// //   }
// //    totalPrice = getTotalPrice();

// //     setState(() {});


// //   }
// //   void _removeIngredient(ingredient) {
// //     // Check if the ingredient exists, and decrease the quantity if it's more than 1, otherwise remove it
// //     for (var item in selectedIngredients) {
// //       if (item['ingredient'] == ingredient['ingredient']) {
// //         if (item['quantity'] > 1) {
// //           item['quantity']--;
// //         } else {
// //           selectedIngredients.remove(item);
// //         }
// //         break;
// //       }
// //     }

// //     // // Update the total price
// //     // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
// //     // selectedIngredients.forEach((item) {
// //     //   totalPrice += item['ingredient'].price * item['quantity'];
// //     // });

// //     setState(() {});
// //   }

// //   // Call the createCustomPizza function from the CustomPizzaController
// //   void _addToCart(String selectedSize,List<Map<String,dynamic>>ingredients) async {
    
// //   Map<String, dynamic> ingredientsData = {
// //         'selectedSize':selectedSize ,  
// //         'ingredients':ingredients
// //       };

// //     final AuthenticationController authenticationController = Get.find();
// //     // Call the createPizza usecase via the controller
// //     bool result = await customPizzaController.createCustomPizza( getSize(selectedSize) , ingredients,authenticationController.currentUser.id! , totalPrice);

// //     if (result) {
// //       // Handle success, maybe navigate to a new screen or show a success message
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pizza added to cart!")));
// //     } else {
// //       // Handle failure (e.g., show an error message)
// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add pizza")));
// //     }
// //   }
  
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFB17C46), // Background color
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: Icon(Icons.arrow_back, color: Colors.black),
// //       ),
// //       body: GetBuilder(
// //         init: IngredientController(),
// //         builder: (ingredientController) {
// //           return SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 20.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   // Animated Pizza on Plate
// //                   Center(
// //                     child: Stack(
// //                       alignment: Alignment.center,
// //                       children: [
// //                         // Wooden Plate
// //                         Container(
// //                           height: 350,
// //                           width: 350,
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             image: DecorationImage(
// //                               image: AssetImage('assets/images/plate.png'), // Plate image
// //                               fit: BoxFit.cover,
// //                             ),
// //                           ),
// //                         ),
// //                         // Animated Pizza
// //                         AnimatedBuilder(
// //                           animation: _controller,
// //                           builder: (context, child) {
// //                             return Transform.rotate(
// //                               angle: _rotationAnimation.value * 6.2832, // Full rotation (2 * pi)
// //                               child: Container(
// //                                 height: _sizeAnimation.value,
// //                                 width: _sizeAnimation.value,
// //                                 decoration: BoxDecoration(
// //                                   shape: BoxShape.circle,
// //                                   image: DecorationImage(
// //                                     image: AssetImage('assets/images/pizza_main.png'),
// //                                     fit: BoxFit.cover,
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                         // Stack to display the ingredients added on top of the pizza
// //                         ...selectedIngredients.map((item) {
// //                           return Center(
// //                            // Adjust based on pizza size
// //                             child: Image.network(
// //                               ingredientController.allingredients.firstWhere((e)=>e.id == item['ingredient']).image,
// //                             //  item['ingredient'].image,
// //                               //height: 130, // Adjust the size of the ingredient image
// //                               width: currentSize * 0.6,  // Adjust the size of the ingredient image
// //                               errorBuilder: (context, error, stackTrace) =>
// //                                   Icon(Icons.error),
// //                             ),
// //                           );
// //                         }).toList(),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   // Size Selector
// //                   Container(
// //                     height: 40,
// //                     width: 300,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey.shade300,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         _buildSizeOption('S'),
// //                         _buildSizeOption('M'),
// //                         _buildSizeOption('L'),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   // Ingredients Table
// //                   Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: GetBuilder<IngredientController>(builder: (controller) {
// //                       if (controller.isLoading) {
// //                         return const Center(child: CircularProgressIndicator());
// //                       }
// //                       if (controller.allingredients.isEmpty) {
// //                         return Center(
// //                           child: Text("No ingredients available."),
// //                         );
// //                       }
          
// //                       return SingleChildScrollView(
// //                         scrollDirection: Axis.horizontal,
// //                         child: DataTable(
// //                           columnSpacing: 30.0, // Slightly increased column spacing
// //                           dataRowHeight: 70.0, // Moderately increased row height
// //                           headingRowHeight: 50.0, // Moderately increased header height
// //                           columns: const [
// //                             DataColumn(
// //                               label: Text("Image", style: TextStyle(fontWeight: FontWeight.bold)),
// //                             ),
// //                             DataColumn(
// //                               label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
// //                             ),
// //                             DataColumn(
// //                               label: Text("Price (\$)", style: TextStyle(fontWeight: FontWeight.bold)),
// //                             ),
// //                             DataColumn(
// //                               label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold)),
// //                             ),
// //                           ],
// //                           rows: controller.allingredients.map((ingredient) {
// //                             return DataRow(
// //                               cells: [
// //                                 DataCell(
// //                                   Container(
// //                                     width: 80, // Adjusted width for image
// //                                     height: 80, // Adjusted height for image
// //                                     decoration: BoxDecoration(
// //                                       shape: BoxShape.circle,
// //                                       image: DecorationImage(
// //                                         image: NetworkImage(ingredient.image),
// //                                         fit: BoxFit.cover,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 DataCell(Text(ingredient.name ?? "Unknown", style: TextStyle(fontSize: 16))),
// //                                 DataCell(Text(ingredient.price.toStringAsFixed(2), style: TextStyle(fontSize: 16))),
// //                                 DataCell(
// //                                   Row(
// //                                     children: [
// //                                       IconButton(
// //                                         icon: Icon(Icons.add),
// //                                         onPressed: () {
// //                                           _addIngredient(ingredient.id);
// //                                         },
// //                                       ),
// //                                       IconButton(
// //                                         icon: Icon(Icons.remove),
// //                                         onPressed: () {
// //                                           // _removeIngredient(ingredient);
// //                                         },
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             );
// //                           }).toList(),
// //                         ),
// //                       );
// //                     }),
// //                   ),
// //                   const SizedBox(height: 40),
// //                   // Add to Cart Button
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                     child: ElevatedButton(
// //                       onPressed:( ){
// //                         print(selectedSize);
// //                         print(selectedIngredients);
// //                         _addToCart(selectedSize,selectedIngredients);
// //                         }, // Call the create pizza method
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF790303),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
// //                       ),
// //                       child: const Text(
// //                         "Add to Cart",
// //                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   // Total Price Display
// //                   Text(
// //                     'Total: \$${totalPrice.toStringAsFixed(2)}',
// //                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }
// //       ),
// //     );
// //   }

// //   Widget _buildSizeOption(String size) {
// //     bool isSelected = size == selectedSize;
// //     return GestureDetector(
// //       onTap: () {
// //         _updatePizzaSize(size);
// //       },
// //       child: Container(
// //         height: 50,
// //         width: 100,
// //         decoration: BoxDecoration(
// //           color: isSelected ? const Color(0xFF790303) : Colors.transparent,
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //         alignment: Alignment.center,
// //         child: Text(
// //           size,
// //           style: TextStyle(
// //             color: isSelected ? Colors.white : Colors.orange.shade800,
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:front/presentation/controller/authentification_controller.dart';
// import 'package:front/presentation/controller/pizza_controller.dart';
// import 'package:get/get.dart';
// import '../controller/ingredient_controller.dart';
// import '../controller/custom_pizza_controller.dart';

// class AddScreen extends StatefulWidget {
//   @override
//   _AddScreenState createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
//   String selectedSize = 'S'; // Default size selection
//   late AnimationController _controller; // Animation controller
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _sizeAnimation;
//   final IngredientController ingredientController = Get.put(IngredientController());
//   final CustomPizzaController customPizzaController = Get.put(CustomPizzaController());

//   List<Map<String, dynamic>> selectedIngredients = []; // To store the selected ingredients and their quantities
//   double totalPrice = 0;

//   // Pizza sizes
//   final Map<String, double> sizeMap = {
//     'S': 200,
//     'M': 250,
//     'L': 300,
//   };

//   Map<String, double> selectedPizzaPrices = {
//     'S': 8.0, // Initial price for small pizza
//     'M': 10.0, // Initial price for medium pizza
//     'L': 12.0, // Initial price for large pizza
//   };

//   double currentSize = 200; // Default pizza size

//   @override
//   void initState() {
//     super.initState();

//     totalPrice = selectedPizzaPrices['S'] ?? 8.0;

//     // Initialize the animation controller
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     // Initialize the rotation animation
//     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     // Initialize the size animation
//     _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     ingredientController.getAllIngredients();
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose of the controller
//     super.dispose();
//   }

//   void _updatePizzaSize(String size) {
//     if (size == selectedSize) return;

//     setState(() {
//       selectedSize = size;
//       double newSize = sizeMap[size] ?? 200;

//       _sizeAnimation = Tween<double>(begin: currentSize, end: newSize).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//       );

//       currentSize = newSize;
//     });
//     totalPrice = getTotalPrice();
//     _controller.forward(from: 0);
//   }

//   double getTotalPrice() {
//     double res = selectedPizzaPrices[selectedSize] ?? 0;
//     for (var item in selectedIngredients) {
//       res += ingredientController.allingredients
//               .firstWhere((e) => e.id == item['ingredient'])
//               .price *
//           item['quantity'];
//     }
//     return res;
//   }

//   void _addIngredient(String ingredientId) {
//     bool ingredientExists = false;
//     for (var item in selectedIngredients) {
//       if (item['ingredient'] == ingredientId) {
//         item['quantity']++;
//         ingredientExists = true;
//         break;
//       }
//     }

//     if (!ingredientExists) {
//       selectedIngredients.add({'ingredient': ingredientId, 'quantity': 1});
//     }

//     totalPrice = getTotalPrice();

//     setState(() {});
//   }

//   void _removeIngredient(String ingredientId) {
//     for (var item in selectedIngredients) {
//       if (item['ingredient'] == ingredientId) {
//         if (item['quantity'] > 1) {
//           item['quantity']--;
//         } else {
//           selectedIngredients.remove(item);
//         }
//         break;
//       }
//     }
//     totalPrice = getTotalPrice();
//     setState(() {});
//   }

//   void _addToCart(String selectedSize, List<Map<String, dynamic>> ingredients) async {
//     final AuthenticationController authenticationController = Get.find();
//     bool result = await customPizzaController.createCustomPizza(
//         selectedSize, ingredients, authenticationController.currentUser.id!, totalPrice);

//     if (result) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Pizza added to cart!")));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Failed to add pizza")));
//     }
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFB17C46), // Background color
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//       ),
//       body: GetBuilder<IngredientController>(
//         builder: (controller) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Wooden Plate
//                         Container(
//                           height: 350,
//                           width: 350,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/plate.png'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         // Animated Pizza
//                         AnimatedBuilder(
//                           animation: _controller,
//                           builder: (context, child) {
//                             return Transform.rotate(
//                               angle: _rotationAnimation.value * 2 * pi,
//                               child: Container(
//                                 height: _sizeAnimation.value,
//                                 width: _sizeAnimation.value,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                     image: AssetImage('assets/images/pizza_main.png'),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         // Display selected ingredients on top of pizza
//                         ...selectedIngredients.map((item) {
//                           return Center(
//                             child: Image.network(
//                               ingredientController.allingredients
//                                   .firstWhere((e) => e.id == item['ingredient'])
//                                   .image,
//                               width: currentSize * 0.6,
//                             ),
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   _buildSizeSelector(),
//                   const SizedBox(height: 20),
//                   _buildIngredientTable(controller),
//                   const SizedBox(height: 40),
//                   _buildAddToCartButton(),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Total: \$${totalPrice.toStringAsFixed(2)}',
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSizeSelector() {
//     return Container(
//       height: 40,
//       width: 300,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: ['S', 'M', 'L'].map((size) => _buildSizeOption(size)).toList(),
//       ),
//     );
//   }

//   Widget _buildSizeOption(String size) {
//     bool isSelected = size == selectedSize;
//     return GestureDetector(
//       onTap: () => _updatePizzaSize(size),
//       child: Container(
//         height: 50,
//         width: 100,
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF790303) : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           size,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.orange.shade800,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//  Widget _buildIngredientTable(IngredientController controller) {
//   if (controller.isLoading) {
//     return const Center(child: CircularProgressIndicator());
//   }

//   if (controller.allingredients.isEmpty) {
//     return Center(
//       child: const Text("No ingredients available."),
//     );
//   }

//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: DataTable(
//       columnSpacing: 15.0, // Adjusted column spacing
//       dataRowHeight: 60.0, // Height for each row
//       headingRowHeight: 50.0, // Height for the header row
//       columns: const [
//         DataColumn(label: Text("Image")),
//         DataColumn(label: Text("Name")),
//         DataColumn(label: Text("Price")),
//         DataColumn(label: Text("Quantity")),
//       ],
//       rows: controller.allingredients.map((ingredient) {
//         int quantity = selectedIngredients
//             .firstWhere((item) => item['ingredient'] == ingredient.id, orElse: () => {'quantity': 0})['quantity'];
//         return DataRow(
//           cells: [
//             // Ingredient Image
//             DataCell(
//               Image.network(
//                 ingredient.image,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // Ingredient Name
//             DataCell(Text(ingredient.name)),
//             // Ingredient Price
//             DataCell(Text("\$${ingredient.price.toStringAsFixed(2)}")),
//             // Quantity Controls
//             DataCell(
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Decrement Button
//                   ElevatedButton(
//                     onPressed: quantity > 0 ? () => _removeIngredient(ingredient.id) : null,
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       minimumSize: const Size(15, 15),
//                       backgroundColor: const Color(0xFF790303),
//                     ),
//                     child: const Icon(Icons.remove, size: 16, color: Colors.amber),
//                   ),
//                   // Quantity Display
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       quantity.toString(),
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   // Increment Button
//                   ElevatedButton(
//                     onPressed: () => _addIngredient(ingredient.id),
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       minimumSize: const Size(14, 15),
//                       backgroundColor: const Color(0xFF790303),
//                     ),
//                     child: const Icon(Icons.add, size: 16, color: Colors.amber),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }).toList(),
//     ),
//   );
// }

  
//   Widget _buildAddToCartButton() {
//     return ElevatedButton(
//       onPressed: () {
//         _addToCart(selectedSize, selectedIngredients);
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF790303),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//       ),
//       child: const Text(
//         "Add to Cart",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
//       ),
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/sale_controller.dart';
import 'package:front/presentation/screens/sideScreen.dart';
import 'package:get/get.dart';
import '../controller/ingredient_controller.dart';
import '../controller/custom_pizza_controller.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
  String selectedSize = 'S'; // Default size selection
  late AnimationController _controller; // Animation controller
  late Animation<double> _rotationAnimation;
  late Animation<double> _sizeAnimation;
  final IngredientController ingredientController = Get.put(IngredientController());
  final CustomPizzaController customPizzaController = Get.put(CustomPizzaController());
  final SaleController saleController = Get.put(SaleController());
  late String currentUserId;

  List<Map<String, dynamic>> selectedIngredients = []; // To store the selected ingredients and their quantities
  double totalPrice = 0;
  int pizzaQuantity = 1; // Default pizza quantity

  // Pizza sizes
  final Map<String, double> sizeMap = {
    'S': 200,
    'M': 250,
    'L': 300,
  };

  Map<String, double> selectedPizzaPrices = {
    'S': 8.0, // Initial price for small pizza
    'M': 10.0, // Initial price for medium pizza
    'L': 12.0, // Initial price for large pizza
  };

  double currentSize = 200; // Default pizza size

  @override
  void initState() {
    super.initState();

    totalPrice = getTotalPrice(); // Initialize total price

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Initialize the rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Initialize the size animation
    _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    ingredientController.getAllIngredients();

    // Get the current user ID
    final authController = Get.find<AuthenticationController>();
    currentUserId = authController.currentUser.id!;
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _updatePizzaSize(String size) {
    if (size == selectedSize) return;

    setState(() {
      selectedSize = size;
      double newSize = sizeMap[size] ?? 200;

      _sizeAnimation = Tween<double>(begin: currentSize, end: newSize).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

      currentSize = newSize;
    });
    totalPrice = getTotalPrice();
    _controller.forward(from: 0);
  }

  double getTotalPrice() {
    // Base price for the selected size
    double basePrice = selectedPizzaPrices[selectedSize] ?? 0;

    // Calculate the total price of ingredients
    double ingredientsPrice = 0;
    for (var item in selectedIngredients) {
      double ingredientPrice = ingredientController.allingredients
          .firstWhere((e) => e.id == item['ingredient'])
          .price;
      ingredientsPrice += ingredientPrice * item['quantity'];
    }

    // Total price = (Base price + Ingredients price) * Pizza quantity
    return (basePrice + ingredientsPrice) * pizzaQuantity;
  }

  void _addIngredient(String ingredientId) {
    bool ingredientExists = false;
    for (var item in selectedIngredients) {
      if (item['ingredient'] == ingredientId) {
        item['quantity']++;
        ingredientExists = true;
        break;
      }
    }

    if (!ingredientExists) {
      selectedIngredients.add({'ingredient': ingredientId, 'quantity': 1});
    }

    totalPrice = getTotalPrice();

    setState(() {});
  }

  void _removeIngredient(String ingredientId) {
    for (var item in selectedIngredients) {
      if (item['ingredient'] == ingredientId) {
        if (item['quantity'] > 1) {
          item['quantity']--;
        } else {
          selectedIngredients.remove(item);
        }
        break;
      }
    }
    totalPrice = getTotalPrice();
    setState(() {});
  }

Future<void> _addToCartAndCreateSale() async {
  // Step 1: Create the custom pizza
  final customPizzaId = await customPizzaController.createCustomPizza(
    selectedSize: selectedSize,
    ingredients: selectedIngredients,
    userID: currentUserId,
    price: totalPrice,
  );

  if (customPizzaId != null) {
    // Step 2: Create the sale with the custom pizza ID
        print('✅ Custom pizza created successfully with ID: $customPizzaId');

    final sale = await saleController.createSale(
      currentUserId,
      customPizzaId,
      pizzaQuantity,
      totalPrice,
     'PizzaCustom',
    );
    print("Creating sale with pizzaType: PizzaCustom");
   print('SALE1 ${sale}');
final saleId = sale;
  print('✅ Sale created successfully with ID: $saleId');
    if (sale != null) {
      // Step 3: Navigate to SideScreen with the sale ID
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SideScreen(saleId: saleId!),
        ),
      );
    } else {
            print('❌ Sale creation failed. Sale returned null.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create sale. Please try again.")),
      );
    }
  } else {
        print('❌ Custom pizza creation failed.');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(customPizzaController.errorMessage)),
    );
  }
}
  void _incrementPizzaQuantity() {
    setState(() {
      pizzaQuantity++;
      totalPrice = getTotalPrice();
    });
  }

  void _decrementPizzaQuantity() {
    if (pizzaQuantity > 1) {
      setState(() {
        pizzaQuantity--;
        totalPrice = getTotalPrice();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: GetBuilder<IngredientController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Wooden Plate
                        Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/plate.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Animated Pizza
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value * 2 * pi,
                              child: Container(
                                height: _sizeAnimation.value,
                                width: _sizeAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/pizza_main.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // Display selected ingredients on top of pizza
                        ...selectedIngredients.map((item) {
                          return Center(
                            child: Image.network(
                              ingredientController.allingredients
                                  .firstWhere((e) => e.id == item['ingredient'])
                                  .image,
                              width: currentSize * 0.6,
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSizeSelector(),
                  const SizedBox(height: 20),
                  _buildPizzaQuantitySelector(), // Add pizza quantity selector
                  const SizedBox(height: 20),
                  _buildIngredientTable(controller),
                  const SizedBox(height: 40),
                  _buildAddToCartButton(),
                  const SizedBox(height: 20),
                  Text(
                    'Total: \$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Container(
      height: 40,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['S', 'M', 'L'].map((size) => _buildSizeOption(size)).toList(),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = size == selectedSize;
    return GestureDetector(
      onTap: () => _updatePizzaSize(size),
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF790303) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.orange.shade800,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPizzaQuantitySelector() {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Decrement Button
          IconButton(
            onPressed: _decrementPizzaQuantity,
            icon: const Icon(Icons.remove, color: Colors.orange),
          ),
          // Quantity Display
          Text(
            pizzaQuantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // Increment Button
          IconButton(
            onPressed: _incrementPizzaQuantity,
            icon: const Icon(Icons.add, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientTable(IngredientController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.allingredients.isEmpty) {
      return Center(
        child: const Text("No ingredients available."),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 15.0,
        dataRowHeight: 60.0,
        headingRowHeight: 50.0,
        columns: const [
          DataColumn(label: Text("Image")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Price")),
          DataColumn(label: Text("Quantity")),
        ],
        rows: controller.allingredients.map((ingredient) {
          int quantity = selectedIngredients
              .firstWhere((item) => item['ingredient'] == ingredient.id, orElse: () => {'quantity': 0})['quantity'];
          return DataRow(
            cells: [
              DataCell(
                Image.network(
                  ingredient.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              DataCell(Text(ingredient.name)),
              DataCell(Text("\$${ingredient.price.toStringAsFixed(2)}")),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: quantity > 0 ? () => _removeIngredient(ingredient.id) : null,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size(15, 15),
                        backgroundColor: const Color(0xFF790303),
                      ),
                      child: const Icon(Icons.remove, size: 16, color: Colors.amber),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _addIngredient(ingredient.id),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size(14, 15),
                        backgroundColor: const Color(0xFF790303),
                      ),
                      child: const Icon(Icons.add, size: 16, color: Colors.amber),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: _addToCartAndCreateSale,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF790303),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
      child: const Text(
        "Add to Cart",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
      ),
    );
  }
}