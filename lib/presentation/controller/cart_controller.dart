
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/cart.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:front/domain/usecases/cart_usecases/add_sale.dart';
import 'package:front/domain/usecases/cart_usecases/clear_cart.dart';
import 'package:front/domain/usecases/cart_usecases/create_cart.dart';
import 'package:front/domain/usecases/cart_usecases/get_cart.dart';
import 'package:front/domain/usecases/cart_usecases/remove_sale.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Cart? currentUserCart;
  bool isLoading = false;
  String errorMessage = '';
  List<Sale> allSales = [];
 bool isCartFetched = false;
double _cartTotal=0.0;
  double get cartTotalPrice => _cartTotal;

  ///  **Create a new cart for the user**
  Future<bool> createCart(String userId) async {
    isLoading = true;
    update();

    final res = await CreateOrGetCartUseCase(sl())(userId: userId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to create cart';
        update();
        return false;
      },
      (cart) {
        currentUserCart = cart;
        update();
        return true;
      },
    );
  }
   ///  **Load Cart for the Current User**
  Future<void> loadCart(String userId) async {
    isLoading = true;
    errorMessage = '';
    update(['cart_update']); 

    print(" Fetching Cart for User: $userId");

    final result = await GetCartUseCase(sl())(userId);
    isLoading = false;

    result.fold(
      (failure) {
        errorMessage = 'Failed to fetch cart';
        print("Error fetching cart: $failure");
        update(['cart_update']);
      },
      (cart) {
        currentUserCart = cart;
        allSales = cart?.sales ?? [];
        isCartFetched = true;
        print(" Cart Updated: ${allSales.length} sales found");
        update(['cart_update']);
      },
    );
  }

Future<bool> addSaleToCart(String userId, String saleId) async {
  isLoading = true;
  update(['cart_update']); 

  print(" Attempting to add sale $saleId to cart...");

  final result = await AddSaleToCartUseCase(sl())(userId, saleId);

  return result.fold(
    (failure) {
      
      errorMessage = "Failed to add item to cart";
      print("Failed to add to cart: $failure");
      update(['cart_update']);
      return false;
    },
    (_) async {
      print("Sale added successfully, fetching updated cart...");
      await getCartByUser(userId);
      forceUpdateUI(); 

      return true;
    },
  );
}


Future<Cart?> getCartByUser(String userId) async {
  isLoading = true;
  update(['cart_update']); 

  print(" Fetching Cart for User: $userId");

  // Call the use case to fetch the cart
  final result = await GetCartUseCase(sl())(userId);
  isLoading = false;

  // Handle the result
  return result.fold(
    (failure) {
      errorMessage = 'Failed to fetch cart';
      print(" Error fetching cart: $failure");
      update(['cart_update']); 
      return null; 
    },
    (cart) {
      currentUserCart = cart;
      allSales = cart?.sales ?? [];
      isCartFetched = true; 
         updateCartTotal();
      print(" Cart Updated: ${allSales.length} sales found");
      print("Cart Sales IDs: ${allSales.map((sale) => sale.id).toList()}");
      update(['cart_update']); 
      return cart; 
    },
  );
}
  void updateCartTotal() {
    _cartTotal = allSales.fold(0.0, (sum, sale) => sum + (sale.totalPrice ?? 0));

    update(['cart_total']); 
  }


    Future<bool> removeSaleFromCart(String userId, String saleId) async {
    isLoading = true;
    update();

    final result = await RemoveSaleFromCartUseCase(sl())(userId, saleId);

    return result.fold(
      (failure) {
        errorMessage = "Failed to remove item from cart";
        update();
        return false;
      },
      (_) 
      // async
       {
          allSales.removeWhere((sale) => sale.id == saleId); 
           updateCartTotal();
        update(['cart_update']);

        return true;
      },
    );
  }

  ///  **Clear Cart**
  Future<void> clearCart(String userId) async {
    isLoading = true;
    update();

    final result = await ClearCartUseCase(sl())(userId);
    await result.fold(
      (failure) {
        errorMessage = "Failed to clear cart";
        update();
      },
      (_) async {
        await createCart(userId);
        await getCartByUser(userId);
      },
    );

    isLoading = false;
    update();
  }

  ///  **Reset Cart State**
  void resetCart() {
    currentUserCart = null;
    allSales.clear();
    errorMessage = '';
    isLoading = false;
        _cartTotal = 0.0;
    update();
  }
  void forceUpdateUI() {
  print(" Forcing UI update...");
  update(['cart_update']); 
}

}
