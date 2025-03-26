// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // // import 'package:front/presentation/controller/sale_controller.dart';
// // // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // // import 'package:front/domain/entities/sale.dart';
// // // // // import 'package:front/domain/entities/pizza.dart';
// // // // // import 'package:front/domain/entities/sides.dart';

// // // // // class CartScreen extends StatefulWidget {
// // // // //   const CartScreen({super.key});

// // // // //   @override
// // // // //   State<CartScreen> createState() => _CartScreenState();
// // // // // }

// // // // // class _CartScreenState extends State<CartScreen> {
// // // // //   late CartController _cartController;
// // // // //   late SaleController _saleController;
// // // // //   late PizzaController _pizzaController;
// // // // //   late String currentUserId;
// // // // //   bool isLoading = true;
// // // // //   String errorMessage = '';
// // // // //   List<Sale> cartSales = [];

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _cartController = Get.find<CartController>();
// // // // //     _saleController = Get.find<SaleController>();
// // // // //     _pizzaController = Get.find<PizzaController>();

// // // // //     final AuthenticationController authenticationController = Get.find();
// // // // //     currentUserId = authenticationController.currentUser.id!;

// // // // //     _fetchCartData();
// // // // //   }

// // // // //   /// Fetch the Cart for the Current User
// // // // //   Future<void> _fetchCartData() async {
// // // // //     try {
// // // // //       final cart = await _cartController.getCartByUser(currentUserId);
// // // // //       setState(() {
// // // // //         cartSales = cart?.sales ?? [];
// // // // //         isLoading = false;
// // // // //       });
// // // // //     } catch (error) {
// // // // //       setState(() {
// // // // //         isLoading = false;
// // // // //         errorMessage = 'Failed to load cart data: $error';
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text(
// // // // //           'Cart',
// // // // //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// // // // //         ),
// // // // //         centerTitle: true,
// // // // //         leading: IconButton(
// // // // //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// // // // //           onPressed: () {
// // // // //             Navigator.of(context).pop();
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //       body: isLoading
// // // // //           ? const Center(child: CircularProgressIndicator())
// // // // //           : errorMessage.isNotEmpty
// // // // //               ? Center(child: Text(errorMessage, style: const TextStyle(fontSize: 18)))
// // // // //               : GetBuilder<CartController>(
// // // // //                   builder: (cartController) {
                    
// // // // //                     final cartSales = cartController.allSales;

// // // // //                     return cartSales.isNotEmpty
// // // // //                         ? ListView.builder(
// // // // //                             padding: const EdgeInsets.all(16.0),
// // // // //                             itemCount: cartSales.length,
// // // // //                             itemBuilder: (context, index) {
// // // // //                               final sale = cartSales[index];
// // // // //                               return CartSaleCard(sale: sale);
// // // // //                             },
// // // // //                           )
// // // // //                         : const Center(
// // // // //                             child: Column(
// // // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // // //                               children: [
// // // // //                                 Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
// // // // //                                 SizedBox(height: 10),
// // // // //                                 Text(
// // // // //                                   'Your cart is empty. Add some pizzas!',
// // // // //                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // //                                   textAlign: TextAlign.center,
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           );
// // // // //                   },
// // // // //                 ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // /// CartSaleCard: Displays Individual Sale in Cart
// // // // // class CartSaleCard extends StatelessWidget {
// // // // //   final Sale sale;

// // // // //   const CartSaleCard({super.key, required this.sale});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final PizzaController pizzaController = Get.find<PizzaController>();
// // // // //     final SideController sideController = Get.find<SideController>();

// // // // //     return FutureBuilder<bool>(
// // // // //       future: pizzaController.getPizzatById(sale.pizzaId), // ✅ Fetch Pizza details
// // // // //       builder: (context, pizzaSnapshot) {
// // // // //         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
// // // // //           return const Padding(
// // // // //             padding: EdgeInsets.all(16.0),
// // // // //             child: Center(child: CircularProgressIndicator()),
// // // // //           );
// // // // //         }

// // // // //         if (!pizzaSnapshot.hasData || !pizzaSnapshot.data!) {
// // // // //           return ListTile(
// // // // //             title: const Text('Pizza details not found'),
// // // // //             subtitle: Text('Quantity: ${sale.pizzaQuantity}'),
// // // // //           );
// // // // //         }

// // // // //         final Pizza? pizza = pizzaController.selectedPizza;

// // // // //         return Card(
// // // // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// // // // //           elevation: 6.0,
// // // // //           margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
// // // // //           child: ListTile(
// // // // //             leading: ClipRRect(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               child: pizza?.image != null && pizza!.image.isNotEmpty
// // // // //                   ? Image.network(
// // // // //                       pizza.image,
// // // // //                       width: 60,
// // // // //                       height: 60,
// // // // //                       fit: BoxFit.cover,
// // // // //                     )
// // // // //                   : const Icon(Icons.image_not_supported, size: 60),
// // // // //             ),
// // // // //             title: Text(
// // // // //               pizza?.name ?? 'Unknown Pizza',  // ✅ Fetching Pizza Name
// // // // //               style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // // // //             ),
// // // // //             subtitle: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text('Quantity: ${sale.pizzaQuantity}'),
// // // // //                 Text('Total: \$${sale.totalPrice.toStringAsFixed(2)}'),

// // // // //                 // ✅ Fetch & Display Side Details
// // // // //                 if (sale.sides.isNotEmpty) ...[
// // // // //                   const SizedBox(height: 4.0),
// // // // //                   const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),

// // // // //                   // Fetch side details asynchronously
// // // // //                   ...sale.sides.map(
// // // // //                     (side) => FutureBuilder<bool>(
// // // // //                       future: sideController.getSideById(side.sideId),
// // // // //                       builder: (context, sideSnapshot) {
// // // // //                         if (sideSnapshot.connectionState == ConnectionState.waiting) {
// // // // //                           return const Padding(
// // // // //                             padding: EdgeInsets.all(8.0),
// // // // //                             child: Text("Loading side..."),
// // // // //                           );
// // // // //                         }

// // // // //                         if (!sideSnapshot.hasData || !sideSnapshot.data!) {
// // // // //                           return const Text("Side details not found");
// // // // //                         }

// // // // //                         final Side? fetchedSide = sideController.selectedSide;

// // // // //                         return Text(
// // // // //                           "- ${fetchedSide?.name ?? 'Unknown Side'} x${side.quantity} (\$${fetchedSide?.price.toStringAsFixed(2) ?? '0.00'})",
// // // // //                           style: const TextStyle(color: Colors.grey),
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ],
// // // // //             ),
// // // // //             trailing: IconButton(
// // // // //               icon: const Icon(Icons.delete, color: Colors.red),
// // // // //               onPressed: () {
// // // // //                 final CartController cartController = Get.find<CartController>();
// // // // //                 if (sale.id != null && sale.userId != null) {
// // // // //                   cartController.removeSaleFromCart(sale.userId!, sale.id!);
// // // // //                 }
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:get/get.dart';
// // // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // // import 'package:front/domain/entities/sale.dart';
// // // // // import 'package:front/domain/entities/pizza.dart';
// // // // // import 'package:front/domain/entities/sides.dart';

// // // // // class CartScreen extends StatefulWidget {
// // // // //   const CartScreen({super.key});

// // // // //   @override
// // // // //   State<CartScreen> createState() => _CartScreenState();
// // // // // }

// // // // // class _CartScreenState extends State<CartScreen> {
// // // // //   late CartController _cartController;
// // // // //   late PizzaController _pizzaController;
// // // // //   late String currentUserId;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _cartController = Get.find<CartController>();
// // // // //     _pizzaController = Get.find<PizzaController>();

