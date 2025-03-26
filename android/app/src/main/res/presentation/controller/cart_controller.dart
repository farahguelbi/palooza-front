// // import 'package:front/core/errors/failures/failures.dart';
// // import 'package:front/di.dart';
// // import 'package:front/domain/entities/cart.dart';
// // import 'package:front/domain/entities/sale.dart';
// // import 'package:front/domain/usecases/cart_usecases/add_sale.dart';
// // import 'package:front/domain/usecases/cart_usecases/clear_cart.dart';
// // import 'package:front/domain/usecases/cart_usecases/create_cart.dart';
// // import 'package:front/domain/usecases/cart_usecases/get_cart.dart';
// // import 'package:front/domain/usecases/cart_usecases/remove_sale.dart';
// // import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// // class CartController extends GetxController {
// //   Cart? currentUserCart;
// //   bool isLoading = false;
// //   String errorMessage = '';
// //   Sale? sale;
// //   List<Sale> allSales = [];

// //   // Create a new cart for the user
// //   Future<bool> createCart(String userId) async {
// //     isLoading = true;
// //     update();

// //     final res = await CreateOrGetCartUseCase(sl())(userId: userId);
// //     isLoading = false;

// //     return res.fold(
// //       (failure) {
// //         errorMessage = 'Failed to create cart';
// //         update();
// //         return false;
// //       },
// //       (cart) {
// //         currentUserCart = cart;
// //         errorMessage = '';
// //         update();
// //         return true;
// //       },
// //     );
// //   }

// //   // Add Sale to Cart
// //   // Future<void> addSaleToCart(String userId, String saleId) async {
// //   //   isLoading = true;
// //   //   update();

// //   //   final result = await AddSaleToCartUseCase(sl())(userId, saleId);
// //   //   result.fold(
// //   //     (failure) {
// //   //       errorMessage = "Failed to add item to cart";
// //   //       update();
// //   //     },
// //   //     (_) async {
// //   //       await getCartByUser(userId);
// //   //     },
// //   //   );

// //   //   isLoading = false;
// //   //   update();
// //   // }

// // // Future<bool> addSaleToCart(String userId, String saleId) async {
// // //   isLoading = true;
// // //   update();

// // //   final result = await AddSaleToCartUseCase(sl())(userId, saleId);
// // //   bool success = false;

// // //   result.fold(
// // //     (failure) {
// // //       errorMessage = "Failed to add item to cart";
// // //       update();
// // //       success = false;
// // //     },
// // //     (_) async {
// // //       await getCartByUser(userId);
// // //       success = true;
// // //     },
// // //   );

// // //   isLoading = false;
// // //   update();
// // //   return success;  
// // // }
// // Future<bool> addSaleToCart(String userId, String saleId) async {
// //   isLoading = true;
// //   update(); // ✅ Ensure UI updates before API call

// //   final result = await AddSaleToCartUseCase(sl())(userId, saleId);
// //   bool isSuccess = false;

// //   await result.fold(
// //     (failure) {
// //       errorMessage = "Failed to add item to cart";
// //       update();
// //       isSuccess = false;
// //     },
// //     (_) async {
// //       print("✅ Sale added successfully, fetching updated cart...");
// //       await getCartByUser(userId); // ✅ Fetch updated cart
// //       isSuccess = true;
// //     },
// //   );

// //   isLoading = false;
// //   update(); // ✅ Ensure UI updates after API call
// //   return isSuccess;
// // }


// //   // Fetch User's Cart
// //   // Future<Cart?> getCartByUser(String userId) async {
// //   //   isLoading = true;
// //   //   update();

// //   //   final result = await GetCartUseCase(sl())(userId);
// //   //   isLoading = false;

// //   //   return result.fold(
// //   //     (failure) {
// //   //       errorMessage = 'Failed to fetch cart';
// //   //       update();
// //   //       return null;
// //   //     },
// //   //     (cart) {
// //   //       currentUserCart = cart;
// //   //       allSales = cart?.sales ?? [];
// //   //       errorMessage = '';
// //   //       update();
// //   //       return cart;
// //   //     },
// //   //   );
// //   // }
// // Future<Cart?> getCartByUser(String userId) async {
// //   isLoading = true;
// //   update(); 

