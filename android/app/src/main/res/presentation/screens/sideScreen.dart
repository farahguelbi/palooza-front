// // import 'package:flutter/material.dart';
// // import 'package:front/domain/entities/sale.dart';
// // import 'package:front/presentation/controller/sale_controller.dart';
// // import 'package:get/get.dart';
// // import 'package:front/presentation/controller/side_controller.dart';
// // import 'package:front/domain/entities/sides.dart';

// // class SideScreen extends StatefulWidget {
// //    final String saleId;
// //   const SideScreen({Key? key,required this.saleId}) : super(key: key);

// //   @override
// //   _SideScreenState createState() => _SideScreenState();
// // }

// // class _SideScreenState extends State<SideScreen> {
// //   late SaleController saleController;
// //   late SideController sideController;
  
// //   double totalPrice = 0.0;
// //   Map<String, int> quantities = {};

// //   @override
// //   void initState() {
// //     super.initState();
// //     saleController=Get.find<SaleController>();
// //     sideController = Get.find<SideController>();
// //     print('SideController initialized in SideScreen');
// //     print("SideScreen initialized with saleId: ${widget.saleId}");

// //     sideController.getAllsides();
// //   }
  

// //   /// Increment side quantity and update total price
// //   void incrementSide(Side side) {
// //     setState(() {
// //       quantities[side.id] = (quantities[side.id] ?? 0) + 1;
// //       totalPrice += side.price;
// //     });
// //   }

// //   /// Decrement side quantity and update total price
// //   void decrementSide(Side side) {
// //     if (quantities[side.id] != null && quantities[side.id]! > 0) {
// //       setState(() {
// //         quantities[side.id] = quantities[side.id]! - 1;
// //         totalPrice -= side.price;
// //       });
// //     }
// //   }

// //   /// Handle "Order Now" button press
// //   void orderNow() async {
// //     // if (quantities.isEmpty || quantities.values.every((q) => q == 0)) {
// //     //   ScaffoldMessenger.of(context).showSnackBar(
// //     //     const SnackBar(content: Text("Please select at least one side.")),
// //     //   );
// //     //   return;
// //     // }

// //     // Extract selected sides
// //     List<SaleSide> selectedSides = quantities.entries
// //         // .where((entry) => entry.value > 0)
// //         .map((entry) => SaleSide(sideId: entry.key, quantity: entry.value))
// //         .toList();
        

// //     // Add sides to the sale
// //     await saleController.addMultipleSidesToSale(
// //       widget.saleId, // Use the passed saleId
// //       selectedSides,
// //       totalPrice,
// //     );

// //     // Show success message
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text("Sides added successfully! Total: \$${totalPrice.toStringAsFixed(2)}")),
// //     );

// //     // Reset after order
// //     setState(() {
// //       quantities.clear();
// //       totalPrice = 0.0;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFB17C46), // Background color
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF790303),
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
       
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               // Title
// //               const Text(
// //                 'Add Sides',
// //                 style: TextStyle(
// //                   fontFamily: 'Yellowtail',
// //                   fontSize: 40,
// //                   fontWeight: FontWeight.bold,
// //                   color: Color(0xFF790303),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // Sides List
// //               GetBuilder<SideController>(
// //                 builder: (controller) {
// //                   if (controller.isLoading) {
// //                     return const Center(
// //                       child: CircularProgressIndicator(),
// //                     );
// //                   }

// //                   if (controller.msg.isNotEmpty) {
// //                     return Center(
// //                       child: Text(
// //                         controller.msg,
// //                         style: const TextStyle(fontSize: 18, color: Colors.white),
// //                       ),
// //                     );
// //                   }

// //                   return Column(
// //                     children: controller.AllSides.map((side) {
// //                       return SideCart(
// //                         side: side,
// //                         onIncrement: () => incrementSide(side),
// //                         onDecrement: () => decrementSide(side),
// //                         quantity: quantities[side.id] ?? 0,
// //                       );
// //                     }).toList(),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Total Price
// //               Align(
// //                 alignment: Alignment.centerRight,
// //                 child: Text(
// //                   "Total Price: \$${totalPrice.toStringAsFixed(2)}",
// //                   style: const TextStyle(
// //                     fontSize: 20,
// //                     fontFamily: 'Lobster',
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               // "Order Now" Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: orderNow,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFF790303),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(15),
// //                     ),
// //                   ),
// //                   child: const Padding(
// //                     padding: EdgeInsets.all(12.0),
// //                     child: Text(
// //                       'Order Now',
// //                       style: TextStyle(
// //                         fontSize: 21,
// //                         fontFamily: 'Roboto',
// //                         color: Color(0xFFD8CAB8),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class SideCart extends StatelessWidget {
// //   final Side side;
// //   final VoidCallback onIncrement;
// //   final VoidCallback onDecrement;
// //   final int quantity;