// // // // //     final AuthenticationController authenticationController = Get.find();
// // // // //     currentUserId = authenticationController.currentUser.id!;

// // // // //     _cartController.getCartByUser(currentUserId); 
// // // // //     _cartController.loadCart(currentUserId);
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
    
// // // // //     return Scaffold(
// // // // //         backgroundColor: const Color(0xFFB17C46),

// // // // //       appBar: AppBar(
// // // // //                 backgroundColor: const Color(0xFF790303),

// // // // //         centerTitle: true,
// // // // //          elevation: 0,
// // // // //         leading: IconButton(
// // // // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // // // //           onPressed: () => Navigator.pop(context),
// // // // //         ),
// // // // //       ),
// // // // //       body: GetBuilder<CartController>(
        
// // // // //         id: 'cart_update',  // 🔄 Ensure only this part updates
// // // // //         builder: (cartController) {
// // // // //           print("🛒 UI Rebuilding - Cart has ${cartController.allSales.length} sales");

// // // // //           final cartSales = cartController.allSales;

// // // // //           return cartSales.isNotEmpty
// // // // //               ? ListView.builder(
// // // // //                   padding: const EdgeInsets.all(16.0),
// // // // //                   itemCount: cartSales.length,
// // // // //                   itemBuilder: (context, index) {
// // // // //                     final sale = cartSales[index];
// // // // //                     return CartSaleCard(sale: sale);
// // // // //                   },
// // // // //                 )
// // // // //               : const Center(
// // // // //                   child: Column(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     children: [
// // // // //                       Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
// // // // //                       SizedBox(height: 10),
// // // // //                       Text(
// // // // //                         'Your cart is empty. Add some pizzas!',
// // // // //                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // // //                         textAlign: TextAlign.center,
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 );
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }


// // // // // class CartSaleCard extends StatelessWidget {
// // // // //   final Sale sale;

// // // // //   const CartSaleCard({super.key, required this.sale});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final PizzaController pizzaController = Get.find<PizzaController>();
// // // // //     final SideController sideController = Get.find<SideController>();

// // // // //     return FutureBuilder<bool>(
// // // // //       future: pizzaController.getPizzatById(sale.pizzaId), // ✅ Fetch pizza details
// // // // //       builder: (context, pizzaSnapshot) {
// // // // //         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
// // // // //           return const Padding(
// // // // //             padding: EdgeInsets.all(16.0),
// // // // //             child: Center(child: CircularProgressIndicator()),
// // // // //           );
// // // // //         }

// // // // //         if (!pizzaSnapshot.hasData || !pizzaSnapshot.data!) {
// // // // //           return ListTile(
// // // // //             title: const Text('Pizza details not found'),
// // // // //             subtitle: Text('Quantity: ${sale.pizzaQuantity}'),
// // // // //           );
// // // // //         }

// // // // //         final Pizza? pizza = pizzaController.selectedPizza; // ✅ Get pizza details

// // // // //         return Card(
// // // // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// // // // //           elevation: 6.0,
// // // // //           margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
// // // // //           child: ListTile(
// // // // //             leading: ClipRRect(
// // // // //               borderRadius: BorderRadius.circular(12.0),
// // // // //               child: pizza?.image != null && pizza!.image.isNotEmpty
// // // // //                   ? Image.network(
// // // // //                       pizza.image,
// // // // //                       width: 60,
// // // // //                       height: 60,
// // // // //                       fit: BoxFit.cover,
// // // // //                     )
// // // // //                   : const Icon(Icons.image_not_supported, size: 60),
// // // // //             ),
// // // // //             title: Text(
// // // // //               pizza?.name ?? 'Unknown Pizza',
// // // // //               style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // // // //             ),
// // // // //             subtitle: Column(
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text('Quantity: ${sale.pizzaQuantity}'),
// // // // //                 Text('Total: \$${sale.totalPrice.toStringAsFixed(2)}'),

// // // // //                 // ✅ Fetch and display sides
// // // // //                 if (sale.sides.isNotEmpty) ...[
// // // // //                   const SizedBox(height: 4.0),
// // // // //                   const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),

// // // // //                   // Fetch side details asynchronously
// // // // //                   ...sale.sides.map(
// // // // //                     (side) => FutureBuilder<bool>(
// // // // //                       future: sideController.getSideById(side.sideId),
// // // // //                       builder: (context, sideSnapshot) {
// // // // //                         if (sideSnapshot.connectionState == ConnectionState.waiting) {
// // // // //                           return const Padding(
// // // // //                             padding: EdgeInsets.all(8.0),
// // // // //                             child: Text("Loading side..."),
// // // // //                           );
// // // // //                         }

// // // // //                         if (!sideSnapshot.hasData || !sideSnapshot.data!) {
// // // // //                           return const Text("Side details not found");
// // // // //                         }

// // // // //                         final Side? fetchedSide = sideController.selectedSide;

// // // // //                         return Text(
// // // // //                           "- ${fetchedSide?.name ?? 'Unknown Side'} x${side.quantity} (\$${fetchedSide?.price.toStringAsFixed(2) ?? '0.00'})",
// // // // //                           style: const TextStyle(color: Colors.grey),
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ],
// // // // //             ),
// // // // //             trailing: IconButton(
// // // // //               icon: const Icon(Icons.delete, color: Colors.red),
// // // // //               onPressed: () async {
// // // // //                 final CartController cartController = Get.find<CartController>();
// // // // //                 if (sale.id != null && sale.userId != null) {
// // // // //                   bool success = await cartController.removeSaleFromCart(sale.userId!, sale.id!);

// // // // //                   if (success) {
// // // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // // //                       const SnackBar(content: Text("Removed from cart successfully!")),
// // // // //                     );
// // // // //                   } else {
// // // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // // //                       const SnackBar(content: Text("Failed to remove from cart.")),
// // // // //                     );
// // // // //                   }
// // // // //                 }
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:front/domain/entities/sides.dart';
// // // // import 'package:get/get.dart';
// // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // import 'package:front/domain/entities/sale.dart';
// // // // import 'package:front/domain/entities/pizza.dart';

// // // // class CartScreen extends StatefulWidget {
// // // //   const CartScreen({super.key});

// // // //   @override
// // // //   State<CartScreen> createState() => _CartScreenState();
// // // // }

// // // // class _CartScreenState extends State<CartScreen> {
// // // //   late CartController _cartController;
// // // //   late PizzaController _pizzaController;
// // // //   late String currentUserId;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _cartController = Get.find<CartController>();
// // // //     _pizzaController = Get.find<PizzaController>();

// // // //     final AuthenticationController authenticationController = Get.find();
// // // //     currentUserId = authenticationController.currentUser.id!;

// // // //     _cartController.getCartByUser(currentUserId); 
// // // //     _cartController.loadCart(currentUserId);
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: const Color(0xFFB17C46),
// // // //       appBar: AppBar(
// // // //        backgroundColor: const Color(0xFFB17C46),

// // // //         centerTitle: true,
// // // //         elevation: 0,
// // // //         title: const Text(
          
// // // //           'Your Cart',
// // // //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Yellowtail'),
// // // //         ),
// // // //         leading: IconButton(
// // // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // // //           onPressed: () => Navigator.pop(context),
// // // //         ),
// // // //       ),
// // // //       body: Column(
// // // //         children: [
// // // //           Expanded(
// // // //             child: GetBuilder<CartController>(
// // // //               id: 'cart_update', 
// // // //               builder: (cartController) {
// // // //                 print("🛒 UI Rebuilding - Cart has ${cartController.allSales.length} sales");

