import 'package:front/domain/entities/sale.dart';
import 'package:front/domain/usecases/sale_usecases/add_multiple_sides.dart';
import 'package:front/domain/usecases/sale_usecases/create_sale.dart';
import 'package:front/domain/usecases/sale_usecases/get_sale_by_id.dart';
import 'package:get/get.dart';

import '../../data/models/sale_model.dart';
import '../../di.dart';

class SaleController extends GetxController {
   List<String> sales = [];
  SaleModel? selectedSale;
  bool isLoading = false;
  String errorMessage = '';
  


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
        sales.add(sale); 
        res=sale;
        return sale; 
      },
      
    );
    return res;

}



Future<SaleModel?> getSaleById(String saleId) async {
  isLoading = true;
  errorMessage = '';
  update(); 

  try {
    final result = await GetSaleById(sl()).call(saleId);

    return result.fold(
      (failure) {
        errorMessage = 'Failed to fetch sale.';
        selectedSale = null;
        return null;
      },
      (sale) {
        if (sale is SaleModel) {
          selectedSale = sale;
          return sale;
        } else {
          errorMessage = 'Unexpected data format.';
          selectedSale = null;
          return null;
        }
      },
    );
  } catch (e) {
    errorMessage = 'Unexpected error: $e';
    selectedSale = null;
    return null;
  } finally {
    isLoading = false;
    update(); 
  }
}

Future<void> addMultipleSidesToSale(String saleId, List<SaleSide> sides, double totalPrice) async {
  isLoading = true; // Activate loading state
  errorMessage = ''; // Reset error message
  update(); // Notify UI

  try {
  

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
      },
    );
  } catch (e) {
    errorMessage = 'Erreur inattendue: $e';
  } finally {
    isLoading = false; 
    update(); 
  }
}

 }

