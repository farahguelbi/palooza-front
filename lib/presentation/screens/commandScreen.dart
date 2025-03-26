// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:get/get.dart';
// // // // // // // import '../../presentation/controller/authentification_controller.dart';
// // // // // // // import '../../presentation/controller/command_controller.dart';
// // // // // // // import '../../presentation/controller/cart_controller.dart';
// // // // // // // import '../../presentation/controller/sale_controller.dart';
// // // // // // // import '../../presentation/controller/side_controller.dart';
// // // // // // // import '../../presentation/controller/pizza_controller.dart';

// // // // // // // class CommandScreen extends StatefulWidget {
// // // // // // //   @override
// // // // // // //   _CommandScreenState createState() => _CommandScreenState();
// // // // // // // }

// // // // // // // class _CommandScreenState extends State<CommandScreen> {
// // // // // // //   final CartController cartController = Get.find<CartController>();
// // // // // // //   final SaleController saleController = Get.find<SaleController>();
// // // // // // //   final SideController sideController = Get.find<SideController>();
// // // // // // //   final CommandController commandController = Get.find<CommandController>();
// // // // // // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // // // // // //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// // // // // // //   final TextEditingController addressController = TextEditingController();
// // // // // // //   String selectedPaymentMethod = "Credit Card";
// // // // // // //   Map<String, String> sideNameCache = {};
// // // // // // //   Map<String, List<Map<String, dynamic>>> pizzaCache = {}; // Cache for pizzas
// // // // // // //   bool isLoading = false;
// // // // // // //   String errorMessage = '';

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     _initializeData();
// // // // // // //   }

// // // // // // //   Future<void> _initializeData() async {
// // // // // // //     setState(() => isLoading = true);
// // // // // // //     try {
// // // // // // //       final String userId = authenticationController.currentUser.id!;
// // // // // // //       await cartController.getCartByUser(userId);
// // // // // // //       await _populateSideNames();
// // // // // // //     } catch (error) {
// // // // // // //       errorMessage = 'Failed to load data: $error';
// // // // // // //     } finally {
// // // // // // //       setState(() => isLoading = false);
// // // // // // //     }
// // // // // // //   }

