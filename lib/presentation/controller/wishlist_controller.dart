// import 'package:front/domain/entities/wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/add_to_wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/get_wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/remove_from_wishlist.dart';
// import 'package:get/get.dart';

// import '../../di.dart';

// class WishlistController extends GetxController {
//     late Wishlist currentWishlist;

//     List<Wishlist> Allwishlist = [];
//   List<Wishlist> WishlistList = [];
//   bool isLoading = false;
//   String msg = '';
//   Wishlist ?selectedWishlist;
  
//   //get wishlist
//    Future<bool> getWishlistById(String id) async {
    
//     isLoading = true;

//     final res = await GetWishlist(sl())( id);
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Wishlist not found';
//         selectedWishlist=null;
//         update();
//         return false;
//       },
//       (Wishlist) {
//         selectedWishlist = Wishlist;
//         msg = '';
//         update();
//         return true;
     
//       },

//     );
//     return true;


//   }
//   //add to wishlist 
//   Future<void> addToWishlist(String userId, String pizzaId) async {
//     isLoading = true;
//     update();

//     final res = await AddToWishlist(sl())(userId, pizzaId); // Appel au use case
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Failed to add pizza to wishlist';
//         update();
//       },
//       (_) async {
//         msg = 'Pizza added successfully';
//         // Recharge la wishlist après ajout
//         await getWishlistById(userId);
//       },
//     );
//   }
//  // **Supprimez un élément de la wishlist**
//   Future<void> removeFromWishlist(String userId, String pizzaId) async {
//     isLoading = true;
//     update();

//     final res = await RemoveFromWishlist(sl())(userId, pizzaId); // Appel au use case
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Failed to remove pizza from wishlist';
//         update();
//       },
//       (_) async {
//         msg = 'Pizza removed successfully';
//         // Recharge la wishlist après suppression
//         await getWishlistById(userId);
//       },
//     );
//   }

// }
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/usecases/wishlist_usecases/create_wishlist.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:get/get.dart';
import '../../domain/entities/wishlist.dart';
import '../../di.dart';
import '../../domain/usecases/wishlist_usecases/add_to_wishlist.dart';
import '../../domain/usecases/wishlist_usecases/get_wishlist.dart';
import '../../domain/usecases/wishlist_usecases/remove_from_wishlist.dart';

class WishlistController extends GetxController {
  List<Wishlist> wishlistItems = [];

  Wishlist? userWishlist;
  bool isLoading = false;
  String errorMessage = '';


//create wishlist 


// Create a wishlist for a user
 Future<bool> createWishlist(String userId) async {
    isLoading = true;
    update(); // Met à jour l'état pour indiquer le chargement

    final res = await CreateWishListUseCase(sl())(userId: userId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to create wishlist';
        update();
        return false;
      },
      (_) {
        errorMessage = '';
        update();
        return true;
      },
    );
  }
  // // Fetch wishlist for a user
  // Future<bool> getWishlistByUserId(String userId) async {
  //   isLoading = true;
  //   errorMessage = '';
  //   update();

  //   final result = await GetWishlist(sl())(userId);
  //    isLoading=false;
  //   result.fold(
  //     (failure) {
  //       errorMessage = 'Failed to fetch wishlist. Please try again later.';
  //       userWishlist = null;
  //     },
  //     (wishlist) {
  //         userWishlist = wishlist;
  //         errorMessage="";
  //     },
  //   );
  //   update();

  //   isLoading = false;
  //   update();
  //   return userWishlist!=null;
  // }
// Get wishlist by user ID
  Future<bool> getWishlistByUserId(String userId) async {
    isLoading = true;
    update();
    print('Fetching wishlist for userId: $userId');
    final res = await GetWishlist(sl())(userId:userId);
    print('API call complete, result: $res');
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load wishlist';
        print('Error: ${failure.toString()}');
        update();
        return false;
      },
      (wishlist) {
        userWishlist = wishlist;

        print('Fetched Wishlist: $userWishlist');
        print('Wishlist product IDs: ${userWishlist?.pizzas}');

        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Add a pizza to the wishlist
  Future<bool> addPizzaToWishlist(String userId, String pizzaId) async {
    isLoading = true;
    errorMessage = '';
    update();

    final result = await AddToWishlist(sl())(userId,  pizzaId);
      bool success = false;
    result.fold(
      (failure) {
        errorMessage = 'Failed to add pizza to wishlist.';
      },
      (_) async {
        success = true;

        await getWishlistByUserId(userId);
      },
    );

    isLoading = false;
    update();
          return success;

  }

  // Remove a pizza from the wishlist
  Future<bool> removePizzaFromWishlist(String userId, String pizzaId) async {
    isLoading = true;
    errorMessage = '';
    update();

    final result = await RemoveFromWishlist(sl())(userId,  pizzaId);
     bool success = false;
    result.fold(
      (failure) {
        errorMessage = 'Failed to remove pizza from wishlist.';
        update();
      },
      (_) async {
        success = true;
        // Refresh the wishlist after successful removal
        await getWishlistByUserId(userId);
      },
    );

    isLoading = false;
    update();
     return success;
  }
  /// Réinitialise la wishlist (utile lors de la déconnexion ou d'un nettoyage)
  void resetWishlist() {
    userWishlist = null;
    errorMessage = '';
    update();
  }

  /// Récupère l'ID de la wishlist actuelle si elle est chargée
  String? getWishlistIdForUser(String? userId) {
    if (userId == null) return null;
    return userWishlist?.id;
  }
   /// Vérifie si la pizza est dans la wishlist 
  bool checkWishlistStatus(String id) {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser?.id;

    if (currentUserId != null) {
      wishlistController.getWishlistByUserId(currentUserId).then(
        (success) {
        if (success && wishlistController.userWishlist != null) {
          // Synchronise l'état local avec la liste du backend
           return  wishlistController.userWishlist!.pizzas
                .contains(id);
        
        }
        
      }
      );
    }
    return false;
  }

  /// Gère l'ajout ou la suppression de la pizza dans la wishlist
  void toggleFavorite(BuildContext context,String id) async {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser?.id;

    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to manage your wishlist')),
      );
      return;
  
    }

    // // Inverse l'état local
    // bool newWishlistState = !isInWishlist;
    // setState(() {
    //   isInWishlist =
    //       newWishlistState; 
    // });

    // Effectue l'ajout ou la suppression
    final success = checkWishlistStatus(id)
        ? await wishlistController.addPizzaToWishlist(
            currentUserId,id)
        : await wishlistController.removePizzaFromWishlist(
            currentUserId, id);

    // Si l'opération échoue, réinitialise l'état local
  //   if (!success) {
  //     setState(() {
  //       isInWishlist = !isInWishlist;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Failed to update wishlist')),
  //     );
  //   }

  //   // Ajoutez des journaux pour déboguer
  //   print(isInWishlist
  //       ? 'Pizza added to wishlist: ${.id}'
  //       : 'Pizza removed from wishlist: ${widget.pizza.id}');
  // }
}
}