// //   const SideCart({
// //     Key? key,
// //     required this.side,
// //     required this.onIncrement,
// //     required this.onDecrement,
// //     required this.quantity,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6.0),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: const Color(0xFFFD9D9D9).withOpacity(0.8),
// //           borderRadius: BorderRadius.circular(15),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black12,
// //               spreadRadius: 2,
// //               blurRadius: 5,
// //               offset: const Offset(0, 3),
// //             ),
// //           ],
// //         ),
// //         child: ListTile(
// //           title: Text(
// //             side.name,
// //             style: const TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 18,
// //             ),
// //           ),
// //           subtitle: Text(
// //             "\$${side.price.toStringAsFixed(2)}",
// //             style: const TextStyle(color: Colors.black54, fontSize: 14),
// //           ),
// //           trailing: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               IconButton(
// //                 icon: const Icon(Icons.remove_circle, color: Color(0xFF790303)),
// //                 onPressed: quantity > 0 ? onDecrement : null,
// //               ),
// //               Text(
// //                 "$quantity",
// //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.add_circle, color: Color(0xFF790303)),
// //                 onPressed: onIncrement,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:front/data/models/sale_model.dart';
// import 'package:front/domain/entities/sale.dart';
// import 'package:front/presentation/controller/authentification_controller.dart';
// import 'package:front/presentation/controller/cart_controller.dart';
// import 'package:front/presentation/controller/sale_controller.dart';
// import 'package:front/presentation/screens/CartScreen.dart';
// import 'package:get/get.dart';
// import 'package:front/presentation/controller/side_controller.dart';
// import 'package:front/domain/entities/sides.dart';

// class SideScreen extends StatefulWidget {
//   final String saleId;
//   const SideScreen({Key? key, required this.saleId}) : super(key: key);

//   @override
//   _SideScreenState createState() => _SideScreenState();
// }

// class _SideScreenState extends State<SideScreen> {
//   late SaleController saleController;
//   late SideController sideController;
//   late CartController cartController;

//   double totalSidePrice = 0.0;
//   double pizzaPrice = 0.0; 
//   double finalTotalPrice = 0.0; // The actual total price (pizza + sides)
//   Map<String, int> quantities = {};

//   @override
//   void initState() {
//     super.initState();

//     saleController = Get.find<SaleController>();
//     sideController = Get.find<SideController>();
//     cartController = Get.find<CartController>();

//     print("✅ SideScreen initialized with saleId: ${widget.saleId}");
    
//     // Fetch available sides
//     sideController.getAllsides();
    
//     // Fetch pizza price
//     fetchPizzaPrice();
  
//   }
// Future<void> fetchPizzaPrice() async {
//   try {
//     print(" Fetching sale for ID: ${widget.saleId}...");
//     SaleModel? sale = await saleController.getSaleById(widget.saleId);

//     if (sale != null) {
//       print(" Sale found! API Data: ${sale.toJson()}");
//       print("Sale found! Pizza price before setState: ${sale.totalPrice}");

//       setState(() {
//         pizzaPrice = sale.totalPrice;
//         updateFinalTotalPrice(); 
//       });

//       print(" Pizza price after setState: $pizzaPrice");
//     } else {
//       print(" Sale not found or null!");
//     }
//   } catch (e) {
//     print(" Error fetching pizza price: $e");
//   }
// }



//   /// Increment side quantity and update total price
//   void incrementSide(Side side) {
//     setState(() {
//       quantities[side.id] = (quantities[side.id] ?? 0) + 1;
//       totalSidePrice += side.price;
//       updateFinalTotalPrice();
//     });
//   }

//   /// Decrement side quantity and update total price
//   void decrementSide(Side side) {
//     if (quantities[side.id] != null && quantities[side.id]! > 0) {
//       setState(() {
//         quantities[side.id] = quantities[side.id]! - 1;
//         totalSidePrice -= side.price;
//         updateFinalTotalPrice();
//       });
//     }
//   }

//   /// Updates the final total price (pizza + sides)
//   void updateFinalTotalPrice() {
//     setState(() {
//       finalTotalPrice = pizzaPrice + totalSidePrice;
//       print(" Total updated: Pizza = \$${pizzaPrice.toStringAsFixed(2)}, Sides = \$${totalSidePrice.toStringAsFixed(2)}, Final = \$${finalTotalPrice.toStringAsFixed(2)}");
//     });
//   }