// // // //                 final cartSales = cartController.allSales;

// // // //                 return cartSales.isNotEmpty
// // // //                     ? ListView.builder(
// // // //                         padding: const EdgeInsets.all(16.0),
// // // //                         itemCount: cartSales.length,
// // // //                         itemBuilder: (context, index) {
// // // //                           final sale = cartSales[index];
// // // //                           return CartSaleCard(sale: sale);
// // // //                         },
// // // //                       )
// // // //                     : const Center(
// // // //                         child: Column(
// // // //                           mainAxisAlignment: MainAxisAlignment.center,
// // // //                           children: [
// // // //                             Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
// // // //                             SizedBox(height: 10),
// // // //                             Text(
// // // //                               'Your cart is empty. Add some pizzas!',
// // // //                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // // //                               textAlign: TextAlign.center,
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       );
// // // //               },
// // // //             ),
// // // //           ),
// // // //           _buildCartTotal(),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   /// ✅ **Styled Cart Total Section**
// // // //   Widget _buildCartTotal() {
// // // //     return Container(
// // // //       padding: const EdgeInsets.all(16.0),
// // // //       decoration: const BoxDecoration(
// // // //         color: const Color(0xFFB17C46),
// // // //         borderRadius: BorderRadius.only(
// // // //           topLeft: Radius.circular(20),
// // // //           topRight: Radius.circular(20),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.end,
// // // //         children: [
// // // //           GetBuilder<CartController>(
// // // //             id: 'cart_total',
// // // //             builder: (cartController) {
// // // //               return Column(
                
// // // //                 crossAxisAlignment: CrossAxisAlignment.end,
// // // //                 children: [
// // // //                   Text(
// // // //                     "Total Price: \$${cartController.cartTotalPrice.toStringAsFixed(2)}",
// // // //                     style: const TextStyle(
// // // //                       fontSize: 20,
// // // //                       fontFamily: 'Lobster',
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: Colors.black,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               );
// // // //             },
// // // //           ),
// // // //           const SizedBox(height: 15),

// // // //           /// ✅ **Checkout Button Styled Like Order Now**
// // // //           SizedBox(
// // // //             width: double.infinity,
// // // //             child: ElevatedButton(
// // // //               onPressed: () {
// // // //                 print("🛍 Proceed to Checkout!");
// // // //               },
// // // //               style: ElevatedButton.styleFrom(
// // // //                 backgroundColor: const Color(0xFF790303),
// // // //                 shape: RoundedRectangleBorder(
// // // //                   borderRadius: BorderRadius.circular(15),
// // // //                 ),
// // // //               ),
// // // //               child: const Padding(
// // // //                 padding: EdgeInsets.all(12.0),
// // // //                 child: Text(
// // // //                   'Checkout',
// // // //                   style: TextStyle(
// // // //                     fontSize: 21,
// // // //                     fontFamily: 'Roboto',
// // // //                     color: Color(0xFFD8CAB8),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // /// ✅ **CartSaleCard: Displays Individual Sale in Cart**
// // // // class CartSaleCard extends StatelessWidget {
// // // //   final Sale sale;

// // // //   const CartSaleCard({super.key, required this.sale});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final PizzaController pizzaController = Get.find<PizzaController>();

// // // //     return FutureBuilder<bool>(
// // // //       future: pizzaController.getPizzatById(sale.pizzaId),
// // // //       builder: (context, pizzaSnapshot) {
// // // //         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
// // // //           return const Padding(
// // // //             padding: EdgeInsets.all(16.0),
// // // //             child: Center(child: CircularProgressIndicator()),
// // // //           );
// // // //         }

// // // //         if (!pizzaSnapshot.hasData || !pizzaSnapshot.data!) {
// // // //           return ListTile(
// // // //             title: const Text('Pizza details not found'),
// // // //             subtitle: Text('Quantity: ${sale.pizzaQuantity}'),
// // // //           );
// // // //         }

// // // //         final Pizza? pizza = pizzaController.selectedPizza;