// //   final result = await GetCartUseCase(sl())(userId);
// //   isLoading = false;

// //   return result.fold(
// //     (failure) {
// //       errorMessage = 'Failed to fetch cart';
// //       update();
// //       return null;
// //     },
// //     (cart) {
// //       currentUserCart = cart;
// //       allSales = cart?.sales ?? [];
// //       print("🔍 Updated Cart Data: ${currentUserCart?.sales.length} sales found");
// //       print("🛒 Cart Items: ${allSales.map((sale) => sale.id).toList()}");
// //       update();
// //       return cart;
// //     },
// //   );
// // }

// //   // Remove Sale from Cart
// //   Future<bool> removeSaleFromCart(String userId, String saleId) async {
// //     isLoading = true;
// //     update();

// //     final result = await RemoveSaleFromCartUseCase(sl())(userId, saleId);
// //     bool isSuccess = false;

// //     await result.fold(
// //       (failure) {
// //         errorMessage = "Failed to remove item from cart";
// //         update();
// //         isSuccess = false;
// //       },
// //       (_) async {
// //         await getCartByUser(userId); 
// //         isSuccess = true;
// //       },
// //     );

// //     isLoading = false;
// //     update();
// //     return isSuccess;
// //   }
// //   Future<bool> clearCart(String userId) async {
// //     isLoading = true;
// //     update();

// //     final result = await ClearCartUseCase(sl())(userId);
// //     bool isSuccess = false;

// //     await result.fold(
// //       (failure) {
// //         errorMessage = "Failed to clear cart";
// //         update();
// //         isSuccess = false;
// //       },
// //       (_) async {
// //         currentUserCart = await createCart(userId) ? await getCartByUser(userId) : null;
// //         isSuccess = true;
// //       },
// //     );

// //     isLoading = false;
// //     update();
// //     return isSuccess;
// //   } 
// //    void resetCart() {
// //     currentUserCart = null;
// //     allSales.clear();
// //     errorMessage = '';
// //     isLoading = false;
// //     update();
// //   }
// // }
// import 'package:front/core/errors/failures/failures.dart';
// import 'package:front/di.dart';
// import 'package:front/domain/entities/cart.dart';
// import 'package:front/domain/entities/sale.dart';
// import 'package:front/domain/usecases/cart_usecases/add_sale.dart';
// import 'package:front/domain/usecases/cart_usecases/clear_cart.dart';
// import 'package:front/domain/usecases/cart_usecases/create_cart.dart';
// import 'package:front/domain/usecases/cart_usecases/get_cart.dart';
// import 'package:front/domain/usecases/cart_usecases/remove_sale.dart';
// import 'package:get/get.dart';

// class CartController extends GetxController {
//   Cart? currentUserCart;
//   bool isLoading = false;
//   String errorMessage = '';
//   Sale? sale;
//   List<Sale> allSales = [];

//   /// ✅ **Create a new cart for the user**
//   Future<bool> createCart(String userId) async {
//     isLoading = true;
//     update();

//     final res = await CreateOrGetCartUseCase(sl())(userId: userId);
//     isLoading = false;

//     return res.fold(
//       (failure) {
//         errorMessage = 'Failed to create cart';
//         update();
//         return false;
//       },
//       (cart) {
//         currentUserCart = cart;
//         update();
//         return true;
//       },
//     );
//   }

//   /// ✅ **Add Sale to Cart (Now Returns a Boolean)**
//   Future<bool> addSaleToCart(String userId, String saleId) async {
//     isLoading = true;
//     update();

//     final result = await AddSaleToCartUseCase(sl())(userId, saleId);

//     return result.fold(
//       (failure) {
//         errorMessage = "Failed to add item to cart";
//         update();
//         return false;
//       },
//       (_) async {
//         print("✅ Sale added successfully, fetching updated cart...");
//         await getCartByUser(userId); // ✅ Fetch updated cart
//         return true;
//       },
//     );
//   }

//   /// ✅ **Fetch User's Cart**
//   Future<Cart?> getCartByUser(String userId) async {
//     isLoading = true;
//     update();

