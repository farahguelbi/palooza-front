import 'package:flutter/material.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/sale_controller.dart';
import 'package:front/presentation/controller/side_controller.dart';
import 'package:front/presentation/screens/sideScreen.dart';
import 'package:get/get.dart';

class PizzaDetailsScreen extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetailsScreen({Key? key, required this.pizza}) : super(key: key);

  @override
  _PizzaDetailsScreenState createState() => _PizzaDetailsScreenState();
}

class _PizzaDetailsScreenState extends State<PizzaDetailsScreen> {
  final SideController sideController = Get.put(SideController());
  final SaleController saleController = Get.put(SaleController());
  late String currentUserId;


  int quantity = 1;
  String selectedSize = "Medium";
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.pizza.sizes.medium * quantity;
    
 final authController = Get.find<AuthenticationController>();
 currentUserId = authController.currentUser.id!;

  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      updateTotalPrice();
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updateTotalPrice();
      });
    }
  }

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
      updateTotalPrice();
    });
  }

  void updateTotalPrice() {
    double pricePerPizza;
    if (selectedSize == "Small") {
      pricePerPizza = widget.pizza.sizes.small;
    } else if (selectedSize == "Medium") {
      pricePerPizza = widget.pizza.sizes.medium;
    } else {
      pricePerPizza = widget.pizza.sizes.large;
    }
    totalPrice = pricePerPizza * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF790303), // AppBar color
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pizza Card
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 7,
                      offset: const Offset(0, 9),
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  color: const Color(0xFFD9D9D9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.pizza.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.pizza.name,
                          style: const TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text('4.9'),
                            SizedBox(width: 16),
                            Icon(Icons.timer, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text('30 min'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFF790303)),
                    onPressed: decrementQuantity,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB17C46),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFF790303)),
                    onPressed: incrementQuantity,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Pizza Description
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  color: const Color(0xFFD9D9D9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.pizza.reference,
                      style: const TextStyle(
                        fontFamily: 'Lobster',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Size Selector
              const Text(
                "Size:",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: "Yesteryear",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sizeButton("Small", widget.pizza.sizes.small, "Serves 1-2"),
                  sizeButton("Medium", widget.pizza.sizes.medium, "Serves 3-4"),
                  sizeButton("Large", widget.pizza.sizes.large, "Serves 5-6"),
                ],
              ),
              const SizedBox(height: 16),
              // Total Price
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Total price: \$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Lobster",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF790303),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Roboto',
                            color: Color(0xFFD8CAB8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                     onPressed: () async {
  // try {
  
   final sale= await saleController.createSale(currentUserId, widget.pizza.id, quantity, totalPrice,'Pizza');
   print('SALE1 ${sale}');
 final saleId = sale;
 print('id $saleId');
 
    // Step 2: Check if sale was created and retrieve saleId
    // if (saleController.sales.isNotEmpty) {
    //   String saleId = saleController.sales.last.id ?? "";

    //   if (saleId.isNotEmpty) {
    //     print("Navigating to SideScreen with saleId: $saleId");

        // Step 3: Navigate to SideScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SideScreen(saleId:saleId!),
          ),
        );
      // } else {
  //       print("Failed to retrieve saleId after creating the sale.");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Failed to retrieve Sale ID. Please try again.")),
  //       );
  //     }
  //   } else {
  //     print("Sale creation failed. No sale available in the list.");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Sale creation failed. Please try again.")),
  //     );
  //   }
  // } catch (e) {
  //   print("Error during sale creation: $e");
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Error: $e")),
  //   );
  // }
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
            ],
          ),
        ),
      ),
    );
  }

  Widget sizeButton(String size, double price, String serves) {
    return GestureDetector(
      onTap: () => selectSize(size),
      child: Container(
        width: 110, // Adjusted button width
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: selectedSize == size
              ? const Color(0xFF790303)
              : const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              size,
              style: TextStyle(
                fontSize: 18, // Adjusted size text font
                fontWeight: FontWeight.bold,
                color: selectedSize == size ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              serves,
              style: TextStyle(
                fontSize: 14, // Adjusted "Serves" font size
                color: selectedSize == size ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "\$${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: selectedSize == size ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