//   /// Handle "Order Now" button press
//   void orderNow() async {
//     List<SaleSide> selectedSides = quantities.entries
//         .map((entry) => SaleSide(sideId: entry.key, quantity: entry.value))
//         .toList();

//     // Send the total price (pizza + sides)
//     await saleController.addMultipleSidesToSale(
//       widget.saleId,
//       selectedSides,
//       finalTotalPrice,

//     );
   
//    // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Sides added successfully! Total: \$${finalTotalPrice.toStringAsFixed(2)}")),
//     );
    
// // Fetch the current user ID
//     final AuthenticationController authController = Get.find<AuthenticationController>();
//     final String? currentUserId = authController.currentUser.id;

//     if (currentUserId != null) {
//       // Try adding the sale to the cart
//       print(" Attempting to add sale ${widget.saleId} to cart...");
//       final addToCartResult = await cartController.addSaleToCart(
//         currentUserId,
//         widget.saleId,
//       );

//       if (addToCartResult) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Added to cart for \$${finalTotalPrice.toStringAsFixed(2)} Dinar(s)!'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to add to cart')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please log in to proceed with the purchase!')),
//       );
//     }

//     // Navigate to Cart Page
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => CartScreen(),
//       ),
//     );

//     // Reset selections
//     setState(() {
//       quantities.clear();
//       totalSidePrice = 0.0;
//       updateFinalTotalPrice();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//       print('thisID ${widget.saleId}');
//     return Scaffold(
//       backgroundColor: const Color(0xFFB17C46),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF790303),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text(
//                 'Add Sides',
//                 style: TextStyle(
//                   fontFamily: 'Yellowtail',
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF790303),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Sides List
//               GetBuilder<SideController>(
//                 builder: (controller) {
//                   if (controller.isLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   if (controller.msg.isNotEmpty) {
//                     return Center(
//                       child: Text(
//                         controller.msg,
//                         style: const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: controller.AllSides.map((side) {
//                       return SideCart(
//                         side: side,
//                         onIncrement: () => incrementSide(side),
//                         onDecrement: () => decrementSide(side),
//                         quantity: quantities[side.id] ?? 0,
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Price Breakdown
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: FutureBuilder(
//                   future:saleController.getSaleById(widget.saleId),
//                   builder: (context, snapshot) {
//                     print('this is the ${snapshot.data}');
//                     if(snapshot.hasData){

//                          return Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           "Pizza Price: \$${snapshot.data!.totalPrice.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Lobster',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Sides Price: \$${totalSidePrice.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Lobster',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Total Price: \$${finalTotalPrice.toStringAsFixed(2)}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Lobster',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     );  
//                     }else if(snapshot.connectionState==ConnectionState.waiting){
//                         return const CircularProgressIndicator();
//                     }else{
//                       return const Text('erreur!');
//                     }
                   
//                   }
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // "Order Now" Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: orderNow,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF790303),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text(
//                       'Order Now',
//                       style: TextStyle(
//                         fontSize: 21,
//                         fontFamily: 'Roboto',
//                         color: Color(0xFFD8CAB8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//  class SideCart extends StatelessWidget {
//   final Side side;
//   final VoidCallback onIncrement;
//   final VoidCallback onDecrement;
//   final int quantity;

//   const SideCart({
//     Key? key,
//     required this.side,
//     required this.onIncrement,
//     required this.onDecrement,
//     required this.quantity,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFFFD9D9D9).withOpacity(0.8),
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: ListTile(
//           title: Text(
//             side.name,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           subtitle: Text(
//             "\$${side.price.toStringAsFixed(2)}",
//             style: const TextStyle(color: Colors.black54, fontSize: 14),
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove_circle, color: Color(0xFF790303)),
//                 onPressed: quantity > 0 ? onDecrement : null,
//               ),
//               Text(
//                 "$quantity",
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add_circle, color: Color(0xFF790303)),
//                 onPressed: onIncrement,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:front/data/models/sale_model.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/cart_controller.dart';
import 'package:front/presentation/controller/sale_controller.dart';
import 'package:front/presentation/screens/CartScreen.dart';
import 'package:get/get.dart';
import 'package:front/presentation/controller/side_controller.dart';
import 'package:front/domain/entities/sides.dart';

class SideScreen extends StatefulWidget {
  final String saleId;
  const SideScreen({Key? key, required this.saleId}) : super(key: key);

  @override
  _SideScreenState createState() => _SideScreenState();
}

class _SideScreenState extends State<SideScreen> {
  late SaleController saleController;
  late SideController sideController;
  late CartController cartController;

  double totalSidePrice = 0.0;
  double pizzaPrice = 0.0;
  double finalTotalPrice = 0.0; // The actual total price (pizza + sides)
  Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();