//     final result = await GetCartUseCase(sl())(userId);
//     isLoading = false;

//     return result.fold(
//       (failure) {
//         errorMessage = 'Failed to fetch cart';
//         update();
//         return null;
//       },
//       (cart) {
//         currentUserCart = cart;
//         allSales = cart?.sales ?? [];
//         print("🛒 Cart Updated: ${allSales.length} sales found");
//         update();
//         return cart;
//       },
//     );
//   }

//   /// ✅ **Remove Sale from Cart**
//   Future<bool> removeSaleFromCart(String userId, String saleId) async {
//     isLoading = true;
//     update();

//     final result = await RemoveSaleFromCartUseCase(sl())(userId, saleId);

//     return result.fold(
//       (failure) {
//         errorMessage = "Failed to remove item from cart";
//         update();
//         return false;
//       },
//       (_) async {
//         await getCartByUser(userId);
//         return true;
//       },
//     );
//   }

//   /// ✅ **Clear Cart**
//   Future<bool> clearCart(String userId) async {
//     isLoading = true;
//     update();

//     final result = await ClearCartUseCase(sl())(userId);
//     return result.fold(
//       (failure) {
//         errorMessage = "Failed to clear cart";
//         update();
//         return false;
//       },
//       (_) async {
//         currentUserCart = await createCart(userId) ? await getCartByUser(userId) : null;
//         return true;
//       },
//     );
//   }

//   /// ✅ **Reset Cart State**
//   void resetCart() {
//     currentUserCart = null;
//     allSales.clear();
//     errorMessage = '';
//     isLoading = false;
//     update();
//   }
// }
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

  /// ✅ **Create a new cart for the user**
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
   /// ✅ **Load Cart for the Current User**
  Future<void> loadCart(String userId) async {
    isLoading = true;
    errorMessage = '';
    update(['cart_update']); // 🔄 Ensure the UI updates

    print("🔄 Fetching Cart for User: $userId");

    final result = await GetCartUseCase(sl())(userId);
    isLoading = false;

    result.fold(
      (failure) {
        errorMessage = 'Failed to fetch cart';
        print("❌ Error fetching cart: $failure");
        update(['cart_update']);
      },
      (cart) {
        currentUserCart = cart;
        allSales = cart?.sales ?? [];
        isCartFetched = true;
        print("✅ Cart Updated: ${allSales.length} sales found");
        update(['cart_update']);
      },
    );
  }
// Future<bool> addSaleToCart(String userId, String saleId) async {
//   isLoading = true;
//   update();

//   final result = await AddSaleToCartUseCase(sl())(userId, saleId);

//   return result.fold(
//     (failure) {
//       errorMessage = "Failed to add item to cart";
//       update();
//       return false;
//     },
//     (_) async {
//       print("✅ Sale added successfully, fetching updated cart...");
//       await getCartByUser(userId); // ✅ Fetch updated cart
//       return true;
//     },
//   );
// }
Future<bool> addSaleToCart(String userId, String saleId) async {
  isLoading = true;
  update(['cart_update']); 

  print("🛍️ Attempting to add sale $saleId to cart...");

  final result = await AddSaleToCartUseCase(sl())(userId, saleId);

  return result.fold(
    (failure) {
      errorMessage = "Failed to add item to cart";
      print("❌ Failed to add to cart: $failure");
      update(['cart_update']);
      return false;
    },
    (_) async {
      print("✅ Sale added successfully, fetching updated cart...");
      await getCartByUser(userId);
      forceUpdateUI(); // 🔄 Force UI update

      // update(['cart_update']);
      return true;
    },
  );
}


  // /// ✅ **Add Sale to Cart & Ensure UI Updates**
  // Future<bool> addSaleToCart(String userId, String saleId) async {
  //   isLoading = true;
  //   update();

  //   final result = await AddSaleToCartUseCase(sl())(userId, saleId);
  //   bool isSuccess = false;

  //   await result.fold(
  //     (failure) {
  //       errorMessage = "Failed to add item to cart";
  //       update();
  //       isSuccess = false;
  //     },
  //     (_) async {
  //       print("✅ Sale added successfully, fetching updated cart...");
  //       await getCartByUser(userId); // ✅ Fetch updated cart immediately
  //       isSuccess = true;
  //     },
  //   );

  //   isLoading = false;
  //   update();
  //   return isSuccess;
  // }

  /// ✅ **Fetch User's Cart & Ensure UI Updates**
  // Future<Cart?> getCartByUser(String userId) async {
  //   isLoading = true;
  //   update();

  //   final result = await GetCartUseCase(sl())(userId);
  //   isLoading = false;

  //   result.fold(
  //     (failure) {
  //       errorMessage = 'Failed to fetch cart';
  //       update();
  //     },
  //     (cart) {
  //       currentUserCart = cart;
  //       allSales = cart?.sales ?? [];
  //       print("🛒 Cart Updated: ${allSales.length} sales found");
  //       update();  // 🔄 Ensure UI Updates
  //     },
  //   );
  // }
