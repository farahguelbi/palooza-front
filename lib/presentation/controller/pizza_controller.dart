import 'package:front/core/errors/failures/failures.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:front/domain/usecases/pizza_usecases/get_pizza_by_id.dart';
import 'package:front/domain/usecases/pizza_usecases/search_pizzas.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PizzaController extends GetxController {
  
  List<Pizza> allPizzas = [];
  List<Pizza> pizzasList = [];
  List<Pizza> filteredPizzas = [];
  bool isLoading = false;
  String msg = '';
  Pizza ?selectedPizza;
   String selectedType = 'All';

// 
   Future<bool> getAllpizzas() async {
    isLoading = true;
    update();
    final res = await getAllPizzasUseCase(sl())();
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Failed to load products';
        allPizzas=[];
        filteredPizzas = [];
        update();
        return false;
      },
      (pizzas) {
        allPizzas = pizzas;
        filteredPizzas = pizzas;
        msg = '';
        update();
        return true;
      },
    );
    return true;
  }
 // Fetch a single product by ID
  Future<bool> getPizzatById(String id) async {
    isLoading = true;

    final res = await GetPizzaByIdUsecase(sl())( id:id);
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Product not found';
        selectedPizza=null;
        update();
        return false;
      },
      (pizza) {
        selectedPizza = pizza;
        msg = '';
        update();
        return true;
     
      },

    );
    return true;

  }

 
// void filterPizzasByType(String? type) {
//   print("Filtering pizzas for type: $type");

//   if (type == 'All' || type == null) {
//     filteredPizzas = allPizzas; // ✅ Afficher toutes les pizzas
//   } else {
//     filteredPizzas = allPizzas
//         .where((pizza) => pizza.type.toLowerCase() == type.toLowerCase())
//         .toList(); // ✅ Filtrage par type (Full Pizza ou Slice)
//     print("Filtered pizzas count: ${filteredPizzas.length}");
//   }

//   update(); // 🔄 Mise à jour de l'UI
// }
// Filtre les pizzas par type
  // void filterPizzasByType(String? type) {
  //   selectedType = type ?? 'All';

  //   if (selectedType == 'All') {
  //     filteredPizzas = allPizzas;
  //   } else {
  //     filteredPizzas = allPizzas
  //         .where((pizza) => pizza.type.toLowerCase() == selectedType.toLowerCase())
  //         .toList();
  //   }
  //   update();
  // }
  void filterPizzasByType(String? type) {
  selectedType = type ?? 'All';

  if (selectedType == 'All') {
    filteredPizzas = allPizzas; 
  } else {
    filteredPizzas = allPizzas
        .where((pizza) => pizza.type.toLowerCase() == selectedType.toLowerCase())
        .toList(); 
  }
  update(); // Update the UI
}
 // Search products by name
  void searchPizzas(String query) {
    if (query.isEmpty) {
      filteredPizzas = allPizzas; 
    } else {
      filteredPizzas = allPizzas
          .where((product) =>
              product.name!.toUpperCase().contains(query.toUpperCase()))
          .toList(); // Filter by name
    }
    update(); // Notify listeners
  }

}