// // // // // // //   Future<void> _populateSideNames() async {
// // // // // // //     for (var sale in cartController.allSales) {
// // // // // // //       for (var side in sale.sides) {
// // // // // // //         if (!sideNameCache.containsKey(side.sideId)) {
// // // // // // //           final success = await sideController.getSideById(side.sideId);
// // // // // // //           if (success && sideController.selectedSide != null) {
// // // // // // //             sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // // // // //           } else {
// // // // // // //             sideNameCache[side.sideId] = "Unknown Side";
// // // // // // //           }
// // // // // // //         }
// // // // // // //       }
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     addressController.dispose();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   void _confirmOrder() {
// // // // // // //     if (addressController.text.isEmpty) {
// // // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// // // // // // //       );
// // // // // // //       return;
// // // // // // //     }

// // // // // // //     showDialog(
// // // // // // //       context: context,
// // // // // // //       builder: (context) => AlertDialog(
// // // // // // //         title: const Text("Confirm Order"),
// // // // // // //         content: Column(
// // // // // // //           mainAxisSize: MainAxisSize.min,
// // // // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //           children: [
// // // // // // //             Text("You have chosen to $selectedPaymentMethod."),
// // // // // // //             Text("Delivery Address: ${addressController.text}"),
// // // // // // //             const SizedBox(height: 10),
// // // // // // //             const Text("🛒 Order Items:"),
// // // // // // //             ...cartController.allSales.map(
// // // // // // //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// // // // // // //             ),
// // // // // // //             const SizedBox(height: 10),
// // // // // // //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //         actions: [
// // // // // // //           TextButton(
// // // // // // //             onPressed: () => Navigator.of(context).pop(),
// // // // // // //             child: const Text("Cancel"),
// // // // // // //           ),
// // // // // // //           TextButton(
// // // // // // //             onPressed: () async {
// // // // // // //               Navigator.of(context).pop();
// // // // // // //               bool success = await commandController.createNewCommand({
// // // // // // //                 "address": addressController.text,
// // // // // // //                 "paymentMethod": selectedPaymentMethod,
// // // // // // //               });
// // // // // // //               if (success) {
// // // // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// // // // // // //                 );
// // // // // // //               } else {
// // // // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // // // //                   const SnackBar(content: Text("❌ Order Failed!")),
// // // // // // //                 );
// // // // // // //               }
// // // // // // //             },
// // // // // // //             child: const Text("Confirm"),
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // // // // //       ),
// // // // // // //       body: isLoading
// // // // // // //           ? const Center(child: CircularProgressIndicator())
// // // // // // //           : SingleChildScrollView(
// // // // // // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// // // // // // //               child: Column(
// // // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                 children: [
// // // // // // //                   const SizedBox(height: 10),
// // // // // // //                   _buildSectionTitle("🛍 Order Summary"),
// // // // // // //                   const SizedBox(height: 10),
// // // // // // //                   Column(
// // // // // // //                     children: cartController.allSales.map((sale) {
// // // // // // //                       // Check if the pizza exists in the cache
// // // // // // //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// // // // // // //                         final pizzaList = pizzaCache[sale.pizzaId];
// // // // // // //                         return _buildOrderItem(
// // // // // // //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// // // // // // //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// // // // // // //                           quantity: sale.pizzaQuantity,
// // // // // // //                           price: sale.totalPrice,
// // // // // // //                           sides: sale.sides,
// // // // // // //                         );
// // // // // // //                       }

// // // // // // //                       // Fetch pizza data and update cache
// // // // // // //                       return FutureBuilder<bool>(
// // // // // // //                         future: pizzaController.getPizzatById(sale.pizzaId!),
// // // // // // //                         builder: (context, snapshot) {
// // // // // // //                           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // // // //                             return const CircularProgressIndicator();
// // // // // // //                           }
// // // // // // //                           if (!snapshot.hasData || !snapshot.data! || pizzaController.selectedPizza == null) {
// // // // // // //                             return const Text("Pizza details unavailable.");
// // // // // // //                           }

// // // // // // //                           final pizza = pizzaController.selectedPizza!;

// // // // // // //                           // Initialize pizza cache list if it doesn't exist for this pizzaId
// // // // // // //                           if (!pizzaCache.containsKey(sale.pizzaId!)) {
// // // // // // //                             pizzaCache[sale.pizzaId!] = []; // Initialize with an empty list
// // // // // // //                           }

// // // // // // //                           // Add pizza details to the list under the pizzaId
// // // // // // //                           pizzaCache[sale.pizzaId!]!.add({
// // // // // // //                             'image': pizza.image,
// // // // // // //                             'name': pizza.name,
// // // // // // //                           });

// // // // // // //                           // Trigger a rebuild only after fetching pizza data
// // // // // // //                           WidgetsBinding.instance.addPostFrameCallback((_) {
// // // // // // //                             setState(() {});
// // // // // // //                           });

// // // // // // //                           return _buildOrderItem(
// // // // // // //                             pizzaImage: pizza.image ?? '',
// // // // // // //                             pizzaName: pizza.name ?? 'Unknown Pizza',
// // // // // // //                             quantity: sale.pizzaQuantity,
// // // // // // //                             price: sale.totalPrice,
// // // // // // //                             sides: sale.sides,
// // // // // // //                           );
// // // // // // //                         },
// // // // // // //                       );
// // // // // // //                     }).toList(),
// // // // // // //                   ),
// // // // // // //                   const SizedBox(height: 40),
// // // // // // //                   _buildSectionTitle("📍 Delivery Address"),
// // // // // // //                   const SizedBox(height: 10),
// // // // // // //                   _buildAddressInput(),
// // // // // // //                   const SizedBox(height: 40),
// // // // // // //                   _buildSectionTitle("💳 Payment Method"),
// // // // // // //                   const SizedBox(height: 10),
// // // // // // //                   _buildPaymentMethod(),
// // // // // // //                   const SizedBox(height: 40),
// // // // // // //                   _buildSectionTitle("🏷 Order Total"),
// // // // // // //                   const SizedBox(height: 10),
// // // // // // //                   _buildTotalSection(cartController.cartTotalPrice),
// // // // // // //                   const SizedBox(height: 30),
// // // // // // //                   SizedBox(
// // // // // // //                     width: double.infinity,
// // // // // // //                     child: ElevatedButton(
// // // // // // //                       style: ElevatedButton.styleFrom(
// // // // // // //                         backgroundColor: Colors.green,
// // // // // // //                         padding: const EdgeInsets.symmetric(vertical: 14),
// // // // // // //                         shape: RoundedRectangleBorder(
// // // // // // //                           borderRadius: BorderRadius.circular(12),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                       onPressed: _confirmOrder,
// // // // // // //                       child: const Text(
// // // // // // //                         "Confirm Order",
// // // // // // //                         style: TextStyle(
// // // // // // //                           fontSize: 18,
// // // // // // //                           fontWeight: FontWeight.bold,
// // // // // // //                           color: Colors.white,
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                   const SizedBox(height: 30),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Widget _buildOrderItem({
// // // // // // //     required String? pizzaImage,
// // // // // // //     required String pizzaName,
// // // // // // //     required int quantity,
// // // // // // //     required double price,
// // // // // // //     required List<dynamic> sides,
// // // // // // //   }) {
// // // // // // //     return Card(
// // // // // // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // // // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // // // //       child: Padding(
// // // // // // //         padding: const EdgeInsets.all(12.0),
// // // // // // //         child: Row(
// // // // // // //           children: [
// // // // // // //             ClipRRect(
// // // // // // //               borderRadius: BorderRadius.circular(8),
// // // // // // //               child: pizzaImage != null && pizzaImage.isNotEmpty
// // // // // // //                   ? Image.network(
// // // // // // //                       pizzaImage,
// // // // // // //                       width: 60,
// // // // // // //                       height: 60,
// // // // // // //                       fit: BoxFit.cover,
// // // // // // //                     )
// // // // // // //                   : const Icon(
// // // // // // //                       Icons.image_not_supported,
// // // // // // //                       size: 60,
// // // // // // //                       color: Colors.grey,
// // // // // // //                     ),
// // // // // // //             ),
// // // // // // //             const SizedBox(width: 12),
// // // // // // //             Expanded(
// // // // // // //               child: Column(
// // // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                 children: [
// // // // // // //                   Text(
// // // // // // //                     pizzaName,
// // // // // // //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // // // //                   ),
// // // // // // //                   const SizedBox(height: 6),
// // // // // // //                   if (sides.isNotEmpty)
// // // // // // //                     Column(
// // // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                       children: [
// // // // // // //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// // // // // // //                         ...sides.map((side) {
// // // // // // //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// // // // // // //                           return Text("- $sideName x${side.quantity}");
// // // // // // //                         }).toList(),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //             Column(
// // // // // // //               children: [
// // // // // // //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// // // // // // //                 const SizedBox(height: 8),
// // // // // // //                 Text(
// // // // // // //                   "\$${price.toStringAsFixed(2)}",
// // // // // // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Widget _buildTotalSection(double total) {
// // // // // // //     return Text("Total: \$${total.toStringAsFixed(2)}",
// // // // // // //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // // // //   }

// // // // // // //   Widget _buildSectionTitle(String title) {
// // // // // // //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // // // //   }

// // // // // // //   Widget _buildPaymentMethod() {
// // // // // // //     return Card(
// // // // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // // // //       child: Padding(
// // // // // // //         padding: const EdgeInsets.all(12),
// // // // // // //         child: DropdownButton<String>(
// // // // // // //           value: selectedPaymentMethod,
// // // // // // //           isExpanded: true,
// // // // // // //           underline: const SizedBox(),
// // // // // // //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// // // // // // //             return DropdownMenuItem(
// // // // // // //                 value: method,
// // // // // // //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// // // // // // //           }).toList(),
// // // // // // //           onChanged: (value) {
// // // // // // //             setState(() => selectedPaymentMethod = value!);
// // // // // // //           },
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Widget _buildAddressInput() {
// // // // // // //     return TextField(
// // // // // // //       controller: addressController,
// // // // // // //       decoration: InputDecoration(
// // // // // // //         hintText: "Enter your delivery address",
// // // // // // //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// // // // // // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // // // // // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // // // import 'package:front/presentation/controller/command_controller.dart';
// // // // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // // // import 'package:front/presentation/controller/sale_controller.dart';
// // // // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // // // import 'package:get/get.dart';

// // // // // // class CommandScreen extends StatefulWidget {
// // // // // //   const CommandScreen({Key? key}) : super(key: key);

// // // // // //   @override
// // // // // //   _CommandScreenState createState() => _CommandScreenState();
// // // // // // }

// // // // // // class _CommandScreenState extends State<CommandScreen> {
// // // // // //   final CartController cartController = Get.find<CartController>();
// // // // // //   final SaleController saleController = Get.find<SaleController>();
// // // // // //   final SideController sideController = Get.find<SideController>();
// // // // // //   final CommandController commandController = Get.find<CommandController>();
// // // // // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // // // // //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// // // // // //   final TextEditingController addressController = TextEditingController();
// // // // // //   String selectedPaymentMethod = "Credit Card";
// // // // // //   Map<String, String> sideNameCache = {};
// // // // // //   Map<String, List<Map<String, dynamic>>> pizzaCache = {}; // Cache for pizzas
// // // // // //   bool isLoading = false;
// // // // // //   String errorMessage = '';

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _initializeData();
// // // // // //   }

// // // // // //   Future<void> _initializeData() async {
// // // // // //     setState(() => isLoading = true);
// // // // // //     try {
// // // // // //       final String userId = authenticationController.currentUser.id!;
// // // // // //       await cartController.getCartByUser(userId);
// // // // // //       await _populateSideNames();
// // // // // //     } catch (error) {
// // // // // //       errorMessage = 'Failed to load data: $error';
// // // // // //     } finally {
// // // // // //       if (mounted) {
// // // // // //         setState(() => isLoading = false);
// // // // // //       }
// // // // // //     }
// // // // // //   }

// // // // // //   Future<void> _populateSideNames() async {
// // // // // //     for (var sale in cartController.allSales) {
// // // // // //       for (var side in sale.sides) {
// // // // // //         if (!sideNameCache.containsKey(side.sideId)) {
// // // // // //           final success = await sideController.getSideById(side.sideId);
// // // // // //           if (success && sideController.selectedSide != null) {
// // // // // //             sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // // // //           } else {
// // // // // //             sideNameCache[side.sideId] = "Unknown Side";
// // // // // //           }
// // // // // //         }
// // // // // //       }
// // // // // //     }
// // // // // //   }

// // // // // //   Future<void> _fetchAndCachePizzaData(String pizzaId) async {
// // // // // //     final success = await pizzaController.getPizzatById(pizzaId);
// // // // // //     if (success && pizzaController.selectedPizza != null) {
// // // // // //       pizzaCache[pizzaId] = [
// // // // // //         {
// // // // // //           'image': pizzaController.selectedPizza!.image ?? 'default_image_url',
// // // // // //           'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
// // // // // //         }
// // // // // //       ];

// // // // // //       // Rebuild the UI after fetching and caching pizza data
// // // // // //       if (mounted) {
// // // // // //         setState(() {});
// // // // // //       }
// // // // // //     } else {
// // // // // //       print("Failed to fetch pizza data for pizzaId: $pizzaId");
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // // // //       ),
// // // // // //       body: isLoading
// // // // // //           ? const Center(child: CircularProgressIndicator())
// // // // // //           : SingleChildScrollView(
// // // // // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// // // // // //               child: Column(
// // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                 children: [
// // // // // //                   const SizedBox(height: 10),
// // // // // //                   _buildSectionTitle("🛍 Order Summary"),
// // // // // //                   const SizedBox(height: 10),
// // // // // //                   Column(
// // // // // //                     children: cartController.allSales.map((sale) {
// // // // // //                       // Check if the pizza exists in the cache
// // // // // //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// // // // // //                         final pizzaList = pizzaCache[sale.pizzaId];
// // // // // //                         return _buildOrderItem(
// // // // // //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// // // // // //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// // // // // //                           quantity: sale.pizzaQuantity,
// // // // // //                           price: sale.totalPrice,
// // // // // //                           sides: sale.sides,
// // // // // //                         );
// // // // // //                       }

// // // // // //                       // Fetch pizza data and update cache
// // // // // //                       _fetchAndCachePizzaData(sale.pizzaId!);
// // // // // //                       return const CircularProgressIndicator();
// // // // // //                     }).toList(),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 40),
// // // // // //                   _buildSectionTitle("📍 Delivery Address"),
// // // // // //                   const SizedBox(height: 10),
// // // // // //                   _buildAddressInput(),
// // // // // //                   const SizedBox(height: 40),
// // // // // //                   _buildSectionTitle("💳 Payment Method"),
// // // // // //                   const SizedBox(height: 10),
// // // // // //                   _buildPaymentMethod(),
// // // // // //                   const SizedBox(height: 40),
// // // // // //                   _buildSectionTitle("🏷 Order Total"),
// // // // // //                   const SizedBox(height: 10),
// // // // // //                   _buildTotalSection(cartController.cartTotalPrice),
// // // // // //                   const SizedBox(height: 30),
// // // // // //                   SizedBox(
// // // // // //                     width: double.infinity,
// // // // // //                     child: ElevatedButton(
// // // // // //                       style: ElevatedButton.styleFrom(
// // // // // //                         backgroundColor: Colors.green,
// // // // // //                         padding: const EdgeInsets.symmetric(vertical: 14),
// // // // // //                         shape: RoundedRectangleBorder(
// // // // // //                           borderRadius: BorderRadius.circular(12),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       onPressed: _confirmOrder,
// // // // // //                       child: const Text(
// // // // // //                         "Confirm Order",
// // // // // //                         style: TextStyle(
// // // // // //                           fontSize: 18,
// // // // // //                           fontWeight: FontWeight.bold,
// // // // // //                           color: Colors.white,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 30),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildOrderItem({
// // // // // //     required String? pizzaImage,
// // // // // //     required String pizzaName,
// // // // // //     required int quantity,
// // // // // //     required double price,
// // // // // //     required List<dynamic> sides,
// // // // // //   }) {
// // // // // //     return Card(
// // // // // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // // //       child: Padding(
// // // // // //         padding: const EdgeInsets.all(12.0),
// // // // // //         child: Row(
// // // // // //           children: [
// // // // // //             ClipRRect(
// // // // // //               borderRadius: BorderRadius.circular(8),
// // // // // //               child: pizzaImage != null && pizzaImage.isNotEmpty
// // // // // //                   ? Image.network(
// // // // // //                       pizzaImage,
// // // // // //                       width: 60,
// // // // // //                       height: 60,
// // // // // //                       fit: BoxFit.cover,
// // // // // //                     )
// // // // // //                   : const Icon(
// // // // // //                       Icons.image_not_supported,
// // // // // //                       size: 60,
// // // // // //                       color: Colors.grey,
// // // // // //                     ),
// // // // // //             ),
// // // // // //             const SizedBox(width: 12),
// // // // // //             Expanded(
// // // // // //               child: Column(
// // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                 children: [
// // // // // //                   Text(
// // // // // //                     pizzaName,
// // // // // //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 6),
// // // // // //                   if (sides.isNotEmpty)
// // // // // //                     Column(
// // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                       children: [
// // // // // //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// // // // // //                         ...sides.map((side) {
// // // // // //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// // // // // //                           return Text("- $sideName x${side.quantity}");
// // // // // //                         }).toList(),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //             Column(
// // // // // //               children: [
// // // // // //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// // // // // //                 const SizedBox(height: 8),
// // // // // //                 Text(
// // // // // //                   "\$${price.toStringAsFixed(2)}",
// // // // // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildTotalSection(double total) {
// // // // // //     return Text("Total: \$${total.toStringAsFixed(2)}",
// // // // // //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // // //   }

// // // // // //   Widget _buildSectionTitle(String title) {
// // // // // //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // // //   }

// // // // // //   Widget _buildPaymentMethod() {
// // // // // //     return Card(
// // // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // // //       child: Padding(
// // // // // //         padding: const EdgeInsets.all(12),
// // // // // //         child: DropdownButton<String>(
// // // // // //           value: selectedPaymentMethod,
// // // // // //           isExpanded: true,
// // // // // //           underline: const SizedBox(),
// // // // // //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// // // // // //             return DropdownMenuItem(
// // // // // //                 value: method,
// // // // // //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// // // // // //           }).toList(),
// // // // // //           onChanged: (value) {
// // // // // //             setState(() => selectedPaymentMethod = value!);
// // // // // //           },
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildAddressInput() {
// // // // // //     return TextField(
// // // // // //       controller: addressController,
// // // // // //       decoration: InputDecoration(
// // // // // //         hintText: "Enter your delivery address",
// // // // // //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// // // // // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // // // // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   void _confirmOrder() {
// // // // // //     if (addressController.text.isEmpty) {
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // // //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// // // // // //       );
// // // // // //       return;
// // // // // //     }

// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (context) => AlertDialog(
// // // // // //         title: const Text("Confirm Order"),
// // // // // //         content: Column(
// // // // // //           mainAxisSize: MainAxisSize.min,
// // // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //           children: [
// // // // // //             Text("You have chosen to $selectedPaymentMethod."),
// // // // // //             Text("Delivery Address: ${addressController.text}"),
// // // // // //             const SizedBox(height: 10),
// // // // // //             const Text("🛒 Order Items:"),
// // // // // //             ...cartController.allSales.map(
// // // // // //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// // // // // //             ),
// // // // // //             const SizedBox(height: 10),
// // // // // //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// // // // // //           ],
// // // // // //         ),
// // // // // //         actions: [
// // // // // //           TextButton(
// // // // // //             onPressed: () => Navigator.of(context).pop(),
// // // // // //             child: const Text("Cancel"),
// // // // // //           ),
// // // // // //           TextButton(
// // // // // //             onPressed: () async {
// // // // // //               Navigator.of(context).pop();
// // // // // //               bool success = await commandController.createNewCommand({
// // // // // //                 "userId":authenticationController.currentUser.id,
// // // // // //                 "address": addressController.text,
// // // // // //                 "paymentMethod": selectedPaymentMethod,
// // // // // //               });
// // // // // //               if (success) {
// // // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// // // // // //                 );
// // // // // //               } else {
// // // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                   const SnackBar(content: Text("❌ Order Failed!")),
// // // // // //                 );
// // // // // //               }
// // // // // //             },
// // // // // //             child: const Text("Confirm"),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // // import 'package:front/presentation/controller/command_controller.dart';
// // // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // // import 'package:front/presentation/controller/sale_controller.dart';
// // // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // // import 'package:get/get.dart';

// // // // // class CommandScreen extends StatefulWidget {
// // // // //   const CommandScreen({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   _CommandScreenState createState() => _CommandScreenState();
// // // // // }

// // // // // class _CommandScreenState extends State<CommandScreen> {
// // // // //   final CartController cartController = Get.find<CartController>();
// // // // //   final SaleController saleController = Get.find<SaleController>();
// // // // //   final SideController sideController = Get.find<SideController>();
// // // // //   final CommandController commandController = Get.find<CommandController>();
// // // // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // // // //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// // // // //   final TextEditingController addressController = TextEditingController();
// // // // //   String selectedPaymentMethod = "Credit Card";
// // // // //   Map<String, String> sideNameCache = {};
// // // // //   Map<String, List<Map<String, dynamic>>> pizzaCache = {}; // Cache for pizzas
// // // // //   bool isLoading = false;
// // // // //   String errorMessage = '';

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initializeData();
// // // // //   }

// // // // //   Future<void> _initializeData() async {
// // // // //     setState(() => isLoading = true);
// // // // //     try {
// // // // //       final String userId = authenticationController.currentUser.id!;
// // // // //       await cartController.getCartByUser(userId);
// // // // //           print("Cart data loaded: ${cartController.allSales.length} sales");

// // // // //       await _populateSideNames();
// // // // //     } catch (error) {
// // // // //       errorMessage = 'Failed to load data: $error';
// // // // //     } finally {
// // // // //       if (mounted) {
// // // // //         setState(() => isLoading = false);
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   // Future<void> _populateSideNames() async {
// // // // //   //   for (var sale in cartController.allSales) {
// // // // //   //     for (var side in sale.sides) {
// // // // //   //       if (!sideNameCache.containsKey(side.sideId)) {
// // // // //   //         final success = await sideController.getSideById(side.sideId);
// // // // //   //         if (success && sideController.selectedSide != null) {
// // // // //   //           sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // // //   //         } else {
// // // // //   //           sideNameCache[side.sideId] = "Unknown Side";
// // // // //   //         }
// // // // //   //       }
// // // // //   //     }
// // // // //   //   }
// // // // //   // }
// // // // // Future<void> _populateSideNames() async {
// // // // //   for (var sale in cartController.allSales) {
// // // // //     for (var side in sale.sides) {
// // // // //       if (!sideNameCache.containsKey(side.sideId)) {
// // // // //         final success = await sideController.getSideById(side.sideId);
// // // // //         if (success && sideController.selectedSide != null) {
// // // // //           sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // // //           print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// // // // //         } else {
// // // // //           sideNameCache[side.sideId] = "Unknown Side";
// // // // //           print("Failed to fetch side: ${side.sideId}");
// // // // //         }
// // // // //       }
// // // // //     }
// // // // //   }
// // // // // }
// // // // //   Future<void> _fetchAndCachePizzaData(String pizzaId) async {
// // // // //     final success = await pizzaController.getPizzatById(pizzaId);
// // // // //     if (success && pizzaController.selectedPizza != null) {
// // // // //       pizzaCache[pizzaId] = [
// // // // //         {
// // // // //           'image': pizzaController.selectedPizza!.image ?? 'default_image_url',
// // // // //           'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
// // // // //         }
// // // // //       ];

// // // // //       // Rebuild the UI after fetching and caching pizza data
// // // // //       if (mounted) {
// // // // //         setState(() {});
// // // // //       }
// // // // //     } else {
// // // // //       print("Failed to fetch pizza data for pizzaId: $pizzaId");
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // // //       ),
// // // // //       body: isLoading
// // // // //           ? const Center(child: CircularProgressIndicator())
// // // // //           : SingleChildScrollView(
// // // // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   const SizedBox(height: 10),
// // // // //                   _buildSectionTitle("🛍 Order Summary"),
// // // // //                   const SizedBox(height: 10),
// // // // //                   Column(
// // // // //                     children: cartController.allSales.map((sale) {
// // // // //                       // Check if the pizza exists in the cache
// // // // //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// // // // //                         final pizzaList = pizzaCache[sale.pizzaId];
// // // // //                         return _buildOrderItem(
// // // // //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// // // // //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// // // // //                           quantity: sale.pizzaQuantity,
// // // // //                           price: sale.totalPrice,
// // // // //                           sides: sale.sides,
// // // // //                         );
// // // // //                       }

// // // // //                       // Fetch pizza data and update cache
// // // // //                       _fetchAndCachePizzaData(sale.pizzaId!);
// // // // //                       return const CircularProgressIndicator();
// // // // //                     }).toList(),
// // // // //                   ),
// // // // //                   const SizedBox(height: 40),
// // // // //                   _buildSectionTitle("📍 Delivery Address"),
// // // // //                   const SizedBox(height: 10),
// // // // //                   _buildAddressInput(),
// // // // //                   const SizedBox(height: 40),
// // // // //                   _buildSectionTitle("💳 Payment Method"),
// // // // //                   const SizedBox(height: 10),
// // // // //                   _buildPaymentMethod(),
// // // // //                   const SizedBox(height: 40),
// // // // //                   _buildSectionTitle("🏷 Order Total"),
// // // // //                   const SizedBox(height: 10),
// // // // //                   _buildTotalSection(cartController.cartTotalPrice),
// // // // //                   const SizedBox(height: 30),
// // // // //                   SizedBox(
// // // // //                     width: double.infinity,
// // // // //                     child: ElevatedButton(
// // // // //                       style: ElevatedButton.styleFrom(
// // // // //                         backgroundColor: Colors.green,
// // // // //                         padding: const EdgeInsets.symmetric(vertical: 14),
// // // // //                         shape: RoundedRectangleBorder(
// // // // //                           borderRadius: BorderRadius.circular(12),
// // // // //                         ),
// // // // //                       ),
// // // // //                       onPressed: _confirmOrder,
// // // // //                       child: const Text(
// // // // //                         "Confirm Order",
// // // // //                         style: TextStyle(
// // // // //                           fontSize: 18,
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: Colors.white,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                   const SizedBox(height: 30),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildOrderItem({
// // // // //     required String? pizzaImage,
// // // // //     required String pizzaName,
// // // // //     required int quantity,
// // // // //     required double price,
// // // // //     required List<dynamic> sides,
// // // // //   }) {
// // // // //     return Card(
// // // // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.all(12.0),
// // // // //         child: Row(
// // // // //           children: [
// // // // //             ClipRRect(
// // // // //               borderRadius: BorderRadius.circular(8),
// // // // //               child: pizzaImage != null && pizzaImage.isNotEmpty
// // // // //                   ? Image.network(
// // // // //                       pizzaImage,
// // // // //                       width: 60,
// // // // //                       height: 60,
// // // // //                       fit: BoxFit.cover,
// // // // //                     )
// // // // //                   : const Icon(
// // // // //                       Icons.image_not_supported,
// // // // //                       size: 60,
// // // // //                       color: Colors.grey,
// // // // //                     ),
// // // // //             ),
// // // // //             const SizedBox(width: 12),
// // // // //             Expanded(
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Text(
// // // // //                     pizzaName,
// // // // //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //                   ),
// // // // //                   const SizedBox(height: 6),
// // // // //                   if (sides.isNotEmpty)
// // // // //                     Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       children: [
// // // // //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// // // // //                         ...sides.map((side) {
// // // // //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// // // // //                           return Text("- $sideName x${side.quantity}");
// // // // //                         }).toList(),
// // // // //                       ],
// // // // //                     ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //             Column(
// // // // //               children: [
// // // // //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// // // // //                 const SizedBox(height: 8),
// // // // //                 Text(
// // // // //                   "\$${price.toStringAsFixed(2)}",
// // // // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTotalSection(double total) {
// // // // //     return Text("Total: \$${total.toStringAsFixed(2)}",
// // // // //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // //   }

// // // // //   Widget _buildSectionTitle(String title) {
// // // // //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // // //   }

// // // // //   Widget _buildPaymentMethod() {
// // // // //     return Card(
// // // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.all(12),
// // // // //         child: DropdownButton<String>(
// // // // //           value: selectedPaymentMethod,
// // // // //           isExpanded: true,
// // // // //           underline: const SizedBox(),
// // // // //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// // // // //             return DropdownMenuItem(
// // // // //                 value: method,
// // // // //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// // // // //           }).toList(),
// // // // //           onChanged: (value) {
// // // // //             setState(() => selectedPaymentMethod = value!);
// // // // //           },
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildAddressInput() {
// // // // //     return TextField(
// // // // //       controller: addressController,
// // // // //       decoration: InputDecoration(
// // // // //         hintText: "Enter your delivery address",
// // // // //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// // // // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // // // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _confirmOrder() {
// // // // //     if (addressController.text.isEmpty) {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // // //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// // // // //       );
// // // // //       return;
// // // // //     }

// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) => AlertDialog(
// // // // //         title: const Text("Confirm Order"),
// // // // //         content: Column(
// // // // //           mainAxisSize: MainAxisSize.min,
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Text("You have chosen to $selectedPaymentMethod."),
// // // // //             Text("Delivery Address: ${addressController.text}"),
// // // // //             const SizedBox(height: 10),
// // // // //             const Text("🛒 Order Items:"),
// // // // //             ...cartController.allSales.map(
// // // // //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// // // // //             ),
// // // // //             const SizedBox(height: 10),
// // // // //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// // // // //           ],
// // // // //         ),
// // // // //         actions: [
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.of(context).pop(),
// // // // //             child: const Text("Cancel"),
// // // // //           ),
// // // // //           TextButton(
// // // // //             onPressed: () async {
// // // // //               Navigator.of(context).pop();
// // // // //               bool success = await commandController.createNewCommand({
// // // // //                 "userId": authenticationController.currentUser.id,
// // // // //                 "address": addressController.text,
// // // // //                 "paymentMethod": selectedPaymentMethod,
// // // // //               });
// // // // //               if (success) {
// // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// // // // //                 );
// // // // //               } else {
// // // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // // //                   const SnackBar(content: Text("❌ Order Failed!")),
// // // // //                 );
// // // // //               }
// // // // //             },
// // // // //             child: const Text("Confirm"),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // // import 'package:front/presentation/controller/cart_controller.dart';
// // // // import 'package:front/presentation/controller/command_controller.dart';
// // // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // // import 'package:front/presentation/controller/custom_pizza_controller.dart';
// // // // import 'package:front/presentation/controller/side_controller.dart';
// // // // import 'package:get/get.dart';

// // // // class CommandScreen extends StatefulWidget {
// // // //   const CommandScreen({Key? key}) : super(key: key);

// // // //   @override
// // // //   _CommandScreenState createState() => _CommandScreenState();
// // // // }

// // // // class _CommandScreenState extends State<CommandScreen> {
// // // //   final CartController cartController = Get.find<CartController>();
// // // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // // //   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
// // // //   final SideController sideController = Get.find<SideController>();
// // // //   final CommandController commandController = Get.find<CommandController>();
// // // //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// // // //   final TextEditingController addressController = TextEditingController();
// // // //   String selectedPaymentMethod = "Credit Card";
// // // //   Map<String, String> sideNameCache = {};
// // // //   Map<String, List<Map<String, dynamic>>> pizzaCache = {}; // Cache pour les pizzas
// // // //   bool isLoading = false;
// // // //   String errorMessage = '';

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _initializeData();
// // // //   }

// // // //   Future<void> _initializeData() async {
// // // //     setState(() => isLoading = true);
// // // //     try {
// // // //       final String userId = authenticationController.currentUser.id!;
// // // //       await cartController.getCartByUser(userId);
// // // //       print("Cart data loaded: ${cartController.allSales.length} sales");

// // // //       await _populateSideNames();
// // // //     } catch (error) {
// // // //       errorMessage = 'Failed to load data: $error';
// // // //       print("Error initializing data: $error");
// // // //     } finally {
// // // //       if (mounted) {
// // // //         setState(() => isLoading = false);
// // // //       }
// // // //     }
// // // //   }

// // // //   // Future<void> _populateSideNames() async {
// // // //   //   for (var sale in cartController.allSales) {
// // // //   //     for (var side in sale.sides) {
// // // //   //       if (!sideNameCache.containsKey(side.sideId)) {
// // // //   //         final success = await sideController.getSideById(side.sideId);
// // // //   //         if (success && sideController.selectedSide != null) {
// // // //   //           sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // //   //           print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// // // //   //         } else {
// // // //   //           sideNameCache[side.sideId] = "Unknown Side";
// // // //   //           print("Failed to fetch side: ${side.sideId}");
// // // //   //         }
// // // //   //       }
// // // //   //     }
// // // //   //   }
// // // //   // }
// // // //   Future<void> _populateSideNames() async {
// // // //   for (var sale in cartController.allSales) {
// // // //     for (var side in sale.sides) {
// // // //       if (!sideNameCache.containsKey(side.sideId)) {
// // // //         final success = await sideController.getSideById(side.sideId);
// // // //         if (success && sideController.selectedSide != null) {
// // // //           sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // // //         } else {
// // // //           sideNameCache[side.sideId] = "Unknown Side";
// // // //         }
// // // //         // Ensure the UI updates when a new side name is fetched
// // // //         if (mounted) {
// // // //           setState(() {});
// // // //         }
// // // //       }
// // // //     }
// // // //   }
// // // // }


// // // //   Future<void> _fetchAndCachePizzaData(String pizzaId, String pizzaType) async {
// // // //     if (pizzaType == 'Pizza') {
// // // //       final success = await pizzaController.getPizzatById(pizzaId);
// // // //       if (success && pizzaController.selectedPizza != null) {
// // // //         print("Fetched Pizza Image: ${pizzaController.selectedPizza!.image}");
// // // //         pizzaCache[pizzaId] = [
// // // //           {
// // // //             'image': pizzaController.selectedPizza!.image ?? 'assets/images/customPizza.png',
// // // //             'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
// // // //           }
// // // //         ];
// // // //       }
// // // //     } else if (pizzaType == 'PizzaCustom') {
// // // //       final success = await customPizzaController.getCustomPizzaById(pizzaId);
// // // //       if (success && customPizzaController.pizza != null) {
// // // //         print("Fetched Custom Pizza Image: ${customPizzaController.pizza!.image}");
// // // //         pizzaCache[pizzaId] = [
// // // //           {
// // // //             'image': customPizzaController.pizza!.image ?? 'assets/images/customPizza.png',
// // // //             'name': customPizzaController.pizza!.name ?? 'Unknown Custom Pizza',
// // // //           }
// // // //         ];
// // // //       }
// // // //     }

// // // //     // Rebuild the UI after fetching and caching pizza data
// // // //     if (mounted) {
// // // //       setState(() {});
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // //       ),
// // // //       body: isLoading
// // // //           ? const Center(child: CircularProgressIndicator())
// // // //           : SingleChildScrollView(
// // // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   const SizedBox(height: 10),
// // // //                   _buildSectionTitle("🛍 Order Summary"),
// // // //                   const SizedBox(height: 10),
// // // //                   Column(
// // // //                     children: cartController.allSales.map((sale) {
// // // //                       // Check if the pizza exists in the cache
// // // //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// // // //                         final pizzaList = pizzaCache[sale.pizzaId];
// // // //                         return _buildOrderItem(
// // // //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// // // //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// // // //                           quantity: sale.pizzaQuantity,
// // // //                           price: sale.totalPrice,
// // // //                           sides: sale.sides,
// // // //                         );
// // // //                       }

// // // //                       // Fetch pizza data and update cache
// // // //                       _fetchAndCachePizzaData(sale.pizzaId!, sale.pizzaType);
// // // //                       return const CircularProgressIndicator();
// // // //                     }).toList(),
// // // //                   ),
// // // //                   const SizedBox(height: 40),
// // // //                   _buildSectionTitle("📍 Delivery Address"),
// // // //                   const SizedBox(height: 10),
// // // //                   _buildAddressInput(),
// // // //                   const SizedBox(height: 40),
// // // //                   _buildSectionTitle("💳 Payment Method"),
// // // //                   const SizedBox(height: 10),
// // // //                   _buildPaymentMethod(),
// // // //                   const SizedBox(height: 40),
// // // //                   _buildSectionTitle("🏷 Order Total"),
// // // //                   const SizedBox(height: 10),
// // // //                   _buildTotalSection(cartController.cartTotalPrice),
// // // //                   const SizedBox(height: 30),
// // // //                   SizedBox(
// // // //                     width: double.infinity,
// // // //                     child: ElevatedButton(
// // // //                       style: ElevatedButton.styleFrom(
// // // //                         backgroundColor: Colors.green,
// // // //                         padding: const EdgeInsets.symmetric(vertical: 14),
// // // //                         shape: RoundedRectangleBorder(
// // // //                           borderRadius: BorderRadius.circular(12),
// // // //                         ),
// // // //                       ),
// // // //                       onPressed: _confirmOrder,
// // // //                       child: const Text(
// // // //                         "Confirm Order",
// // // //                         style: TextStyle(
// // // //                           fontSize: 18,
// // // //                           fontWeight: FontWeight.bold,
// // // //                           color: Colors.white,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 30),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //     );
// // // //   }

// // // //   Widget _buildOrderItem({
// // // //     required String? pizzaImage,
// // // //     required String pizzaName,
// // // //     required int quantity,
// // // //     required double price,
// // // //     required List<dynamic> sides,
// // // //   }) {
// // // //     return Card(
// // // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.all(12.0),
// // // //         child: Row(
// // // //           children: [
// // // //             ClipRRect(
// // // //               borderRadius: BorderRadius.circular(8),
// // // //               child: pizzaImage != null && pizzaImage.isNotEmpty
// // // //                   ? Image.network(
// // // //                       pizzaImage,
// // // //                       width: 60,
// // // //                       height: 60,
// // // //                       fit: BoxFit.cover,
// // // //                       errorBuilder: (context, error, stackTrace) {
// // // //                         return Image.asset(
// // // //                           'assets/images/customPizza.png',
// // // //                           width: 60,
// // // //                           height: 60,
// // // //                           fit: BoxFit.cover,
// // // //                         );
// // // //                       },
// // // //                     )
// // // //                   : Image.asset(
// // // //                       'assets/images/customPizza.png',
// // // //                       width: 60,
// // // //                       height: 60,
// // // //                       fit: BoxFit.cover,
// // // //                     ),
// // // //             ),
// // // //             const SizedBox(width: 12),
// // // //             Expanded(
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     pizzaName,
// // // //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                   ),
// // // //                   const SizedBox(height: 6),
// // // //                   if (sides.isNotEmpty)
// // // //                     Column(
// // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // //                       children: [
// // // //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// // // //                         ...sides.map((side) {
// // // //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// // // //                           return Text("- $sideName x${side.quantity}");
// // // //                         }).toList(),
// // // //                       ],
// // // //                     ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             Column(
// // // //               children: [
// // // //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// // // //                 const SizedBox(height: 8),
// // // //                 Text(
// // // //                   "\$${price.toStringAsFixed(2)}",
// // // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTotalSection(double total) {
// // // //     return Text("Total: \$${total.toStringAsFixed(2)}",
// // // //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // //   }

// // // //   Widget _buildSectionTitle(String title) {
// // // //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // // //   }

// // // //   Widget _buildPaymentMethod() {
// // // //     return Card(
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.all(12),
// // // //         child: DropdownButton<String>(
// // // //           value: selectedPaymentMethod,
// // // //           isExpanded: true,
// // // //           underline: const SizedBox(),
// // // //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// // // //             return DropdownMenuItem(
// // // //                 value: method,
// // // //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// // // //           }).toList(),
// // // //           onChanged: (value) {
// // // //             setState(() => selectedPaymentMethod = value!);
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildAddressInput() {
// // // //     return TextField(
// // // //       controller: addressController,
// // // //       decoration: InputDecoration(
// // // //         hintText: "Enter your delivery address",
// // // //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// // // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _confirmOrder() {
// // // //     if (addressController.text.isEmpty) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// // // //       );
// // // //       return;
// // // //     }

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text("Confirm Order"),
// // // //         content: Column(
// // // //           mainAxisSize: MainAxisSize.min,
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Text("You have chosen to $selectedPaymentMethod."),
// // // //             Text("Delivery Address: ${addressController.text}"),
// // // //             const SizedBox(height: 10),
// // // //             const Text("🛒 Order Items:"),
// // // //             ...cartController.allSales.map(
// // // //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// // // //             ),
// // // //             const SizedBox(height: 10),
// // // //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// // // //           ],
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.of(context).pop(),
// // // //             child: const Text("Cancel"),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () async {
// // // //               Navigator.of(context).pop();
// // // //               bool success = await commandController.createNewCommand({
// // // //                 "userId": authenticationController.currentUser.id,
// // // //                 "address": addressController.text,
// // // //                 "paymentMethod": selectedPaymentMethod,
// // // //               });
// // // //               if (success) {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// // // //                 );
// // // //               } else {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   const SnackBar(content: Text("❌ Order Failed!")),
// // // //                 );
// // // //               }
// // // //             },
// // // //             child: const Text("Confirm"),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:front/presentation/controller/authentification_controller.dart';
// // // import 'package:front/presentation/controller/cart_controller.dart';
// // // import 'package:front/presentation/controller/command_controller.dart';
// // // import 'package:front/presentation/controller/pizza_controller.dart';
// // // import 'package:front/presentation/controller/custom_pizza_controller.dart';
// // // import 'package:front/presentation/controller/side_controller.dart';
// // // import 'package:get/get.dart';

// // // class CommandScreen extends StatefulWidget {
// // //   const CommandScreen({Key? key}) : super(key: key);

// // //   @override
// // //   _CommandScreenState createState() => _CommandScreenState();
// // // }

// // // class _CommandScreenState extends State<CommandScreen> {
// // //   final CartController cartController = Get.find<CartController>();
// // //   final PizzaController pizzaController = Get.find<PizzaController>();
// // //   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
// // //   final SideController sideController = Get.find<SideController>();
// // //   final CommandController commandController = Get.find<CommandController>();
// // //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// // //   final TextEditingController addressController = TextEditingController();
// // //   String selectedPaymentMethod = "Credit Card";
// // //   Map<String, String> sideNameCache = {};
// // //   Map<String, List<Map<String, dynamic>>> pizzaCache = {}; // Cache for pizzas
// // //   bool isLoading = false;
// // //   String errorMessage = '';

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeData();
// // //   }

// // //   Future<void> _initializeData() async {
// // //     print("Initializing data...");
// // //     setState(() => isLoading = true);
// // //     try {
// // //       final String userId = authenticationController.currentUser.id!;
// // //       print("Fetching cart for user: $userId");
// // //       await cartController.getCartByUser(userId);
// // //       print("Cart data loaded: ${cartController.allSales.length} sales");

// // //       print("Populating side names...");
// // //       await _populateSideNames();
// // //     } catch (error) {
// // //       errorMessage = 'Failed to load data: $error';
// // //       print("Error initializing data: $error");
// // //     } finally {
// // //       if (mounted) {
// // //         setState(() => isLoading = false);
// // //         print("Data initialization complete.");
// // //       }
// // //     }
// // //   }

// // //   Future<void> _populateSideNames() async {
// // //     print("Starting to populate side names...");
// // //     for (var sale in cartController.allSales) {
// // //       print("Processing sale with pizzaId: ${sale.pizzaId}");
// // //       for (var side in sale.sides) {
// // //         print("Fetching side with sideId: ${side.sideId}");
// // //         if (!sideNameCache.containsKey(side.sideId)) {
// // //           final success = await sideController.getSideById(side.sideId);
// // //           if (success && sideController.selectedSide != null) {
// // //             sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// // //             print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// // //           } else {
// // //             sideNameCache[side.sideId] = "Unknown Side";
// // //             print("Failed to fetch side: ${side.sideId}");
// // //           }

// // //           // Trigger a UI update after caching the side name
// // //           if (mounted) {
// // //             setState(() {});
// // //             print("UI updated for sideId: ${side.sideId}");
// // //           }
// // //         } else {
// // //           print("Side already cached: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// // //         }
// // //       }
// // //     }
// // //     print("Finished populating side names.");
// // //   }

// // //   Future<void> _fetchAndCachePizzaData(String pizzaId, String pizzaType) async {
// // //     print("Fetching pizza data for pizzaId: $pizzaId, type: $pizzaType");
// // //     if (pizzaType == 'Pizza') {
// // //       final success = await pizzaController.getPizzatById(pizzaId);
// // //       if (success && pizzaController.selectedPizza != null) {
// // //         print("Fetched Pizza Image: ${pizzaController.selectedPizza!.image}");
// // //         pizzaCache[pizzaId] = [
// // //           {
// // //             'image': pizzaController.selectedPizza!.image ?? 'assets/images/customPizza.png',
// // //             'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
// // //           }
// // //         ];
// // //       }
// // //     } else if (pizzaType == 'PizzaCustom') {
// // //       final success = await customPizzaController.getCustomPizzaById(pizzaId);
// // //       if (success && customPizzaController.pizza != null) {
// // //         print("Fetched Custom Pizza Image: ${customPizzaController.pizza!.image}");
// // //         pizzaCache[pizzaId] = [
// // //           {
// // //             'image': customPizzaController.pizza!.image ?? 'assets/images/customPizza.png',
// // //             'name': customPizzaController.pizza!.name ?? 'Unknown Custom Pizza',
// // //           }
// // //         ];
// // //       }
// // //     }

// // //     // Rebuild the UI after fetching and caching pizza data
// // //     if (mounted) {
// // //       setState(() {});
// // //       print("UI updated for pizzaId: $pizzaId");
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // //       ),
// // //       body: isLoading
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : SingleChildScrollView(
// // //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   const SizedBox(height: 10),
// // //                   _buildSectionTitle("🛍 Order Summary"),
// // //                   const SizedBox(height: 10),
// // //                   Column(
// // //                     children: cartController.allSales.map((sale) {
// // //                       // Check if the pizza exists in the cache
// // //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// // //                         final pizzaList = pizzaCache[sale.pizzaId];
// // //                         return _buildOrderItem(
// // //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// // //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// // //                           quantity: sale.pizzaQuantity,
// // //                           price: sale.totalPrice,
// // //                           sides: sale.sides,
// // //                         );
// // //                       }

// // //                       // Fetch pizza data and update cache
// // //                       _fetchAndCachePizzaData(sale.pizzaId!, sale.pizzaType);
// // //                       return const CircularProgressIndicator();
// // //                     }).toList(),
// // //                   ),
// // //                   const SizedBox(height: 40),
// // //                   _buildSectionTitle("📍 Delivery Address"),
// // //                   const SizedBox(height: 10),
// // //                   _buildAddressInput(),
// // //                   const SizedBox(height: 40),
// // //                   _buildSectionTitle("💳 Payment Method"),
// // //                   const SizedBox(height: 10),
// // //                   _buildPaymentMethod(),
// // //                   const SizedBox(height: 40),
// // //                   _buildSectionTitle("🏷 Order Total"),
// // //                   const SizedBox(height: 10),
// // //                   _buildTotalSection(cartController.cartTotalPrice),
// // //                   const SizedBox(height: 30),
// // //                   SizedBox(
// // //                     width: double.infinity,
// // //                     child: ElevatedButton(
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.green,
// // //                         padding: const EdgeInsets.symmetric(vertical: 14),
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(12),
// // //                         ),
// // //                       ),
// // //                       onPressed: _confirmOrder,
// // //                       child: const Text(
// // //                         "Confirm Order",
// // //                         style: TextStyle(
// // //                           fontSize: 18,
// // //                           fontWeight: FontWeight.bold,
// // //                           color: Colors.white,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 30),
// // //                 ],
// // //               ),
// // //             ),
// // //     );
// // //   }

// // //   Widget _buildOrderItem({
// // //     required String? pizzaImage,
// // //     required String pizzaName,
// // //     required int quantity,
// // //     required double price,
// // //     required List<dynamic> sides,
// // //   }) {
// // //     print("Building order item for pizza: $pizzaName");
// // //     return Card(
// // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(12.0),
// // //         child: Row(
// // //           children: [
// // //             ClipRRect(
// // //               borderRadius: BorderRadius.circular(8),
// // //               child: pizzaImage != null && pizzaImage.isNotEmpty
// // //                   ? Image.network(
// // //                       pizzaImage,
// // //                       width: 60,
// // //                       height: 60,
// // //                       fit: BoxFit.cover,
// // //                       errorBuilder: (context, error, stackTrace) {
// // //                         print("Failed to load pizza image: $error");
// // //                         return Image.asset(
// // //                           'assets/images/customPizza.png',
// // //                           width: 60,
// // //                           height: 60,
// // //                           fit: BoxFit.cover,
// // //                         );
// // //                       },
// // //                     )
// // //                   : Image.asset(
// // //                       'assets/images/customPizza.png',
// // //                       width: 60,
// // //                       height: 60,
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     pizzaName,
// // //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                   ),
// // //                   const SizedBox(height: 6),
// // //                   if (sides.isNotEmpty)
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         ...sides.map((side) {
// // //                           print("Displaying side with sideId: ${side.sideId}");
// // //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// // //                           print("Side name: $sideName");
// // //                           return Text("- $sideName x${side.quantity}");
// // //                         }).toList(),
// // //                       ],
// // //                     ),
// // //                 ],
// // //               ),
// // //             ),
// // //             Column(
// // //               children: [
// // //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// // //                 const SizedBox(height: 8),
// // //                 Text(
// // //                   "\$${price.toStringAsFixed(2)}",
// // //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTotalSection(double total) {
// // //     return Text("Total: \$${total.toStringAsFixed(2)}",
// // //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // //   }

// // //   Widget _buildSectionTitle(String title) {
// // //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// // //   }

// // //   Widget _buildPaymentMethod() {
// // //     return Card(
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(12),
// // //         child: DropdownButton<String>(
// // //           value: selectedPaymentMethod,
// // //           isExpanded: true,
// // //           underline: const SizedBox(),
// // //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// // //             return DropdownMenuItem(
// // //                 value: method,
// // //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// // //           }).toList(),
// // //           onChanged: (value) {
// // //             setState(() => selectedPaymentMethod = value!);
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAddressInput() {
// // //     return TextField(
// // //       controller: addressController,
// // //       decoration: InputDecoration(
// // //         hintText: "Enter your delivery address",
// // //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// // //       ),
// // //     );
// // //   }

// // //   void _confirmOrder() {
// // //     print("Confirming order...");
// // //     if (addressController.text.isEmpty) {
// // //       print("Delivery address is empty.");
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// // //       );
// // //       return;
// // //     }

// // //     print("Showing confirmation dialog...");
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text("Confirm Order"),
// // //         content: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text("You have chosen to $selectedPaymentMethod."),
// // //             Text("Delivery Address: ${addressController.text}"),
// // //             const SizedBox(height: 10),
// // //             const Text("🛒 Order Items:"),
// // //             ...cartController.allSales.map(
// // //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// // //             ),
// // //             const SizedBox(height: 10),
// // //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// // //           ],
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () {
// // //               print("Order confirmation canceled.");
// // //               Navigator.of(context).pop();
// // //             },
// // //             child: const Text("Cancel"),
// // //           ),
// // //           TextButton(
// // //             onPressed: () async {
// // //               print("Order confirmed by user.");
// // //               Navigator.of(context).pop();
// // //               bool success = await commandController.createNewCommand({
// // //                 "userId": authenticationController.currentUser.id,
// // //                 "address": addressController.text,
// // //                 "paymentMethod": selectedPaymentMethod,
// // //               });
// // //               if (success) {
// // //                 print("Order confirmed successfully.");
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// // //                 );
// // //               } else {
// // //                 print("Order confirmation failed.");
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   const SnackBar(content: Text("❌ Order Failed!")),
// // //                 );
// // //               }
// // //             },
// // //             child: const Text("Confirm"),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:front/presentation/controller/authentification_controller.dart';
// // import 'package:front/presentation/controller/cart_controller.dart';
// // import 'package:front/presentation/controller/command_controller.dart';
// // import 'package:front/presentation/controller/pizza_controller.dart';
// // import 'package:front/presentation/controller/custom_pizza_controller.dart';
// // import 'package:front/presentation/controller/side_controller.dart';

// // class CommandScreen extends StatefulWidget {
// //   const CommandScreen({Key? key}) : super(key: key);

// //   @override
// //   _CommandScreenState createState() => _CommandScreenState();
// // }

// // class _CommandScreenState extends State<CommandScreen> {
// //   final CartController cartController = Get.find<CartController>();
// //   final PizzaController pizzaController = Get.find<PizzaController>();
// //   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
// //   final SideController sideController = Get.find<SideController>();
// //   final CommandController commandController = Get.find<CommandController>();
// //   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

// //   final TextEditingController addressController = TextEditingController();
// //   String selectedPaymentMethod = "Credit Card";
// //   Map<String, String> sideNameCache = {};
// //   Map<String, List<Map<String, dynamic>>> pizzaCache = {};
// //   bool isLoading = false;
// //   String errorMessage = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeData();
// //   }

// //   Future<void> _initializeData() async {
// //     print("Initializing data...");
// //     setState(() => isLoading = true);
// //     try {
// //       final String userId = authenticationController.currentUser.id!;
// //       print("Fetching cart for user: $userId");
// //       await cartController.getCartByUser(userId);
// //       print("Cart data loaded: ${cartController.allSales.length} sales");

// //       print("Populating side names...");
// //       await _populateSideNames();
// //     } catch (error) {
// //       errorMessage = 'Failed to load data: $error';
// //       print("Error initializing data: $error");
// //     } finally {
// //       if (mounted) {
// //         setState(() => isLoading = false);
// //         print("Data initialization complete.");
// //       }
// //     }
// //   }

// //   Future<void> _populateSideNames() async {
// //     print("Starting to populate side names...");
// //     for (var sale in cartController.allSales) {
// //       print("Processing sale with pizzaId: ${sale.pizzaId}");
// //       for (var side in sale.sides) {
// //         print("Fetching side with sideId: ${side.sideId}");
// //         if (!sideNameCache.containsKey(side.sideId)) {
// //           final success = await sideController.getSideById(side.sideId);
// //           if (success && sideController.selectedSide != null) {
// //             sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
// //             print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// //           } else {
// //             sideNameCache[side.sideId] = "Unknown Side";
// //             print("Failed to fetch side: ${side.sideId}");
// //           }

// //           // Trigger a UI update after caching the side name
// //           if (mounted) {
// //             setState(() {});
// //             print("UI updated for sideId: ${side.sideId}");
// //           }
// //         } else {
// //           print("Side already cached: ${side.sideId} -> ${sideNameCache[side.sideId]}");
// //         }
// //       }
// //     }
// //     print("Finished populating side names.");
// //   }

// //   Future<void> _fetchAndCachePizzaData(String pizzaId, String pizzaType) async {
// //     print("Fetching pizza data for pizzaId: $pizzaId, type: $pizzaType");
// //     if (pizzaType == 'Pizza') {
// //       final success = await pizzaController.getPizzatById(pizzaId);
// //       if (success && pizzaController.selectedPizza != null) {
// //         print("Fetched Pizza Image: ${pizzaController.selectedPizza!.image}");
// //         pizzaCache[pizzaId] = [
// //           {
// //             'image': pizzaController.selectedPizza!.image ?? 'assets/images/customPizza.png',
// //             'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
// //           }
// //         ];
// //       }
// //     } else if (pizzaType == 'PizzaCustom') {
// //       final success = await customPizzaController.getCustomPizzaById(pizzaId);
// //       if (success && customPizzaController.pizza != null) {
// //         print("Fetched Custom Pizza Image: ${customPizzaController.pizza!.image}");
// //         pizzaCache[pizzaId] = [
// //           {
// //             'image': customPizzaController.pizza!.image ?? 'assets/images/customPizza.png',
// //             'name': customPizzaController.pizza!.name ?? 'Unknown Custom Pizza',
// //           }
// //         ];
// //       }
// //     }

// //     // Rebuild the UI after fetching and caching pizza data
// //     if (mounted) {
// //       setState(() {});
// //       print("UI updated for pizzaId: $pizzaId");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// //       ),
// //       body: isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : SingleChildScrollView(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const SizedBox(height: 10),
// //                   _buildSectionTitle("🛍 Order Summary"),
// //                   const SizedBox(height: 10),
// //                   Column(
// //                     children: cartController.allSales.map((sale) {
// //                       // Check if the pizza exists in the cache
// //                       if (pizzaCache.containsKey(sale.pizzaId)) {
// //                         final pizzaList = pizzaCache[sale.pizzaId];
// //                         return _buildOrderItem(
// //                           pizzaImage: pizzaList?[0]['image'] ?? '',
// //                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
// //                           quantity: sale.pizzaQuantity,
// //                           price: sale.totalPrice,
// //                           sides: sale.sides,
// //                         );
// //                       }

// //                       // Fetch pizza data and update cache
// //                       _fetchAndCachePizzaData(sale.pizzaId!, sale.pizzaType);
// //                       return const CircularProgressIndicator();
// //                     }).toList(),
// //                   ),
// //                   const SizedBox(height: 40),
// //                   _buildSectionTitle("📍 Delivery Address"),
// //                   const SizedBox(height: 10),
// //                   _buildAddressInput(),
// //                   const SizedBox(height: 40),
// //                   _buildSectionTitle("💳 Payment Method"),
// //                   const SizedBox(height: 10),
// //                   _buildPaymentMethod(),
// //                   const SizedBox(height: 40),
// //                   _buildSectionTitle("🏷 Order Total"),
// //                   const SizedBox(height: 10),
// //                   _buildTotalSection(cartController.cartTotalPrice),
// //                   const SizedBox(height: 30),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.green,
// //                         padding: const EdgeInsets.symmetric(vertical: 14),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                       ),
// //                       onPressed: _confirmOrder,
// //                       child: const Text(
// //                         "Confirm Order",
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 30),
// //                 ],
// //               ),
// //             ),
// //     );
// //   }

// //   Widget _buildOrderItem({
// //     required String? pizzaImage,
// //     required String pizzaName,
// //     required int quantity,
// //     required double price,
// //     required List<dynamic> sides,
// //   }) {
// //     print("Building order item for pizza: $pizzaName");
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Row(
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: pizzaImage != null && pizzaImage.isNotEmpty
// //                   ? Image.network(
// //                       pizzaImage,
// //                       width: 60,
// //                       height: 60,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (context, error, stackTrace) {
// //                         print("Failed to load pizza image: $error");
// //                         return Image.asset(
// //                           'assets/images/customPizza.png',
// //                           width: 60,
// //                           height: 60,
// //                           fit: BoxFit.cover,
// //                         );
// //                       },
// //                     )
// //                   : Image.asset(
// //                       'assets/images/customPizza.png',
// //                       width: 60,
// //                       height: 60,
// //                       fit: BoxFit.cover,
// //                     ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     pizzaName,
// //                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                   ),
// //                   const SizedBox(height: 6),
// //                   if (sides.isNotEmpty)
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
// //                         ...sides.map((side) {
// //                           print("Displaying side with sideId: ${side.sideId}");
// //                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
// //                           print("Side name: $sideName");
// //                           return Text("- $sideName x${side.quantity}");
// //                         }).toList(),
// //                       ],
// //                     ),
// //                 ],
// //               ),
// //             ),
// //             Column(
// //               children: [
// //                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
// //                 const SizedBox(height: 8),
// //                 Text(
// //                   "\$${price.toStringAsFixed(2)}",
// //                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTotalSection(double total) {
// //     return Text("Total: \$${total.toStringAsFixed(2)}",
// //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// //   }

// //   Widget _buildSectionTitle(String title) {
// //     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
// //   }

// //   Widget _buildPaymentMethod() {
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: DropdownButton<String>(
// //           value: selectedPaymentMethod,
// //           isExpanded: true,
// //           underline: const SizedBox(),
// //           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
// //             return DropdownMenuItem(
// //                 value: method,
// //                 child: Text(method, style: const TextStyle(fontSize: 16)));
// //           }).toList(),
// //           onChanged: (value) {
// //             setState(() => selectedPaymentMethod = value!);
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAddressInput() {
// //     return TextField(
// //       controller: addressController,
// //       decoration: InputDecoration(
// //         hintText: "Enter your delivery address",
// //         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
// //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       ),
// //     );
// //   }

// //   void _confirmOrder() {
// //     print("Confirming order...");
// //     if (addressController.text.isEmpty) {
// //       print("Delivery address is empty.");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("⚠ Please enter a delivery address")),
// //       );
// //       return;
// //     }

// //     print("Showing confirmation dialog...");
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text("Confirm Order"),
// //         content: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("You have chosen to $selectedPaymentMethod."),
// //             Text("Delivery Address: ${addressController.text}"),
// //             const SizedBox(height: 10),
// //             const Text("🛒 Order Items:"),
// //             ...cartController.allSales.map(
// //               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
// //             ),
// //             const SizedBox(height: 10),
// //             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
// //           ],
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               print("Order confirmation canceled.");
// //               Navigator.of(context).pop();
// //             },
// //             child: const Text("Cancel"),
// //           ),
// //           TextButton(
// //             onPressed: () async {
// //               print("Order confirmed by user.");
// //               Navigator.of(context).pop();
// //               bool success = await commandController.createNewCommand({
// //                 "userId": authenticationController.currentUser.id,
// //                 "address": addressController.text,
// //                 "paymentMethod": selectedPaymentMethod,
// //               });
// //               if (success) {
// //                 print("Order confirmed successfully.");
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text("✅ Order Confirmed!")),
// //                 );
// //               } else {
// //                 print("Order confirmation failed.");
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text("❌ Order Failed!")),
// //                 );
// //               }
// //             },
// //             child: const Text("Confirm"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:front/presentation/controller/authentification_controller.dart';
// import 'package:front/presentation/controller/cart_controller.dart';
// import 'package:front/presentation/controller/command_controller.dart';
// import 'package:front/presentation/controller/pizza_controller.dart';
// import 'package:front/presentation/controller/custom_pizza_controller.dart';
// import 'package:front/presentation/controller/side_controller.dart';

// class CommandScreen extends StatefulWidget {
//   const CommandScreen({Key? key}) : super(key: key);

//   @override
//   _CommandScreenState createState() => _CommandScreenState();
// }

// class _CommandScreenState extends State<CommandScreen> {
//   final CartController cartController = Get.find<CartController>();
//   final PizzaController pizzaController = Get.find<PizzaController>();
//   final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
//   final SideController sideController = Get.find<SideController>();
//   final CommandController commandController = Get.find<CommandController>();
//   final AuthenticationController authenticationController = Get.find<AuthenticationController>();

//   final TextEditingController addressController = TextEditingController();
//   String selectedPaymentMethod = "Credit Card";
//   Map<String, String> sideNameCache = {};
//   Map<String, List<Map<String, dynamic>>> pizzaCache = {};
//   bool isLoading = false;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

// Future<void> _initializeData() async {
//   print("Initializing data...");
//   setState(() => isLoading = true);

//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     try {
//       final String userId = authenticationController.currentUser.id!;
//       print("Fetching cart for user: $userId");
//       await cartController.getCartByUser(userId);
//       print("Cart data loaded: ${cartController.allSales.length} sales");

//       print("Populating side names...");
//       await _populateSideNames();
//     } catch (error) {
//       errorMessage = 'Failed to load data: $error';
//       print("Error initializing data: $error");
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//         print("Data initialization complete.");
//       }
//     }
//   });
// }

//   Future<void> _populateSideNames() async {
//     print("Starting to populate side names...");
//     for (var sale in cartController.allSales) {
//       print("Processing sale with pizzaId: ${sale.pizzaId}");
//       for (var side in sale.sides) {
//         print("Fetching side with sideId: ${side.sideId}");
//         if (!sideNameCache.containsKey(side.sideId)) {
//           final success = await sideController.getSideById(side.sideId);
//           if (success && sideController.selectedSide != null) {
//             sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
//             print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
//           } else {
//             sideNameCache[side.sideId] = "Unknown Side";
//             print("Failed to fetch side: ${side.sideId}");
//           }

//           // Trigger a UI update after caching the side name
//           if (mounted) {
//             setState(() {});
//             print("UI updated for sideId: ${side.sideId}");
//           }
//         } else {
//           print("Side already cached: ${side.sideId} -> ${sideNameCache[side.sideId]}");
//         }
//       }
//     }
//     print("Finished populating side names.");
//   }

//   Future<void> _fetchAndCachePizzaData(String pizzaId, String pizzaType) async {
//     print("Fetching pizza data for pizzaId: $pizzaId, type: $pizzaType");
//     if (pizzaType == 'Pizza') {
//       final success = await pizzaController.getPizzatById(pizzaId);
//       if (success && pizzaController.selectedPizza != null) {
//         print("Fetched Pizza Image: ${pizzaController.selectedPizza!.image}");
//         pizzaCache[pizzaId] = [
//           {
//             'image': pizzaController.selectedPizza!.image ?? 'assets/images/customPizza.png',
//             'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
//           }
//         ];
//       }
//     } else if (pizzaType == 'PizzaCustom') {
//       final success = await customPizzaController.getCustomPizzaById(pizzaId);
//       if (success && customPizzaController.pizza != null) {
//         print("Fetched Custom Pizza Image: ${customPizzaController.pizza!.image}");
//         pizzaCache[pizzaId] = [
//           {
//             'image': customPizzaController.pizza!.image ?? 'assets/images/customPizza.png',
//             'name': customPizzaController.pizza!.name ?? 'Unknown Custom Pizza',
//           }
//         ];
//       }
//     }

//     // Rebuild the UI after fetching and caching pizza data
//     if (mounted) {
//       setState(() {});
//       print("UI updated for pizzaId: $pizzaId");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10),
//                   _buildSectionTitle("🛍 Order Summary"),
//                   const SizedBox(height: 10),
//                   Column(
//                     children: cartController.allSales.map((sale) {
//                       // Check if the pizza exists in the cache
//                       if (pizzaCache.containsKey(sale.pizzaId)) {
//                         final pizzaList = pizzaCache[sale.pizzaId];
//                         return _buildOrderItem(
//                           pizzaImage: pizzaList?[0]['image'] ?? '',
//                           pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
//                           quantity: sale.pizzaQuantity,
//                           price: sale.totalPrice,
//                           sides: sale.sides,
//                         );
//                       }

//                       // Fetch pizza data and update cache
//                       _fetchAndCachePizzaData(sale.pizzaId!, sale.pizzaType);
//                       return const CircularProgressIndicator();
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 40),
//                   _buildSectionTitle("📍 Delivery Address"),
//                   const SizedBox(height: 10),
//                   _buildAddressInput(),
//                   const SizedBox(height: 40),
//                   _buildSectionTitle("💳 Payment Method"),
//                   const SizedBox(height: 10),
//                   _buildPaymentMethod(),
//                   const SizedBox(height: 40),
//                   _buildSectionTitle("🏷 Order Total"),
//                   const SizedBox(height: 10),
//                   _buildTotalSection(cartController.cartTotalPrice),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: _confirmOrder,
//                       child: const Text(
//                         "Confirm Order",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildOrderItem({
//     required String? pizzaImage,
//     required String pizzaName,
//     required int quantity,
//     required double price,
//     required List<dynamic> sides,
//   }) {
//     print("Building order item for pizza: $pizzaName");
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: pizzaImage != null && pizzaImage.isNotEmpty
//                   ? Image.network(
//                       pizzaImage,
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         print("Failed to load pizza image: $error");
//                         return Image.asset(
//                           'assets/images/customPizza.png',
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         );
//                       },
//                     )
//                   : Image.asset(
//                       'assets/images/customPizza.png',
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                     ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pizzaName,
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   if (sides.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
//                         ...sides.map((side) {
//                           print("Displaying side with sideId: ${side.sideId}");
//                           final sideName = sideNameCache[side.sideId] ?? "Loading...";
//                           print("Side name: $sideName");
//                           return Text("- $sideName x${side.quantity}");
//                         }).toList(),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 Text("x$quantity", style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//                 Text(
//                   "\$${price.toStringAsFixed(2)}",
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTotalSection(double total) {
//     return Text("Total: \$${total.toStringAsFixed(2)}",
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }

//   Widget _buildPaymentMethod() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: DropdownButton<String>(
//           value: selectedPaymentMethod,
//           isExpanded: true,
//           underline: const SizedBox(),
//           items: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
//             return DropdownMenuItem(
//                 value: method,
//                 child: Text(method, style: const TextStyle(fontSize: 16)));
//           }).toList(),
//           onChanged: (value) {
//             setState(() => selectedPaymentMethod = value!);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressInput() {
//     return TextField(
//       controller: addressController,
//       decoration: InputDecoration(
//         hintText: "Enter your delivery address",
//         prefixIcon: const Icon(Icons.location_on, color: Colors.green),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//     );
//   }

//   void _confirmOrder() {
//     print("Confirming order...");
//     if (addressController.text.isEmpty) {
//       print("Delivery address is empty.");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("⚠ Please enter a delivery address")),
//       );
//       return;
//     }

//     print("Showing confirmation dialog...");
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Confirm Order"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("You have chosen to $selectedPaymentMethod."),
//             Text("Delivery Address: ${addressController.text}"),
//             const SizedBox(height: 10),
//             const Text("🛒 Order Items:"),
//             ...cartController.allSales.map(
//               (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
//             ),
//             const SizedBox(height: 10),
//             Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               print("Order confirmation canceled.");
//               Navigator.of(context).pop();
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               print("Order confirmed by user.");
//               Navigator.of(context).pop();
//               bool success = await commandController.createNewCommand({
//                 "userId": authenticationController.currentUser.id,
//                 "address": addressController.text,
//                 "paymentMethod": selectedPaymentMethod,
//               });
//               if (success) {
//                 print("Order confirmed successfully.");
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("✅ Order Confirmed!")),
//                 );
//               } else {
//                 print("Order confirmation failed.");
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("❌ Order Failed!")),
//                 );
//               }
//             },
//             child: const Text("Confirm"),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/cart_controller.dart';
import 'package:front/presentation/controller/command_controller.dart';
import 'package:front/presentation/controller/pizza_controller.dart';
import 'package:front/presentation/controller/custom_pizza_controller.dart';
import 'package:front/presentation/controller/side_controller.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({Key? key}) : super(key: key);

  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  final CartController cartController = Get.find<CartController>();
  final PizzaController pizzaController = Get.find<PizzaController>();
  final CustomPizzaController customPizzaController = Get.find<CustomPizzaController>();
  final SideController sideController = Get.find<SideController>();
  final CommandController commandController = Get.find<CommandController>();
  final AuthenticationController authenticationController = Get.find<AuthenticationController>();

  final TextEditingController addressController = TextEditingController();
  Map<String, String> sideNameCache = {};
  Map<String, List<Map<String, dynamic>>> pizzaCache = {};
  bool isLoading = false;
  String errorMessage = '';

  // Liste des méthodes de paiement disponibles
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'type': 'Credit Card',
            'image': 'assets/images/master.png',

      'cardNumber': '3566*******0508',
      'cardName': 'Delhi Card',
    },
    {
      'type': 'PayPal',
      'image': 'assets/images/PayPal.png',
      'cardNumber': 'paypal@example.com',
      'cardName': 'PayPal Account',
    },
    {
      'type': 'Cash on Delivery',
            'image': 'assets/images/pit1.png',
      'cardNumber': 'N/A',
      'cardName': 'Cash',
    },
  ];

  // Méthode de paiement sélectionnée
  String selectedPaymentMethod = 'Credit Card';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
  print("Initializing data...");
  setState(() => isLoading = true);

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      final String userId = authenticationController.currentUser.id!;
      print("Fetching cart for user: $userId");
      await cartController.getCartByUser(userId);
      print("Cart data loaded: ${cartController.allSales.length} sales");

      print("Populating side names...");
      await _populateSideNames();
    } catch (error) {
      errorMessage = 'Failed to load data: $error';
      print("Error initializing data: $error");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
        print("Data initialization complete.");
      }
    }
  });
}

  Future<void> _populateSideNames() async {
    print("Starting to populate side names...");
    for (var sale in cartController.allSales) {
      print("Processing sale with pizzaId: ${sale.pizzaId}");
      for (var side in sale.sides) {
        print("Fetching side with sideId: ${side.sideId}");
        if (!sideNameCache.containsKey(side.sideId)) {
          final success = await sideController.getSideById(side.sideId);
          if (success && sideController.selectedSide != null) {
            sideNameCache[side.sideId] = sideController.selectedSide!.name ?? "Unknown Side";
            print("Cached side: ${side.sideId} -> ${sideNameCache[side.sideId]}");
          } else {
            sideNameCache[side.sideId] = "Unknown Side";
            print("Failed to fetch side: ${side.sideId}");
          }

          // Trigger a UI update after caching the side name
          if (mounted) {
            setState(() {});
            print("UI updated for sideId: ${side.sideId}");
          }
        } else {
          print("Side already cached: ${side.sideId} -> ${sideNameCache[side.sideId]}");
        }
      }
    }
    print("Finished populating side names.");
  }

  Future<void> _fetchAndCachePizzaData(String pizzaId, String pizzaType) async {
    print("Fetching pizza data for pizzaId: $pizzaId, type: $pizzaType");
    if (pizzaType == 'Pizza') {
      final success = await pizzaController.getPizzatById(pizzaId);
      if (success && pizzaController.selectedPizza != null) {
        print("Fetched Pizza Image: ${pizzaController.selectedPizza!.image}");
        pizzaCache[pizzaId] = [
          {
            'image': pizzaController.selectedPizza!.image ?? 'assets/images/customPizza.png',
            'name': pizzaController.selectedPizza!.name ?? 'Unknown Pizza',
          }
        ];
      }
    } else if (pizzaType == 'PizzaCustom') {
      final success = await customPizzaController.getCustomPizzaById(pizzaId);
      if (success && customPizzaController.pizza != null) {
        print("Fetched Custom Pizza Image: ${customPizzaController.pizza!.image}");
        pizzaCache[pizzaId] = [
          {
            'image': customPizzaController.pizza!.image ?? 'assets/images/customPizza.png',
            'name': customPizzaController.pizza!.name ?? 'Unknown Custom Pizza',
          }
        ];
      }
    }

    // Rebuild the UI after fetching and caching pizza data
    if (mounted) {
      setState(() {});
      print("UI updated for pizzaId: $pizzaId");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color(0xFFF5F5DC),

      appBar: AppBar(
              backgroundColor: const Color(0xFFF5F5DC),

        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF790303)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("🛍 Order Summary"),
                  const SizedBox(height: 10),
                  ...cartController.allSales.map((sale) {
                    if (pizzaCache.containsKey(sale.pizzaId)) {
                      final pizzaList = pizzaCache[sale.pizzaId];
                      return _buildOrderItem(
                        pizzaImage: pizzaList?[0]['image'] ?? '',
                        pizzaName: pizzaList?[0]['name'] ?? 'Unknown Pizza',
                        quantity: sale.pizzaQuantity,
                        price: sale.totalPrice,
                        sides: sale.sides,
                      );
                    }
                    _fetchAndCachePizzaData(sale.pizzaId!, sale.pizzaType);
                    return const CircularProgressIndicator(color: Color(0xFF790303));
                  }).toList(),
                  const SizedBox(height: 20),
                  _buildSectionTitle("📍 Delivery Address"),
                  const SizedBox(height: 10),
                  _buildAddressInput(),
                  const SizedBox(height: 20),
                  _buildSectionTitle("💳 Payment Method"),
                  const SizedBox(height: 10),
                  _buildPaymentMethodSelector(), // Nouveau widget pour la sélection des méthodes de paiement
                  const SizedBox(height: 20),
                  _buildSectionTitle("🏷 Order Total"),
                  const SizedBox(height: 10),
                  _buildTotalSection(cartController.cartTotalPrice),
                  const SizedBox(height: 30),
                  _buildConfirmButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildOrderItem({
    required String? pizzaImage,
    required String pizzaName,
    required int quantity,
    required double price,
    required List<dynamic> sides,
  }) {
    return Card(
              color: const Color(0xFFFD9D9D9).withOpacity(0.8),

      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pizzaImage ?? 'assets/images/customPizza.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/customPizza.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pizzaName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  if (sides.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sides:", style: TextStyle(fontWeight: FontWeight.bold)),
                        ...sides.map((side) {
                          final sideName = sideNameCache[side.sideId] ?? "Loading...";
                          return Text("- $sideName x${side.quantity}");
                        }).toList(),
                      ],
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Text("x$quantity", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(double total) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              "\$${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF790303)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF790303)),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      
      children: paymentMethods.map((method) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPaymentMethod = method['type'];
            });
          },
          child: Card(
                      color: const Color(0xFFFD9D9D9).withOpacity(0.8),

            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: selectedPaymentMethod == method['type']
                    ? Color(0xFF790303)
                    : Colors.grey.withOpacity(0.2),
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
 if (method['image'] != null && method['image'].toString().isNotEmpty)
                    Image.asset(
                      method['image'] ?? 'assets/images/default.png',
                      width: 50,
                      height: 50,
                    ),                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method['type'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          method['cardName'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          method['cardNumber'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  if (selectedPaymentMethod == method['type'])
                    const Icon(Icons.check_circle, color: Color(0xFF790303)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddressInput() {
    return Card(
      elevation: 4,
                color: const Color(0xFFFD9D9D9).withOpacity(0.8),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: addressController,
          
          decoration: InputDecoration(
            
            hintText: "Enter your delivery address",
            prefixIcon: const Icon(Icons.location_on, color:Color(0xFF790303)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF790303),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: _confirmOrder,
        child: const Text(
          "Confirm Order",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _confirmOrder() {
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠ Please enter a delivery address")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Order"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You have chosen to $selectedPaymentMethod."),
            Text("Delivery Address: ${addressController.text}"),
            const SizedBox(height: 10),
            const Text("🛒 Order Items:"),
            ...cartController.allSales.map(
              (sale) => Text("- ${sale.pizzaId ?? 'Unknown'} x${sale.pizzaQuantity} (\$${sale.totalPrice})"),
            ),
            const SizedBox(height: 10),
            Text("💰 Total Price: \$${cartController.cartTotalPrice}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel", style: TextStyle(color: Color(0xFF790303))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              bool success = await commandController.createNewCommand({
                "userId": authenticationController.currentUser.id,
                "address": addressController.text,
                "paymentMethod": selectedPaymentMethod,
              });
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Order Confirmed!")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ Order Failed!")),
                );
              }
            },
            child: const Text("Confirm", style: TextStyle(color: Color(0xFF790303))),
          ),
        ],
      ),
    );
  }
}