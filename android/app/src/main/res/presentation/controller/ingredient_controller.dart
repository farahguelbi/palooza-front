import 'dart:core';

import 'package:front/data/models/ingredient_model.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_all_ingredients.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredient_by_id.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredients_by_layer.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IngredientController extends GetxController {
   List<Ingredient> allingredients = [];
  List<Ingredient> ingredientsList = [];
  List<Ingredient> selectedIngredients = []; 
  Map<String, int> ingredientQuantities = {};
   Map<String, List<Ingredient>>? groupedIngredients; 
  bool isLoading = false;
  Ingredient ?selectedIngredient;
String msg='';
//fetch all ingredients 
Future<void> getAllIngredients() async {
  isLoading = true; 
  update(); 
    print('Fetching ingredients from repository...');

  final res = await GetAllIngredients(sl())(); 

  isLoading = false; 

  res.fold(
    (failure) {
      // En cas d'échec
              print('Failed to fetch ingredients: $failure');

      msg = 'Failed to load ingredients';
      allingredients=[];
      update();
    },
    (ingredients) {
              print('Ingredients fetched: $ingredients');

      // En cas de succès
      allingredients = ingredients;
      msg = '';
      update();
    },
  );
}

//fetch ingredients By Id 

Future<void>getIngredientById(String id) async{
  isLoading=true;
   final res = await GetIngredientById(sl())( id);
   isLoading=false;
   res.fold(
      (failure) {
        msg = 'Product not found';
        update();
      },
      (ingredient) {
        selectedIngredient = ingredient;
        msg = '';
        update();
      },

    );
  
  }
 Future<void> fetchIngredientsByLayer() async {
    isLoading = true;
    update();

    final res = await GetIngredientsByLayer(sl())();

    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Failed to load ingredients by layer.';
        groupedIngredients = null;
        update();
      },
      (ingredients) {
        groupedIngredients = ingredients;
        msg = '';
        update();
      },
    );
 }
 // Ajouter un ingrédient à la pizza avec gestion de la quantité
  void addIngredientToPizza(Ingredient ingredient) {
    final index = selectedIngredients.indexWhere((item) => item.id == ingredient.id);

    if (index != -1) {
      // Si l'ingrédient est déjà sélectionné, incrémenter la quantité dans le dictionnaire
      ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! + 1;
    } else {
      // Si l'ingrédient n'est pas dans la liste, l'ajouter avec une quantité de 1
      selectedIngredients.add(ingredient);
      ingredientQuantities[ingredient.id] = 1;
    }

    update(); // Mettre à jour l'affichage
  }

  // Retirer un ingrédient de la pizza
  void removeIngredientFromPizza(Ingredient ingredient) {
    final index = selectedIngredients.indexWhere((item) => item.id == ingredient.id);

    if (index != -1) {
      if (ingredientQuantities[ingredient.id]! > 1) {
        ingredientQuantities[ingredient.id] = ingredientQuantities[ingredient.id]! - 1;
      } else {
        selectedIngredients.removeAt(index);
        ingredientQuantities.remove(ingredient.id);
      }
    }

    update(); // Mettre à jour l'affichage
  }

  // Retourner la quantité d'un ingrédient
  int getIngredientQuantity(Ingredient ingredient) {
    return ingredientQuantities[ingredient.id] ?? 0;
  }
// void incrementIngredientQuantity(Ingredient ingredient) {
//     // Check if the ingredient is already selected
//     final index = selectedIngredients.indexWhere((item) => item.id == ingredient.id);

//     if (index != -1) {
//       // If it's already selected, increment the quantity
//       selectedIngredients[index].quantity++;
//     } else {
//       // Otherwise, add it to the list with a quantity of 1
//       ingredient.quantity = 1;
//       selectedIngredients.add(ingredient);
//     }

//     update(); // Notify listeners
//   }
}

