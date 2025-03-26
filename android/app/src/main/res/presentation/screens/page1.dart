import 'package:flutter/material.dart';
import 'package:front/domain/usecases/user_usecases/get_user_by_id.dart';
import 'package:front/presentation/controller/cart_controller.dart';
import 'package:front/presentation/controller/command_controller.dart';
import 'package:front/presentation/controller/custom_pizza_controller.dart';
import 'package:front/presentation/controller/sale_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
import 'package:front/presentation/screens/main_page.dart';
import '../controller/side_controller.dart';
import 'page2.dart';
import 'SignUp_page.dart';
import 'login_page.dart';
import 'package:front/domain/usecases/user_usecases/auto_login.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/screens/Home_pizza_Screen.dart';
import 'package:front/di.dart';
import 'package:get/get.dart';

class Page1 extends StatelessWidget {
  
 // Define a nullable Future
  Future<bool> _autoLogin(BuildContext context) async {
    bool isLoggedIn = true;
    // Initialize the authentication controller
    Get.put(AuthenticationController());
    final AuthenticationController authController = Get.find();
    
    Get.put(WishlistController());
    Get.put(SideController());
    Get.put(SaleController());
     Get.put(CustomPizzaController());
    Get.put(CartController());
    Get.put(CommandController());





    // Perform the auto-login logic
 final autoLoginResult = await AutoLoginUsecase(sl()).call();
autoLoginResult.fold(
  (failure) {
    isLoggedIn = false;
  },
  (token) async {
    
    if (token != null) {
      authController.token = token;
        final user = await GetUserByIdUsecase(sl()).call( userId: token.userId);
         user.fold((l) {
          isLoggedIn = false;
        }, (token) async {
          authController.currentUser = token;
          // await wishListController
          //     .getUserWishlist(authController.currentUser.id!);
          // await cartController.getUserCart(authController.currentUser.id!);
          // Get.put(NotificationsController());
        });
      print(authController.currentUser.id);

    }else{
      isLoggedIn=false;
    }
  },
);
Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => isLoggedIn ? const MainPage(): const LoginPage()));
    }
    );

return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/pizza.jpg', // Correct path to your image
              fit: BoxFit.cover,
            ),
          ),
          // Title "PIZZAPALOOZA" lower on the screen
          Positioned(
            top: 100, // Adjust here to position it lower (100px from the top)
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'PIZZAPALOOZA',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.withOpacity(0.6),
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Descriptive Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Pizza so irresistible, your hunger won’t stand a chance!',
                  style: TextStyle(
                    fontFamily: "Wendy One",
                    fontSize: 19,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // 'GET STARTED' Button with FutureBuilder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.6), // Semi-transparent orange background
                    borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                  ),
                  child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20), // Adjust height of the button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Match the container's rounded corners
                            ),
                          ),
                          onPressed: () async{
                            await _autoLogin(context);
                          
                          },
                          child: const Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                    
                      
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