    saleController = Get.find<SaleController>();
    sideController = Get.find<SideController>();
    cartController = Get.find<CartController>();

    print("✅ SideScreen initialized with saleId: ${widget.saleId}");

    // Defer state updates until after the build process
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch available sides
      sideController.getAllsides();

      // Fetch pizza price
      fetchPizzaPrice();
    });
  }

  Future<void> fetchPizzaPrice() async {
    try {
      print(" Fetching sale for ID: ${widget.saleId}...");
      SaleModel? sale = await saleController.getSaleById(widget.saleId);

      if (sale != null) {
        print(" Sale found! API Data: ${sale.toJson()}");
        print("Sale found! Pizza price before setState: ${sale.totalPrice}");

        setState(() {
          pizzaPrice = sale.totalPrice;
          updateFinalTotalPrice();
        });

        print(" Pizza price after setState: $pizzaPrice");
      } else {
        print(" Sale not found or null!");
      }
    } catch (e) {
      print(" Error fetching pizza price: $e");
    }
  }

  /// Increment side quantity and update total price
  void incrementSide(Side side) {
    setState(() {
      quantities[side.id] = (quantities[side.id] ?? 0) + 1;
      totalSidePrice += side.price;
      updateFinalTotalPrice();
    });
  }

  /// Decrement side quantity and update total price
  void decrementSide(Side side) {
    if (quantities[side.id] != null && quantities[side.id]! > 0) {
      setState(() {
        quantities[side.id] = quantities[side.id]! - 1;
        totalSidePrice -= side.price;
        updateFinalTotalPrice();
      });
    }
  }

  /// Updates the final total price (pizza + sides)
  void updateFinalTotalPrice() {
    setState(() {
      finalTotalPrice = pizzaPrice + totalSidePrice;
      print(
          " Total updated: Pizza = \$${pizzaPrice.toStringAsFixed(2)}, Sides = \$${totalSidePrice.toStringAsFixed(2)}, Final = \$${finalTotalPrice.toStringAsFixed(2)}");
    });
  }

  void orderNow() async {
    // Schedule the state update after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<SaleSide> selectedSides = quantities.entries
          .map((entry) => SaleSide(sideId: entry.key, quantity: entry.value))
          .toList();

      // Send the total price (pizza + sides)
      await saleController.addMultipleSidesToSale(
        widget.saleId,
        selectedSides,
        finalTotalPrice,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Sides added successfully! Total: \$${finalTotalPrice.toStringAsFixed(2)}")),
      );

      // Fetch the current user ID
      final AuthenticationController authController =
          Get.find<AuthenticationController>();
      final String? currentUserId = authController.currentUser.id;

      if (currentUserId != null) {
        // Try adding the sale to the cart
        print(" Attempting to add sale ${widget.saleId} to cart...");
        final addToCartResult = await cartController.addSaleToCart(
          currentUserId,
          widget.saleId,
        );

        if (addToCartResult) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Added to cart for \$${finalTotalPrice.toStringAsFixed(2)} Dinar(s)!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add to cart')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please log in to proceed with the purchase!')),
        );
      }

      // Navigate to Cart Page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartScreen(),
        ),
      );

      // Reset selections
      setState(() {
        quantities.clear();
        totalSidePrice = 0.0;
        updateFinalTotalPrice();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('thisID ${widget.saleId}');
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF790303),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Add Sides',
                style: TextStyle(
                  fontFamily: 'Yellowtail',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF790303),
                ),
              ),
              const SizedBox(height: 20),

              // Sides List
              GetBuilder<SideController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.msg.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.msg,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  }

                  return Column(
                    children: controller.AllSides.map((side) {
                      return SideCart(
                        side: side,
                        onIncrement: () => incrementSide(side),
                        onDecrement: () => decrementSide(side),
                        quantity: quantities[side.id] ?? 0,
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Price Breakdown
              Align(
                alignment: Alignment.centerRight,
                child: FutureBuilder(
                  future: saleController.getSaleById(widget.saleId),
                  builder: (context, snapshot) {
                    print('this is the ${snapshot.data}');
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Pizza Price: \$${snapshot.data!.totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lobster',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Sides Price: \$${totalSidePrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lobster',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Total Price: \$${finalTotalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lobster',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text('erreur!');
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),

              // "Order Now" Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: orderNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF790303),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Order Now',
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
        ),
      ),
    );
  }
}

class SideCart extends StatelessWidget {
  final Side side;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int quantity;

  const SideCart({
    Key? key,
    required this.side,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFD9D9D9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            side.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            "\$${side.price.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Color(0xFF790303)),
                onPressed: quantity > 0 ? onDecrement : null,
              ),
              Text(
                "$quantity",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF790303)),
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}