
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
  //s’exécute dès que l’écran est affiche
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
                  _buildPaymentMethodSelector(), 
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
                  const SnackBar(content: Text(" Order Confirmed!")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(" Order Failed!")),
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