
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

  List<Map<String, dynamic>> selectedIngredients = []; 
  double totalPrice = 0;
  int pizzaQuantity = 1; 

  // Pizza sizes 
  final Map<String, double> sizeMap = {
    'S': 200,
    'M': 250,
    'L': 300,
  };

  Map<String, double> selectedPizzaPrices = {
    'S': 8.0, 
    'M': 10.0, 
    'L': 12.0, 
  };

  double currentSize = 200; 

  @override
  void initState() {
    super.initState();

    totalPrice = getTotalPrice(); 
   
   //on intialise le controleur animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    ingredientController.getAllIngredients();

    final authController = Get.find<AuthenticationController>();
    currentUserId = authController.currentUser.id!;
  }

  @override
  void dispose() {
    _controller.dispose(); 
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
    
    double basePrice = selectedPizzaPrices[selectedSize] ?? 0;

    double ingredientsPrice = 0;
    for (var item in selectedIngredients) {
      double ingredientPrice = ingredientController.allingredients
          .firstWhere((e) => e.id == item['ingredient'])
          .price;
      ingredientsPrice += ingredientPrice * item['quantity'];
    }

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
  final customPizzaId = await customPizzaController.createCustomPizza(
    selectedSize: selectedSize,
    ingredients: selectedIngredients,
    userID: currentUserId,
    price: totalPrice,
  );

  if (customPizzaId != null) {
        print('Custom pizza created successfully with ID: $customPizzaId');

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
  print(' Sale created successfully with ID: $saleId');
    if (sale != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SideScreen(saleId: saleId!),
        ),
      );
    } else {
            print(' Sale creation failed. Sale returned null.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create sale. Please try again.")),
      );
    }
  } else {
        print(' Custom pizza creation failed.');

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
      backgroundColor: const Color(0xFFede8d0), // Background color
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
                        //... =>operateur de decomposition 
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
                  _buildPizzaQuantitySelector(), 
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