// // // //         return Card(
// // // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
// // // //           elevation: 6.0,
// // // //           margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
// // // //           child: Padding(
// // // //             padding: const EdgeInsets.all(12.0),
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Row(
// // // //                   children: [
// // // //                     ClipRRect(
// // // //                       borderRadius: BorderRadius.circular(12.0),
// // // //                       child: pizza?.image != null && pizza!.image.isNotEmpty
// // // //                           ? Image.network(
// // // //                               pizza.image,
// // // //                               width: 60,
// // // //                               height: 60,
// // // //                               fit: BoxFit.cover,
// // // //                             )
// // // //                           : const Icon(Icons.image_not_supported, size: 60),
// // // //                     ),
// // // //                     const SizedBox(width: 12.0),
// // // //                     Expanded(
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Text(
// // // //                             pizza?.name ?? 'Unknown Pizza',
// // // //                             style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// // // //                           ),
// // // //                           Text('Quantity: ${sale.pizzaQuantity}'),
// // // //                           Text('Total: \$${sale.totalPrice.toStringAsFixed(2)}'),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                     IconButton(
// // // //                       icon: const Icon(Icons.delete, color: Colors.red),
// // // //                       onPressed: () async {
// // // //                         final CartController cartController = Get.find<CartController>();
// // // //                         if (sale.id != null && sale.userId != null) {
// // // //                           bool success = await cartController.removeSaleFromCart(sale.userId!, sale.id!);

// // // //                           if (success) {
// // // //                             ScaffoldMessenger.of(context).showSnackBar(
// // // //                               const SnackBar(content: Text("Removed from cart successfully!")),
// // // //                             );
// // // //                           } else {
// // // //                             ScaffoldMessenger.of(context).showSnackBar(
// // // //                               const SnackBar(content: Text("Failed to remove from cart.")),
// // // //                             );
// // // //                           }
// // // //                         }
// // // //                       },
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //                 const Divider(),
// // // //                 if (sale.sides.isNotEmpty)
// // // //                   const Text(
// // // //                     "Sides:",
// // // //                     style: TextStyle(fontWeight: FontWeight.bold),
// // // //                   ),
// // // //                 ...sale.sides.map((side) {
// // // //                   // Fetch the details for each side independently
// // // //                   return FutureBuilder<bool>(
// // // //                     future: Get.find<SideController>().getSideById(side.sideId),
// // // //                     builder: (context, sideSnapshot) {
// // // //                       if (sideSnapshot.connectionState == ConnectionState.waiting) {
// // // //                         return const Padding(
// // // //                           padding: EdgeInsets.all(8.0),
// // // //                           child: Text("Loading side..."),
// // // //                         );
// // // //                       }

// // // //                       if (!sideSnapshot.hasData || !sideSnapshot.data!) {
// // // //                         return const Text("Side details not found");
// // // //                       }

// // // //                       final sideController = Get.find<SideController>();
// // // //                       final fetchedSide = sideController.selectedSide;

// // // //                       if (fetchedSide == null) {
// // // //                         return const Text("Side details not available");
// // // //                       }

// // // //                       return Padding(
// // // //                         padding: const EdgeInsets.symmetric(vertical: 4.0),
// // // //                         child: Row(
// // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                           children: [
// // // //                             Expanded(
// // // //                               child: Text(
// // // //                                 fetchedSide.name,
// // // //                                 style: const TextStyle(fontSize: 16.0),
// // // //                               ),
// // // //                             ),
// // // //                             Text(
// // // //                               "\$${fetchedSide.price.toStringAsFixed(2)} x${side.quantity}",
// // // //                               style: const TextStyle(color: Colors.grey),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       );
// // // //                     },
// // // //                   );
// // // //                 }).toList(),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:front/presentation/screens/commandScreen.dart';
// // // import 'package:get/get.dart';
// // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // import 'package:front/presentation/controller/cart_controller.dart';
// // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // import 'package:front/presentation/controller/side_controller.dart';
// // // import 'package:front/domain/entities/sale.dart';
// // // import 'package:front/domain/entities/pizza.dart';
// // // import 'package:front/domain/entities/sides.dart';

// // // class CartScreen extends StatefulWidget {
// // //   const CartScreen({super.key});

// // //   @override
// // //   State<CartScreen> createState() => _CartScreenState();
// // // }

// // // class _CartScreenState extends State<CartScreen> {
// // //   late CartController _cartController;
// // //   late PizzaController _pizzaController;
// // //   late String currentUserId;

// // //   // @override
// // //   // void initState() {
// // //   //   super.initState();
// // //   //   _cartController = Get.find<CartController>();
// // //   //   _pizzaController = Get.find<PizzaController>();

// // //   //   final AuthenticationController authenticationController = Get.find();
// // //   //   currentUserId = authenticationController.currentUser.id!;
// // //   // print("Fetching cart for user $currentUserId");
// // //   //   _cartController.getCartByUser(currentUserId);

// // //   //   _cartController.loadCart(currentUserId);
// // //   // }
// // // @override
// // // void initState() {
// // //   super.initState();
// // //   _cartController = Get.find<CartController>();
// // //   _pizzaController = Get.find<PizzaController>();

// // //   final AuthenticationController authenticationController = Get.find();
// // //   currentUserId = authenticationController.currentUser.id!;
  
// // //   print("Fetching cart for user $currentUserId");

// // //   // Fetch cart data for the current user
// // //   _cartController.getCartByUser(currentUserId).then((_) {
// // //     // Once the cart is fetched successfully, log the data
// // //     print("Cart fetched successfully: ${_cartController.allSales}");
// // //   }).catchError((error) {
// // //     // Catch any error that occurs during fetching
// // //     print("Error fetching cart: $error");
// // //   });

// // //   // Load the cart in case it's needed for UI updates
// // //   _cartController.loadCart(currentUserId);
// // // }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFB17C46),
// // //        appBar: AppBar(
// // //       backgroundColor: const Color(0xFFB17C46),
// // //       centerTitle: true,
// // //       elevation: 0,
// // //       leading: IconButton(
// // //         icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //         onPressed: () => Navigator.pop(context),
// // //       ),
// // //     ),

     
// // //       body: Column(
// // //         children: [
// // //               Padding(
// // //           padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
// // //           child: const Text(
// // //             'Your Cart',
// // //             style: TextStyle(
// // //               fontSize: 48,
// // //               fontWeight: FontWeight.bold,
// // //               color: Color(0xFF790303),
// // //               fontFamily: 'Yellowtail'
// // //             ),
// // //           ),
// // //         ),
// // //           Expanded(
// // //             child: GetBuilder<CartController>(
// // //               id: 'cart_update',
// // //               builder: (cartController) {
// // //                 final cartSales = cartController.allSales;

// // //                 return cartSales.isNotEmpty
// // //                     // ? ListView.builder(
// // //                     //     padding: const EdgeInsets.all(16.0),
// // //                     //     itemCount: cartSales.length,
// // //                     //     itemBuilder: (context, index) {
// // //                     //       final sale = cartSales[index];
// // //                     //       return CartSaleCard(sale: sale);
// // //                     //     },
// // //                     ?ListView.builder(
// // //   padding: const EdgeInsets.all(16.0),
// // //   itemCount: cartSales.length,
// // //   itemBuilder: (context, index) {
// // //     final sale = cartSales[index];
// // //     return CartSaleCard(
// // //       key: ValueKey(sale.id), // Add a unique key for each CartSaleCard
// // //       sale: sale,
// // //     );
// // //   },
// // //                       )
// // //                     : const Center(
// // //                         child: Column(
// // //                           mainAxisAlignment: MainAxisAlignment.center,
// // //                           children: [
// // //                             Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
// // //                             SizedBox(height: 10),
// // //                             Text(
// // //                               'Your cart is empty. Add some pizzas!',
// // //                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //                               textAlign: TextAlign.center,
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       );
// // //               },
// // //             ),
// // //           ),
// // //           _buildCartTotal(),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCartTotal() {
// // //     return Container(
// // //       padding: const EdgeInsets.all(16.0),
// // //       decoration: const BoxDecoration(
// // //         color: Color(0xFFB17C46),
// // //         borderRadius: BorderRadius.only(
// // //           topLeft: Radius.circular(20),
// // //           topRight: Radius.circular(20),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.end,
// // //         children: [
// // //           GetBuilder<CartController>(
// // //             id: 'cart_total',
// // //             builder: (cartController) {
// // //               return Text(
// // //                 "Total Price: \$${cartController.cartTotalPrice.toStringAsFixed(2)}",
// // //                 style: const TextStyle(
// // //                   fontSize: 20,
// // //                   fontFamily: 'Lobster',
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Colors.black,
// // //                 ),
// // //               );
// // //             },
// // //           ),
// // //           const SizedBox(height: 15),
// // //           SizedBox(
// // //             width: double.infinity,
// // //             child: ElevatedButton(
// // //               onPressed: () {
// // //                  Navigator.of(context).push(
// // //       MaterialPageRoute(
// // //         builder: (context) => CommandScreen(),
// // //       ),
// // //     );
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color(0xFF790303),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(15),
// // //                 ),
// // //               ),
// // //               child: const Padding(
// // //                 padding: EdgeInsets.all(12.0),
// // //                 child: Text(
// // //                   'Checkout',
// // //                   style: TextStyle(
// // //                     fontSize: 21,
// // //                     fontFamily: 'Roboto',
// // //                     color: Color(0xFFD8CAB8),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class CartSaleCard extends StatefulWidget {
// // //   final Sale sale;

// // //   const CartSaleCard({super.key, required this.sale});

// // //   @override
// // //   State<CartSaleCard> createState() => _CartSaleCardState();
// // // }

// // // class _CartSaleCardState extends State<CartSaleCard> {
// // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // //   final SideController sideController = Get.find<SideController>();

// // //   late Future<Pizza?> _pizzaFuture;
// // //   late Future<List<Side>> _sidesFuture;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _pizzaFuture = pizzaController.getPizzatById(widget.sale.pizzaId).then((_) => pizzaController.selectedPizza);
// // //     _sidesFuture = _fetchSides(widget.sale.sides);
// // //   }

// // //   Future<List<Side>> _fetchSides(List<SaleSide> sides) async {
// // //     List<Side> fetchedSides = [];
// // //     for (var side in sides) {
// // //       final success = await sideController.getSideById(side.sideId);
// // //       if (success) {
// // //         fetchedSides.add(sideController.selectedSide!);
// // //       }
// // //     }
// // //     return fetchedSides;
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return FutureBuilder<Pizza?>(
// // //       future: _pizzaFuture,
// // //       builder: (context, pizzaSnapshot) {
// // //         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
// // //           return const Padding(
// // //             padding: EdgeInsets.all(16.0),
// // //             child: Center(child: CircularProgressIndicator()),
// // //           );
// // //         }

// // //         if (!pizzaSnapshot.hasData) {
// // //           return ListTile(
// // //             title: const Text('Pizza details not found'),
// // //             subtitle: Text('Quantity: ${widget.sale.pizzaQuantity}'),
// // //           );
// // //         }

// // //         final pizza = pizzaSnapshot.data;

// // //         return FutureBuilder<List<Side>>(
// // //           future: _sidesFuture,
// // //           builder: (context, sidesSnapshot) {
// // //             if (sidesSnapshot.connectionState == ConnectionState.waiting) {
// // //               return const Padding(
// // //                 padding: EdgeInsets.all(16.0),
// // //                 child: Center(child: CircularProgressIndicator()),
// // //               );
// // //             }

// // //             final sides = sidesSnapshot.data ?? [];

// // //             return Card(
// // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
// // //               elevation: 5.0,
// // //               margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// // //               color: const Color(0xFFFD9D9D9), 
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     /// Pizza Information
// // //                     Row(
// // //                       children: [
// // //                         ClipRRect(
// // //                           borderRadius: BorderRadius.circular(12.0),
// // //                           child: pizza?.image != null && pizza!.image.isNotEmpty
// // //                               ? Image.network(
// // //                                   pizza.image,
// // //                                   width: 90,
// // //                                   height: 90,
// // //                                   fit: BoxFit.cover,
// // //                                 )
// // //                               : const Icon(Icons.image_not_supported, size: 70, color: Colors.grey),
// // //                         ),
// // //                         const SizedBox(width: 16.0),
// // //                         Expanded(
// // //                           child: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               Text(
// // //                                 pizza?.name ?? 'Unknown Pizza',
// // //                                 style: const TextStyle(
// // //                                   fontSize: 18.0,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Color(0xFF333333),
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 6.0),
// // //                               Text(
// // //                                 'Quantity: ${widget.sale.pizzaQuantity}',
// // //                                 style: const TextStyle(fontSize: 14.0, color: Colors.black),
// // //                               ),
// // //                               const SizedBox(height: 6.0),
// // //                               Text(
// // //                                 'Total: \$${widget.sale.totalPrice.toStringAsFixed(2)}',
// // //                                 style: const TextStyle(
// // //                                   fontSize: 16.0,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Color(0xFF000000),
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                         IconButton(
// // //                           icon: const Icon(Icons.delete, color: Color(0xFF790303)),
// // //                           onPressed: () async {
// // //                             final CartController cartController = Get.find<CartController>();
// // //                             if (widget.sale.id != null && widget.sale.userId != null) {
// // //                                   print("Removing sale with ID: ${widget.sale.id}"); // Debug print

// // //                               bool success = await cartController.removeSaleFromCart(widget.sale.userId!, widget.sale.id!);

// // //                               if (success) {
// // //                                 ScaffoldMessenger.of(context).showSnackBar(
// // //                                   const SnackBar(content: Text("Removed from cart successfully!")),
// // //                                 );
// // //                               } else {
// // //                                 ScaffoldMessenger.of(context).showSnackBar(
// // //                                   const SnackBar(content: Text("Failed to remove from cart.")),
// // //                                 );
// // //                               }
// // //                             }
// // //                           },
// // //                         ),
// // //                       ],
// // //                     ),

// // //                     /// Divider
// // //                     const Divider(thickness: 1.0, height: 30.0),

// // //                     /// Sides Information
// // //                     if (sides.isNotEmpty)
// // //                       Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           const Text(
// // //                             "Sides:",
// // //                             style: TextStyle(
// // //                               fontSize: 16.0,
// // //                               fontWeight: FontWeight.bold,
// // //                               color: Color(0xFF555555),
// // //                             ),
// // //                           ),
// // //                           const SizedBox(height: 10.0),
// // //                           Container(
// // //                             decoration: BoxDecoration(
// // //                               color:  const Color(0xFFFD9D9D9).withOpacity(0.3), 
// // //                               borderRadius: BorderRadius.circular(10.0),
// // //                             ),
// // //                             child: Column(
// // //                               children: sides.map((side) {
// // //                                 final sideData = widget.sale.sides.firstWhere((s) => s.sideId == side.id);
// // //                                 return Container(
// // //                                   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
// // //                                   decoration: BoxDecoration(
// // //                                     border: Border(
// // //                                       bottom: BorderSide(
// // //                                         color: sides.last == side ? Colors.transparent : const Color(0xFFEEEEEE),
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                   child: Row(
// // //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                                     children: [
// // //                                       Row(
// // //                                         children: [
// // //                                           Icon(Icons.fastfood, size: 20, color: Colors.orange[800]),
// // //                                           const SizedBox(width: 10.0),
// // //                                           Text(
// // //                                             side.name,
// // //                                             style: const TextStyle(
// // //                                               fontSize: 14.0,
// // //                                               color: Color(0xFF444444),
// // //                                             ),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                       Text(
// // //                                         "\$${side.price.toStringAsFixed(2)} x${sideData.quantity}",
// // //                                         style: const TextStyle(
// // //                                           fontSize: 14.0,
// // //                                           fontWeight: FontWeight.bold,
// // //                                           color: Colors.black54,
// // //                                         ),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 );
// // //                               }).toList(),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:front/presentation/screens/commandScreen.dart';
// // import 'package:get/get.dart';
// // import 'package:front/presentation/controller/authentification_controller.dart';
// // import 'package:front/presentation/controller/cart_controller.dart';
// // import 'package:front/presentation/controller/pizza_controller.dart';
// // import 'package:front/presentation/controller/custom_pizza_controller.dart';
// // import 'package:front/presentation/controller/side_controller.dart';
// // import 'package:front/domain/entities/sale.dart';
// // import 'package:front/domain/entities/pizza.dart';
// // import 'package:front/domain/entities/pizzaCustom.dart';
// // import 'package:front/domain/entities/sides.dart';

// // class CartScreen extends StatefulWidget {
// //   const CartScreen({super.key});

// //   @override
// //   State<CartScreen> createState() => _CartScreenState();
// // }

// // class _CartScreenState extends State<CartScreen> {
// //   late CartController _cartController;
// //   late PizzaController _pizzaController;
// //   late CustomPizzaController _customPizzaController;
// //   late String currentUserId;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _cartController = Get.find<CartController>();
// //     _pizzaController = Get.find<PizzaController>();
// //     _customPizzaController = Get.find<CustomPizzaController>();

// //     final AuthenticationController authenticationController = Get.find();
// //     currentUserId = authenticationController.currentUser.id!;

// //     print("Fetching cart for user $currentUserId");

// //     // Fetch cart data for the current user
// //     _cartController.getCartByUser(currentUserId).then((_) {
// //       print("Cart fetched successfully: ${_cartController.allSales}");
// //     }).catchError((error) {
// //       print("Error fetching cart: $error");
// //     });

// //     // Load the cart for UI updates
// //     _cartController.loadCart(currentUserId);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFB17C46),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFFB17C46),
// //         centerTitle: true,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
// //             child: const Text(
// //               'Your Cart',
// //               style: TextStyle(
// //                 fontSize: 48,
// //                 fontWeight: FontWeight.bold,
// //                 color: Color(0xFF790303),
// //                 fontFamily: 'Yellowtail',
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: GetBuilder<CartController>(
// //               id: 'cart_update',
// //               builder: (cartController) {
// //                 final cartSales = cartController.allSales;

// //                 return cartSales.isNotEmpty
// //                     ? ListView.builder(
// //                         padding: const EdgeInsets.all(16.0),
// //                         itemCount: cartSales.length,
// //                         itemBuilder: (context, index) {
// //                           final sale = cartSales[index];
// //                           return CartSaleCard(sale: sale);
// //                         },
// //                       )
// //                     : const Center(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
// //                             SizedBox(height: 10),
// //                             Text(
// //                               'Your cart is empty. Add some pizzas!',
// //                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //               },
// //             ),
// //           ),
// //           _buildCartTotal(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCartTotal() {
// //     return Container(
// //       padding: const EdgeInsets.all(16.0),
// //       decoration: const BoxDecoration(
// //         color: Color(0xFFB17C46),
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(20),
// //           topRight: Radius.circular(20),
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [
// //           GetBuilder<CartController>(
// //             id: 'cart_total',
// //             builder: (cartController) {
// //               return Text(
// //                 "Total Price: \$${cartController.cartTotalPrice.toStringAsFixed(2)}",
// //                 style: const TextStyle(
// //                   fontSize: 20,
// //                   fontFamily: 'Lobster',
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               );
// //             },
// //           ),
// //           const SizedBox(height: 15),
// //           SizedBox(
// //             width: double.infinity,
// //             child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                     builder: (context) => CommandScreen(),
// //                   ),
// //                 );
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xFF790303),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //               ),
// //               child: const Padding(
// //                 padding: EdgeInsets.all(12.0),
// //                 child: Text(
// //                   'Checkout',
// //                   style: TextStyle(
// //                     fontSize: 21,
// //                     fontFamily: 'Roboto',
// //                     color: Color(0xFFD8CAB8),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class CartSaleCard extends StatefulWidget {
// //   final Sale sale;

// //   const CartSaleCard({super.key, required this.sale});

// //   @override
// //   State<CartSaleCard> createState() => _CartSaleCardState();
// // }

// // class _CartSaleCardState extends State<CartSaleCard> {
// //   final PizzaController pizzaController = Get.find<PizzaController>();
// //   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
// //   final SideController sideController = Get.find<SideController>();

// //   late Future<dynamic> _pizzaFuture;
// //   late Future<List<Side>> _sidesFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Fetch pizza or custom pizza based on pizzaType
// //     if (widget.sale.pizzaType == 'Pizza') {
// //       _pizzaFuture = pizzaController.getPizzatById(widget.sale.pizzaId).then((_) => pizzaController.selectedPizza);
// //     } else if (widget.sale.pizzaType == 'PizzaCustom') {
// //       _pizzaFuture = customPizzaController.getCustomPizzaById(widget.sale.pizzaId).then((_) => customPizzaController.pizza);
// //     } else {
// //       _pizzaFuture = Future.value(null);
// //     }

// //     // Fetch sides
// //     _sidesFuture = _fetchSides(widget.sale.sides);
// //   }

// //   Future<List<Side>> _fetchSides(List<SaleSide> sides) async {
// //     List<Side> fetchedSides = [];
// //     for (var side in sides) {
// //       final success = await sideController.getSideById(side.sideId);
// //       if (success) {
// //         fetchedSides.add(sideController.selectedSide!);
// //       }
// //     }
// //     return fetchedSides;
// //   }

// //   Widget _buildPizzaDetails(dynamic pizza) {
// //     if (pizza is Pizza) {
// //       return Text(
// //         pizza.name ?? 'Unknown Pizza',
// //         style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //       );
// //     } else if (pizza is PizzaCustom) {
// //       return Text(
// //         pizza.name ?? 'Unknown Custom Pizza',
// //         style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
// //       );
// //     } else {
// //       return const Text('Pizza details not found');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<dynamic>(
// //       future: _pizzaFuture,
// //       builder: (context, pizzaSnapshot) {
// //         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
// //           return const Padding(
// //             padding: EdgeInsets.all(16.0),
// //             child: Center(child: CircularProgressIndicator()),
// //           );
// //         }

// //         if (!pizzaSnapshot.hasData) {
// //           return ListTile(
// //             title: const Text('Pizza details not found'),
// //             subtitle: Text('Quantity: ${widget.sale.pizzaQuantity}'),
// //           );
// //         }

// //         final pizza = pizzaSnapshot.data;

// //         return FutureBuilder<List<Side>>(
// //           future: _sidesFuture,
// //           builder: (context, sidesSnapshot) {
// //             if (sidesSnapshot.connectionState == ConnectionState.waiting) {
// //               return const Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Center(child: CircularProgressIndicator()),
// //               );
// //             }

// //             final sides = sidesSnapshot.data ?? [];

// //             return Card(
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
// //               elevation: 5.0,
// //               margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// //               color: const Color(0xFFFD9D9D9),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     /// Pizza Information
// //                     Row(
// //                       children: [
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(12.0),
// //                           child: pizza?.image != null && pizza!.image.isNotEmpty
// //                               ? Image.network(
// //                                   pizza.image,
// //                                   width: 90,
// //                                   height: 90,
// //                                   fit: BoxFit.cover,
// //                                 )
// //                               : const Icon(Icons.image_not_supported, size: 70, color: Colors.grey),
// //                         ),
// //                         const SizedBox(width: 16.0),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               _buildPizzaDetails(pizza),
// //                               const SizedBox(height: 6.0),
// //                               Text(
// //                                 'Quantity: ${widget.sale.pizzaQuantity}',
// //                                 style: const TextStyle(fontSize: 14.0, color: Colors.black),
// //                               ),
// //                               const SizedBox(height: 6.0),
// //                               Text(
// //                                 'Total: \$${widget.sale.totalPrice.toStringAsFixed(2)}',
// //                                 style: const TextStyle(
// //                                   fontSize: 16.0,
// //                                   fontWeight: FontWeight.bold,
// //                                   color: Color(0xFF000000),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         IconButton(
// //                           icon: const Icon(Icons.delete, color: Color(0xFF790303)),
// //                           onPressed: () async {
// //                             final CartController cartController = Get.find<CartController>();
// //                             if (widget.sale.id != null && widget.sale.userId != null) {
// //                               print("Removing sale with ID: ${widget.sale.id}");
// //                               bool success = await cartController.removeSaleFromCart(widget.sale.userId!, widget.sale.id!);

// //                               if (success) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(content: Text("Removed from cart successfully!")),
// //                                 );
// //                               } else {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(content: Text("Failed to remove from cart.")),
// //                                 );
// //                               }
// //                             }
// //                           },
// //                         ),
// //                       ],
// //                     ),

// //                     /// Divider
// //                     const Divider(thickness: 1.0, height: 30.0),

// //                     /// Sides Information
// //                     if (sides.isNotEmpty)
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           const Text(
// //                             "Sides:",
// //                             style: TextStyle(
// //                               fontSize: 16.0,
// //                               fontWeight: FontWeight.bold,
// //                               color: Color(0xFF555555),
// //                             ),
// //                           ),
// //                           const SizedBox(height: 10.0),
// //                           Container(
// //                             decoration: BoxDecoration(
// //                               color: const Color(0xFFFD9D9D9).withOpacity(0.3),
// //                               borderRadius: BorderRadius.circular(10.0),
// //                             ),
// //                             child: Column(
// //                               children: sides.map((side) {
// //                                 final sideData = widget.sale.sides.firstWhere((s) => s.sideId == side.id);
// //                                 return Container(
// //                                   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
// //                                   decoration: BoxDecoration(
// //                                     border: Border(
// //                                       bottom: BorderSide(
// //                                         color: sides.last == side ? Colors.transparent : const Color(0xFFEEEEEE),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Row(
// //                                         children: [
// //                                           Icon(Icons.fastfood, size: 20, color: Colors.orange[800]),
// //                                           const SizedBox(width: 10.0),
// //                                           Text(
// //                                             side.name,
// //                                             style: const TextStyle(
// //                                               fontSize: 14.0,
// //                                               color: Color(0xFF444444),
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Text(
// //                                         "\$${side.price.toStringAsFixed(2)} x${sideData.quantity}",
// //                                         style: const TextStyle(
// //                                           fontSize: 14.0,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: Colors.black54),
// //                                         ),
                                      
// //                                     ],
// //                                   ),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:front/presentation/screens/commandScreen.dart';
// import 'package:get/get.dart';
// import 'package:front/presentation/controller/authentification_controller.dart';
// import 'package:front/presentation/controller/cart_controller.dart';
// import 'package:front/presentation/controller/pizza_controller.dart';
// import 'package:front/presentation/controller/custom_pizza_controller.dart';
// import 'package:front/presentation/controller/side_controller.dart';
// import 'package:front/domain/entities/sale.dart';
// import 'package:front/domain/entities/pizza.dart';
// import 'package:front/domain/entities/pizzaCustom.dart';
// import 'package:front/domain/entities/sides.dart';
// import 'package:lottie/lottie.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   late CartController _cartController;
//   late PizzaController _pizzaController;
//   late CustomPizzaController _customPizzaController;
//   late String currentUserId;

//   @override
//   void initState() {
//     super.initState();
//     _cartController = Get.find<CartController>();
//     _pizzaController = Get.find<PizzaController>();
//     _customPizzaController = Get.find<CustomPizzaController>();

//     final AuthenticationController authenticationController = Get.find();
//     currentUserId = authenticationController.currentUser.id!;

//     print("Fetching cart for user $currentUserId");

//     // Fetch cart data for the current user
//     _cartController.getCartByUser(currentUserId).then((_) {
//       print("Cart fetched successfully: ${_cartController.allSales}");
//     }).catchError((error) {
//       print("Error fetching cart: $error");
//     });

//     // Load the cart for UI updates
//     _cartController.loadCart(currentUserId);
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
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
//             child: const Text(
//               'Your Cart',
//               style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF790303),
//                 fontFamily: 'Yellowtail'
//               ),
//             ),
//           ),
//           Expanded(
//             child: GetBuilder<CartController>(
//               id: 'cart_update',
//               builder: (cartController) {
//                 final cartSales = cartController.allSales;

//                 return cartSales.isNotEmpty
//                     ? ListView.builder(
//                         padding: const EdgeInsets.all(16.0),
//                         itemCount: cartSales.length,
//                         itemBuilder: (context, index) {
//                           final sale = cartSales[index];
//                           return CartSaleCard(sale: sale);
//                         },
//                       )
//                     :  Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Lottie.asset(
//                                   'assets/animation/cart1.json', 
//                                   width: 500, 
//                                   height: 400,
//                                 ),
//                                 const SizedBox(height:2),
//                                  const Text(
//                               'Your cart is empty. Add some pizzas!',
//                               style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold,fontFamily: "Italianno"),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       );
//               },
//             ),
//           ),
//           _buildCartTotal(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCartTotal() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: const BoxDecoration(
//         color: Color(0xFFB17C46),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           GetBuilder<CartController>(
//             id: 'cart_total',
//             builder: (cartController) {
//               return Text(
//                 "Total Price: \$${cartController.cartTotalPrice.toStringAsFixed(2)}",
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontFamily: 'Lobster',
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 15),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => CommandScreen(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF790303),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Checkout',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontFamily: 'Roboto',
//                     color: Color(0xFFD8CAB8),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CartSaleCard extends StatefulWidget {
//   final Sale sale;

//   const CartSaleCard({super.key, required this.sale});

//   @override
//   State<CartSaleCard> createState() => _CartSaleCardState();
// }

// class _CartSaleCardState extends State<CartSaleCard> {
//   final PizzaController pizzaController = Get.find<PizzaController>();
//   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
//   final SideController sideController = Get.find<SideController>();

//   late Future<dynamic> _pizzaFuture;
//   late Future<List<Side>> _sidesFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Log the pizzaType and pizzaId
//     print("Fetching pizza with pizzaType: ${widget.sale.pizzaType}, pizzaId: ${widget.sale.pizzaId}");

//     // Fetch pizza or custom pizza based on pizzaType
//     if (widget.sale.pizzaType == 'Pizza') {
//       print("Fetching Pizza from /api/pizzas/");
//       _pizzaFuture = pizzaController.getPizzatById(widget.sale.pizzaId).then((_) {
//         print("Pizza fetched: ${pizzaController.selectedPizza?.name}");
//         return pizzaController.selectedPizza;
//       });
//     } else if (widget.sale.pizzaType == 'PizzaCustom') {
//       print("Fetching CustomPizza from /api/pizzaCustom/");
//       _pizzaFuture = customPizzaController.getCustomPizzaById(widget.sale.pizzaId).then((_) {
//         print("CustomPizza fetched: ${customPizzaController.pizza?.name}");
//         return customPizzaController.pizza;
//       });
//     } else {
//       print("Unknown pizzaType: ${widget.sale.pizzaType}");
//       _pizzaFuture = Future.value(null);
//     }

//     // Fetch sides
//     _sidesFuture = _fetchSides(widget.sale.sides);
//   }

//   Future<List<Side>> _fetchSides(List<SaleSide> sides) async {
//     List<Side> fetchedSides = [];
//     for (var side in sides) {
//       final success = await sideController.getSideById(side.sideId);
//       if (success) {
//         fetchedSides.add(sideController.selectedSide!);
//       }
//     }
//     return fetchedSides;
//   }

//   Widget _buildPizzaDetails(dynamic pizza) {
//     if (pizza is Pizza) {
//       return Text(
//         pizza.name ?? 'Unknown Pizza',
//         style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//       );
//     } else if (pizza is PizzaCustom) {
//       return Text(
//         pizza.name ?? 'Unknown Custom Pizza',
//         style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//       );
//     } else {
//       return const Text('Pizza details not found');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<dynamic>(
//       future: _pizzaFuture,
//       builder: (context, pizzaSnapshot) {
//         if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
//           return const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (!pizzaSnapshot.hasData) {
//           return ListTile(
//             title: const Text('Pizza details not found'),
//             subtitle: Text('Quantity: ${widget.sale.pizzaQuantity}'),
//           );
//         }

//         final pizza = pizzaSnapshot.data;

//         return FutureBuilder<List<Side>>(
//           future: _sidesFuture,
//           builder: (context, sidesSnapshot) {
//             if (sidesSnapshot.connectionState == ConnectionState.waiting) {
//               return const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             }

//             final sides = sidesSnapshot.data ?? [];

//             return Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//               elevation: 5.0,
//               margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//               color: const Color(0xFFFD9D9D9),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// Pizza Information
//                     Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12.0),
//                           child: pizza?.image != null && pizza!.image.isNotEmpty
//                               ? Image.network(
//                                   pizza.image,
//                                   width: 90,
//                                   height: 90,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Image.asset(
//           'assets/images/customPizza.png', 
//           width: 90,
//           height: 90,
//           fit: BoxFit.cover,
//         ),
//                         ),
//                         const SizedBox(width: 16.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildPizzaDetails(pizza),
//                               const SizedBox(height: 6.0),
//                               Text(
//                                 'Quantity: ${widget.sale.pizzaQuantity}',
//                                 style: const TextStyle(fontSize: 14.0, color: Colors.black),
//                               ),
//                               const SizedBox(height: 6.0),
//                               Text(
//                                 'Total: \$${widget.sale.totalPrice.toStringAsFixed(2)}',
//                                 style: const TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Color(0xFF790303)),
//                           onPressed: () async {
//                             final CartController cartController = Get.find<CartController>();
//                             if (widget.sale.id != null && widget.sale.userId != null) {
//                               print("Removing sale with ID: ${widget.sale.id}");
//                               bool success = await cartController.removeSaleFromCart(widget.sale.userId!, widget.sale.id!);

//                               if (success) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text("Removed from cart successfully!")),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text("Failed to remove from cart.")),
//                                 );
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     ),

//                     /// Divider
//                     const Divider(thickness: 1.0, height: 30.0),

//                     /// Sides Information
//                     if (sides.isNotEmpty)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Sides:",
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF555555),
//                             ),
//                           ),
//                           const SizedBox(height: 10.0),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFFD9D9D9).withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             child: Column(
//                               children: sides.map((side) {
//                                 final sideData = widget.sale.sides.firstWhere((s) => s.sideId == side.id);
//                                 return Container(
//                                   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                       bottom: BorderSide(
//                                         color: sides.last == side ? Colors.transparent : const Color(0xFFEEEEEE),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(Icons.fastfood, size: 20, color: Colors.orange[800]),
//                                           const SizedBox(width: 10.0),
//                                           Text(
//                                             side.name,
//                                             style: const TextStyle(
//                                               fontSize: 14.0,
//                                               color: Color(0xFF444444),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         "\$${side.price.toStringAsFixed(2)} x${sideData.quantity}",
//                                         style: const TextStyle(
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black54),
//                                         ),
                                      
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:front/presentation/screens/commandScreen.dart';
import 'package:get/get.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/cart_controller.dart';
import 'package:front/presentation/controller/pizza_controller.dart';
import 'package:front/presentation/controller/custom_pizza_controller.dart';
import 'package:front/presentation/controller/side_controller.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/entities/sides.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartController _cartController;
  late PizzaController _pizzaController;
  late CustomPizzaController _customPizzaController;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    _cartController = Get.find<CartController>();
    _pizzaController = Get.find<PizzaController>();
    _customPizzaController = Get.find<CustomPizzaController>();

    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;

    print("Fetching cart for user $currentUserId");

    // Fetch cart data for the current user
    _cartController.getCartByUser(currentUserId).then((_) {
      print("Cart fetched successfully: ${_cartController.allSales}");
    }).catchError((error) {
      print("Error fetching cart: $error");
    });

    // Load the cart for UI updates
    _cartController.loadCart(currentUserId);
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: const Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF790303),
                fontFamily: 'Yellowtail',
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CartController>(
              id: 'cart_update',
              builder: (cartController) {
                final cartSales = cartController.allSales;

                return cartSales.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: cartSales.length,
                        itemBuilder: (context, index) {
                          final sale = cartSales[index];
                          return CartSaleCard(sale: sale);
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animation/cart1.json',
                            width: 500,
                            height: 400,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Your cart is empty. Add some pizzas!',
                            style: TextStyle(
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Italianno",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
              },
            ),
          ),
          // Conditionally render the total and checkout button only if the cart is not empty
          GetBuilder<CartController>(
            id: 'cart_update',
            builder: (cartController) {
              return cartController.allSales.isNotEmpty ? _buildCartTotal() : Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartTotal() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFB17C46),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GetBuilder<CartController>(
            id: 'cart_total',
            builder: (cartController) {
              return Text(
                "Total Price: \$${cartController.cartTotalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommandScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF790303),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 21,
                    fontFamily: 'Roboto',
                    color: Color(0xFFD8CAB8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartSaleCard extends StatefulWidget {
  final Sale sale;

  const CartSaleCard({super.key, required this.sale});

  @override
  State<CartSaleCard> createState() => _CartSaleCardState();
}

class _CartSaleCardState extends State<CartSaleCard> {
  final PizzaController pizzaController = Get.find<PizzaController>();
  final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
  final SideController sideController = Get.find<SideController>();

  late Future<dynamic> _pizzaFuture;
  late Future<List<Side>> _sidesFuture;

  @override
  void initState() {
    super.initState();
    // Log the pizzaType and pizzaId
    print("Fetching pizza with pizzaType: ${widget.sale.pizzaType}, pizzaId: ${widget.sale.pizzaId}");

    // Fetch pizza or custom pizza based on pizzaType
    if (widget.sale.pizzaType == 'Pizza') {
      print("Fetching Pizza from /api/pizzas/");
      _pizzaFuture = pizzaController.getPizzatById(widget.sale.pizzaId).then((_) {
        print("Pizza fetched: ${pizzaController.selectedPizza?.name}");
        return pizzaController.selectedPizza;
      });
    } else if (widget.sale.pizzaType == 'PizzaCustom') {
      print("Fetching CustomPizza from /api/pizzaCustom/");
      _pizzaFuture = customPizzaController.getCustomPizzaById(widget.sale.pizzaId).then((_) {
        print("CustomPizza fetched: ${customPizzaController.pizza?.name}");
        return customPizzaController.pizza;
      });
    } else {
      print("Unknown pizzaType: ${widget.sale.pizzaType}");
      _pizzaFuture = Future.value(null);
    }

    // Fetch sides
    _sidesFuture = _fetchSides(widget.sale.sides);
  }

  Future<List<Side>> _fetchSides(List<SaleSide> sides) async {
    List<Side> fetchedSides = [];
    for (var side in sides) {
      final success = await sideController.getSideById(side.sideId);
      if (success) {
        fetchedSides.add(sideController.selectedSide!);
      }
    }
    return fetchedSides;
  }

  Widget _buildPizzaDetails(dynamic pizza) {
    if (pizza is Pizza) {
      return Text(
        pizza.name ?? 'Unknown Pizza',
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      );
    } else if (pizza is PizzaCustom) {
      return Text(
        pizza.name ?? 'Unknown Custom Pizza',
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text('Pizza details not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _pizzaFuture,
      builder: (context, pizzaSnapshot) {
        if (pizzaSnapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!pizzaSnapshot.hasData) {
          return ListTile(
            title: const Text('Pizza details not found'),
            subtitle: Text('Quantity: ${widget.sale.pizzaQuantity}'),
          );
        }

        final pizza = pizzaSnapshot.data;

        return FutureBuilder<List<Side>>(
          future: _sidesFuture,
          builder: (context, sidesSnapshot) {
            if (sidesSnapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final sides = sidesSnapshot.data ?? [];

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              color: const Color(0xFFFD9D9D9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Pizza Information
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: pizza?.image != null && pizza!.image.isNotEmpty
                              ? Image.network(
                                  pizza.image,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/customPizza.png',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPizzaDetails(pizza),
                              const SizedBox(height: 6.0),
                              Text(
                                'Quantity: ${widget.sale.pizzaQuantity}',
                                style: const TextStyle(fontSize: 14.0, color: Colors.black),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                'Total: \$${widget.sale.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Color(0xFF790303)),
                          onPressed: () async {
                            final CartController cartController = Get.find<CartController>();
                            if (widget.sale.id != null && widget.sale.userId != null) {
                              print("Removing sale with ID: ${widget.sale.id}");
                              bool success = await cartController.removeSaleFromCart(widget.sale.userId!, widget.sale.id!);

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Removed from cart successfully!")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Failed to remove from cart.")),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),

                    /// Divider
                    const Divider(thickness: 1.0, height: 30.0),

                    /// Sides Information
                    if (sides.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sides:",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF555555),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFD9D9D9).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: sides.map((side) {
                                final sideData = widget.sale.sides.firstWhere((s) => s.sideId == side.id);
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: sides.last == side ? Colors.transparent : const Color(0xFFEEEEEE),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.fastfood, size: 20, color: Colors.orange[800]),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            side.name,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Color(0xFF444444),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "\$${side.price.toStringAsFixed(2)} x${sideData.quantity}",
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}