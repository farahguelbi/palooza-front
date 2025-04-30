
import 'package:front/domain/entities/ingredient.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/create_pizza.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_all_custom_pizzas.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_custom_pizza_by_id.dart';
import 'package:get/get.dart';

import '../../di.dart';

class CustomPizzaController extends GetxController {
   bool isLoading = false;
  String errorMessage = '';
  PizzaCustom? pizza;
List<PizzaCustom> allPizzas = [];
  List<PizzaCustom> pizzasList = [];
   String? createdPizzaId; 
   


  //getAllCustomPizzas
  Future<bool> getAllCustomPizzas() async {
    isLoading = true;
    update();
    
    final res = await GetAllCustomPizzas(sl())();

    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load custom pizzas';
        allPizzas = [];
        update();
        return false;
      },
      (pizzas) {
        allPizzas = pizzas;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }
Future<String?> createCustomPizza({
  required String selectedSize,
  required List<Map<String, dynamic>> ingredients,
  required String userID,
  required double price,
}) async {
  isLoading = true;
  update(); 
  try {
    final result = await CreatePizza(sl())(
      selectedSize,
      ingredients,
      userID,
      price,
    );

    isLoading = false;

    return result.fold(
      (failure) {
        errorMessage = 'Failed to create custom pizza: ${failure.message}';
        update(); 
        print("Error creating pizza: $failure"); 
        return null; 
      },
      (pizzaId) {
        createdPizzaId = pizzaId; 
        errorMessage = ''; 
        update(); 
        return pizzaId;
      },
    );
  } catch (e) {
    isLoading = false;
    errorMessage = 'An unexpected error occurred: $e';
    update(); 
    return null; 
  }
}

 // Fetch a custom pizza by ID
  Future<bool> getCustomPizzaById(String id) async {
    isLoading = true;
    update();
  print("Fetching CustomPizza with ID: $id from /api/pizzaCustom/");

    final res = await GetCustomPizzaById(sl())(id); 
print("API Response: $res");
    isLoading = false;
    update();

    return res.fold(
      (failure) {
        errorMessage = 'Pizza not found'; 
        pizza = null; 
        update();
              print("Failed to fetch CustomPizza: ${failure.message}");

        return false;
      },
      (foundPizza) {
        pizza = foundPizza; 
        errorMessage = '';
        update();
              print("CustomPizza fetched: ${pizza?.name}");

        return true;
      },
    );

  }
  
}