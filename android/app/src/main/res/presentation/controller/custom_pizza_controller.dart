// import 'package:front/domain/entities/ingredient.dart';
// import 'package:front/domain/entities/pizzaCustom.dart';
// import 'package:front/domain/usecases/pizzaCustom_usecases/create_pizza.dart';
// import 'package:front/domain/usecases/pizzaCustom_usecases/get_all_custom_pizzas.dart';
// import 'package:front/domain/usecases/pizzaCustom_usecases/get_custom_pizza_by_id.dart';
// import 'package:get/get.dart';

// import '../../di.dart';

// class CustomPizzaController extends GetxController {
//    bool isLoading = false;
//   String errorMessage = '';
//   PizzaCustom? pizza;
// List<PizzaCustom> allPizzas = [];
//   List<PizzaCustom> pizzasList = [];
// //    List<Ingredient> selectedIngredients = [];
// //  Map<String, int> ingredientQuantities = {};


//   //getAllCustomPizzas
//   Future<bool> getAllCustomPizzas() async {
//     isLoading = true;
//     update();
    
//     final res = await GetAllCustomPizzas(sl())();

//     isLoading = false;

//     res.fold(
//       (failure) {
//         errorMessage = 'Failed to load custom pizzas';
//         allPizzas = [];
//         update();
//         return false;
//       },
//       (pizzas) {
//         allPizzas = pizzas;
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );
//     return true;
//   }
// Future<bool> createCustomPizza(
//   String selectedSize,
//   List<Map<String,dynamic>> ingredients,
// ) async {
//   isLoading = true;
//   update();

//   try {
//     final res = await CreatePizza(sl())(selectedSize, ingredients);

//     isLoading = false;

//     res.fold(
//       (failure) {
//         errorMessage = 'Failed to create custom pizza';
//         update();
//         print("Error creating pizza: $failure");
//         return false;
//       },
//       (CreatedPizza) {
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );
//     return true;
//   } catch (e) {
//     isLoading = false;
//     update();
//     print("Error during API call: $e");
//     return false;
//   }
// }

//  // Fetch a custom pizza by ID
//   Future<bool> getCustomPizzaById(String id) async {
//     isLoading = true;
//     update();

//     final res = await GetCustomPizzaById(sl())(id); 

//     isLoading = false;
//     update();

//     return res.fold(
//       (failure) {
//         errorMessage = 'Pizza not found';  // Error message when pizza is not found
//         pizza = null; // Clear current pizza if not found
//         update();
//         return false;
//       },
//       (foundPizza) {
//         pizza = foundPizza; 
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );

//   }
//   // // Ajouter un ingrédient à la pizza avec la gestion de la quantité
//   // void addIngredientToPizza(Ingredient ingredient) {
//   //   if (ingredientQuantities.containsKey(ingredient.id)) {
//   //     ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! + 1;
//   //   } else {
//   //     ingredientQuantities[ingredient.id] = 1;
//   //     selectedIngredients.add(ingredient);
//   //   }
//   //   update(); // Mettre à jour la vue
//   // }

//   // // Retirer un ingrédient de la pizza
//   // void removeIngredientFromPizza(Ingredient ingredient) {
//   //   if (ingredientQuantities.containsKey(ingredient.id) && ingredientQuantities[ingredient.id]! > 0) {
//   //     ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! - 1;
//   //     if (ingredientQuantities[ingredient.id]! == 0) {
//   //       selectedIngredients.remove(ingredient);
//   //       ingredientQuantities.remove(ingredient.id);
//   //     }
//   //   }
//   //   update(); // Mettre à jour la vue
//   // }
// }
import 'package:front/di.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/create_pizza.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_all_custom_pizzas.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_custom_pizza_by_id.dart';
import 'package:get/get.dart';



class CustomPizzaController extends GetxController {
   bool isLoading = false;
  String errorMessage = '';
  PizzaCustom? pizza;
List<PizzaCustom> allPizzas = [];
  List<PizzaCustom> pizzasList = [];
   String? createdPizzaId; 
   
//    List<Ingredient> selectedIngredients = [];
//  Map<String, int> ingredientQuantities = {};


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
 // Creates a custom pizza and returns the pizza ID
Future<String?> createCustomPizza({
  required String selectedSize,
  required List<Map<String, dynamic>> ingredients,
  required String userID,
  required double price,
}) async {
  isLoading = true;
  update(); // Notify listeners

  try {
    // Call the use case to create the pizza
    final result = await CreatePizza(sl())(
      selectedSize,
      ingredients,
      userID,
      price,
    );

    isLoading = false;

    return result.fold(
      (failure) {
        // Handle failure
        errorMessage = 'Failed to create custom pizza: ${failure.message}';
        update(); // Notify listeners
        print("Error creating pizza: $failure"); // Log error
        return null; // Return null for failure
      },
      (pizzaId) {
        // Handle success
        createdPizzaId = pizzaId; // Store the created pizza ID
        errorMessage = ''; // Clear error message
        update(); // Notify listeners
        return pizzaId; // Return the pizza ID for success
      },
    );
  } catch (e) {
    // Handle unexpected errors
    isLoading = false;
    errorMessage = 'An unexpected error occurred: $e';
    update(); // Notify listeners
    print("Error during API call: $e"); // Log unexpected errors
    return null; // Return null for failure
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
        errorMessage = 'Pizza not found';  // Error message when pizza is not found
        pizza = null; // Clear current pizza if not found
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
  // // Ajouter un ingrédient à la pizza avec la gestion de la quantité
  // void addIngredientToPizza(Ingredient ingredient) {
  //   if (ingredientQuantities.containsKey(ingredient.id)) {
  //     ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! + 1;
  //   } else {
  //     ingredientQuantities[ingredient.id] = 1;
  //     selectedIngredients.add(ingredient);
  //   }
  //   update(); // Mettre à jour la vue
  // }

  // // Retirer un ingrédient de la pizza
  // void removeIngredientFromPizza(Ingredient ingredient) {
  //   if (ingredientQuantities.containsKey(ingredient.id) && ingredientQuantities[ingredient.id]! > 0) {
  //     ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! - 1;
  //     if (ingredientQuantities[ingredient.id]! == 0) {
  //       selectedIngredients.remove(ingredient);
  //       ingredientQuantities.remove(ingredient.id);
  //     }
  //   }
  //   update(); // Mettre à jour la vue
  // }
}