// Future<Cart?> getCartByUser(String userId) async {
//   isLoading = true;
//   update(['cart_update']); // 🔄 Ensure UI updates

//   print("🔄 Fetching Cart for User: $userId");

//   final result = await GetCartUseCase(sl())(userId);
//   isLoading = false;

//   result.fold(
//     (failure) {
//       errorMessage = 'Failed to fetch cart';
//       print("❌ Error fetching cart: $failure");
//             print("❌ Possible API Failure! Check your backend logs.");

//       update();
      
//     },
//     (cart) {
//       currentUserCart = cart;
//       allSales = cart?.sales ?? [];

//       print("✅ Cart Updated: ${allSales.length} sales found");
//       print("🛒 Cart Sales IDs: ${allSales.map((sale) => sale.id).toList()}");
//       update();  // 🔄 Ensure UI updates
//     },
//   );
// }

Future<Cart?> getCartByUser(String userId) async {
  isLoading = true;
  update(['cart_update']); // 🔄 Ensure the UI updates for loading state

  print("🔄 Fetching Cart for User: $userId");

  // Call the use case to fetch the cart
  final result = await GetCartUseCase(sl())(userId);
  isLoading = false;

  // Handle the result
  return result.fold(
    (failure) {
      errorMessage = 'Failed to fetch cart';
      print("❌ Error fetching cart: $failure");
      update(['cart_update']); // 🔄 Ensure the UI updates with the error message
      return null; // Return null if the cart couldn't be fetched
    },
    (cart) {
      currentUserCart = cart;
      allSales = cart?.sales ?? [];
      isCartFetched = true; 
         updateCartTotal();
      print("✅ Cart Updated: ${allSales.length} sales found");
      print("🛒 Cart Sales IDs: ${allSales.map((sale) => sale.id).toList()}");
      update(['cart_update']); // 🔄 Ensure the UI updates with the new cart data
      return cart; // Return the fetched cart
    },
  );
}
/// ✅ **Calculate & Update Total Cart Price**
  void updateCartTotal() {
    _cartTotal = allSales.fold(0.0, (sum, sale) => sum + (sale.totalPrice ?? 0));

    print("💰 Cart Total Updated: \$${_cartTotal.toStringAsFixed(2)}");
    update(['cart_total']); // 🔄 Ensure UI updates with new total
  }

  /// ✅ **Remove Sale from Cart**
  // Future<void> removeSaleFromCart(String userId, String saleId) async {
  //   isLoading = true;
  //   update();

  //   final result = await RemoveSaleFromCartUseCase(sl())(userId, saleId);

  //   await result.fold(
  //     (failure) {
  //       errorMessage = "Failed to remove item from cart";
  //       update();
  //     },
  //     (_) async {
  //       await getCartByUser(userId);
  //     },
  //   );

  //   isLoading = false;
  //   update();
  // }
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

  /// ✅ **Clear Cart**
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

  /// ✅ **Reset Cart State**
  void resetCart() {
    currentUserCart = null;
    allSales.clear();
    errorMessage = '';
    isLoading = false;
        _cartTotal = 0.0;
    update();
  }
  void forceUpdateUI() {
  print("🔄 Forcing UI update...");
  update(['cart_update']); 
}

}
