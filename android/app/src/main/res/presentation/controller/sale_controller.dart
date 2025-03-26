import 'package:front/data/models/sale_model.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:front/domain/usecases/sale_usecases/add_multiple_sides.dart';
import 'package:front/domain/usecases/sale_usecases/create_sale.dart';
import 'package:front/domain/usecases/sale_usecases/get_sale_by_id.dart';
import 'package:get/get.dart';


class SaleController extends GetxController {
   List<String> sales = [];
  SaleModel? selectedSale;
  bool isLoading = false;
  String errorMessage = '';
  

//   /// Create a new sale

// Future<void> createSale( userID,pizzaId,quantityPizza,totalPrice) async {
//   isLoading = true; // Set loading state
//   errorMessage = ''; // Clear any previous error
//   update(); // Notify UI of changes

//   try {
//     final newSale = await CreateSale(sl())(userID: userID,pizzaId: pizzaId,quantityPizza: quantityPizza,totalPrice:totalPrice);
  
// print(newSale);
//     sales.add(newSale as SaleModel);

//     // Notify the user of the success
//   } catch (e) {
//     // Handle and log the error
//     errorMessage = 'Failed to create sale: ${e.toString()}';
//   } finally {
//     isLoading = false; // Reset loading state
//     update(); // Notify UI of changes
//   }
// }
// Future<void> createSale(String userID, String pizzaId, int quantityPizza, double totalPrice) async {
//   isLoading = true;
//   errorMessage = '';
//   update();

//   try {
//     // Call the CreateSale use case and get the result
//     final result = await CreateSale(sl())(
//       userID: userID,
//       pizzaId: pizzaId,
//       quantityPizza: quantityPizza,
//       totalPrice: totalPrice,
//     );

//     // Handle the result using fold
//     result.fold(
//       (failure) {
//         errorMessage = 'Failed to create sale: ${failure.toString()}';
//         print(errorMessage);
//       },
//       (sale) {
//         sales.add(sale as SaleModel); // Cast the Sale entity to SaleModel
//         print("Sale created successfully with ID: ${sale.id}");
//       },
//     );
//   } catch (e) {
//     print("Error creating sale: $e");
//     errorMessage = 'Unexpected error: $e';
//   } finally {
//     isLoading = false;
//     update();
//   }
// }
Future<String> createSale(
    String userID, String pizzaId, int quantityPizza, double totalPrice,String pizzaType) async {
  isLoading = true;
  errorMessage = '';
  update();
String res='';
  
    // Call the CreateSale use case and get the result
    final result = await CreateSale(sl())(
      userID: userID,
      pizzaId: pizzaId,
      quantityPizza: quantityPizza,
      totalPrice: totalPrice,
      pizzaType: pizzaType,
    );

    // Handle the result using fold
  result.fold(
      (failure){
        errorMessage = 'Failed to create sale: ${failure.toString()}';
      },
      (sale) {
        sales.add(sale); // Cast the Sale entity to SaleModel
        // print("Sale created successfully with ID: ${sale.id}");
        res=sale;
        return sale; // Return the created Sale object
      },
      
    );
    return res;

}


// Future<void> addMultipleSidesToSale(String saleId, List<SaleSide> sides, double totalPrice) async {
//   isLoading = true; // Active le mode chargement
//   errorMessage = ''; // Réinitialise le message d'erreur

//   try {
//     final result = await AddMultipleSides(sl())(
//       saleId: saleId,
//       sides: sides,
//       totalPrice: totalPrice,
//     );

//     result.fold(
//       (failure) {
//         errorMessage = 'Échec de l’ajout des sides.';
//       },
//       (_) {
//         errorMessage = ""; // Aucun message d'erreur signifie succès
//       },
//     );
//   } catch (e) {
//     errorMessage= 'Erreur inattendue: $e';
//   } finally {
//     isLoading = false; // Désactive le mode chargement
//   }
// }
//  Future<void> getSaleById(String saleId) async {
//     isLoading = true;
//     errorMessage = '';
//     update();

//     try {
//       final result = await GetSaleById(sl())(saleId);

//       result.fold(
//         (failure) {
//           errorMessage = 'Failed to fetch sale.';
//           selectedSale = null;
//         },
//         (sale) {
//           selectedSale = sale as SaleModel;
//         },
//       );
//     } catch (e) {
//       errorMessage = 'Unexpected error: $e';
//       selectedSale = null;
//     } finally {
//       isLoading = false;
//       update();
//     }
//   }
// Future<SaleModel?> getSaleById(String saleId) async {
//   isLoading = true;
//   errorMessage = '';
//   update(); // Notify listeners that state is updating

//   try {
//     final result = await GetSaleById(sl()).call(saleId);

//     return result.fold(
//       (failure) {
//         errorMessage = 'Failed to fetch sale.';
//         selectedSale = null;
//         return null;
//       },
//       (sale) {
//         if (sale is SaleModel) {
//           selectedSale = sale;
//           return sale;
//         } else {
//           errorMessage = 'Unexpected data format.';
//           selectedSale = null;
//           return null;
//         }
//       },
//     );
//   } catch (e) {
//     errorMessage = 'Unexpected error: $e';
//     selectedSale = null;
//     return null;
//   } finally {
//     isLoading = false;
//     update(); // Notify listeners about state change
//   }
// }
Future<SaleModel?> getSaleById(String saleId) async {
  isLoading = true;
  errorMessage = '';
  update(); // Notify UI that loading started

  try {
    // print("🔄 Calling API to get sale with ID: $saleId...");
    final result = await GetSaleById(sl()).call(saleId);

    return result.fold(
      (failure) {
        // print("❌ Failed to fetch sale.");
        errorMessage = 'Failed to fetch sale.';
        selectedSale = null;
        return null;
      },
      (sale) {
        if (sale is SaleModel) {
          // print("✅ API Response - Sale Found: ${sale.toJson()}");
          selectedSale = sale;
          return sale;
        } else {
          // print("⚠️ Unexpected data format.");
          errorMessage = 'Unexpected data format.';
          selectedSale = null;
          return null;
        }
      },
    );
  } catch (e) {
    // print("❌ Unexpected error fetching sale: $e");
    errorMessage = 'Unexpected error: $e';
    selectedSale = null;
    return null;
  } finally {
    isLoading = false;
    update(); // Notify UI state changes
  }
}

Future<void> addMultipleSidesToSale(String saleId, List<SaleSide> sides, double totalPrice) async {
  isLoading = true; // Activate loading state
  errorMessage = ''; // Reset error message
  update(); // Notify UI

  try {
    // print("Calling addMultipleSidesToSale...");
    // print("Sale ID: $saleId");
    // print("Sides to add: ${sides.map((s) => {'sideId': s.sideId, 'quantity': s.quantity}).toList()}");
    // print("Total Price: $totalPrice");

    final result = await AddMultipleSides(sl())(
      saleId: saleId,
      sides: sides,
      totalPrice: totalPrice,
    );

    result.fold(
      (failure) {
        errorMessage = 'Échec de l’ajout des sides.';
        // print("Failed to add sides: $failure");
      },
      (_) {
        errorMessage = ""; // No error means success
        print("Sides added successfully.");
      },
    );
  } catch (e) {
    errorMessage = 'Erreur inattendue: $e';
    // print("Unexpected error in addMultipleSidesToSale: $e");
  } finally {
    isLoading = false; // Disable loading state
    update(); // Notify UI
  }
}

 }

