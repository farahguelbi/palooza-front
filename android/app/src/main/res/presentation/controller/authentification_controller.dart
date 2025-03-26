import 'dart:io';

import 'package:front/core/utils/string_const.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/token.dart';
import 'package:front/domain/entities/user.dart';
import 'package:front/domain/usecases/cart_usecases/create_cart.dart';
import 'package:front/domain/usecases/user_usecases/clear_user_image.dart';
import 'package:front/domain/usecases/user_usecases/forget_password.dart';
import 'package:front/domain/usecases/user_usecases/get_user_by_id.dart';
import 'package:front/domain/usecases/user_usecases/login_user.dart';
import 'package:front/domain/usecases/user_usecases/logout.dart';
import 'package:front/domain/usecases/user_usecases/register_user.dart';
import 'package:front/domain/usecases/user_usecases/reset_password.dart';
import 'package:front/domain/usecases/user_usecases/update_image.dart';
import 'package:front/domain/usecases/user_usecases/update_password.dart';
import 'package:front/domain/usecases/user_usecases/update_user.dart';
import 'package:front/domain/usecases/user_usecases/verify_otp.dart';
import 'package:front/domain/usecases/wishlist_usecases/create_wishlist.dart';
import 'package:front/presentation/controller/cart_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
import 'package:front/presentation/screens/Home_pizza_Screen.dart';
import 'package:front/presentation/screens/login_page.dart';
import 'package:front/presentation/screens/main_page.dart';
import 'package:front/presentation/screens/otp_screen.dart';
import 'package:front/presentation/screens/reset_password_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AuthenticationController extends GetxController {
  
  late Token token;//=>pour stocker le jeton(token) de l'user une fois connecté
  late String myemail; //=>enregistre l'email de user
  bool termsAccepted =false; //=>indique si l'user a acceptée les conditions génerales ?!
  bool isLoading =false; //=>utilisé pour afficher un indicateur de chargement pendant une action 
  late User currentUser;// =>contient info de currentUser
  String userImage = '';
  File? f; 
  String?address;
  String? gender;
  String? birthDate;
  final ImagePicker _picker = ImagePicker();
  XFile ? img;




// les methodes 
  bool get missingData =>
      currentUser.phone == null ||
      currentUser.address == null ||
      currentUser.birthDate == null ||
      currentUser.gender == null;

  void setBirthDate(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    birthDate = '$year-$month-$day';
    update();
  }
   Future<void> pickImage() async {
    try {
      img = await _picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        f = File(img!.path);
        setuserImage(basename(f!.path));
      }
    } catch (e) {
      print(e);
    }
  }
 void setuserImage(String image) {
    userImage = image;
     //update([ControllerID.UPDATE_USER_IMAGE]);
  }
  void setGender(String value) {
    gender = value;
    update();
  }


  void aceptTerms(bool v) {
    termsAccepted = v;
    update(['terms']);
  }

 Future<String> registerUser({
  required TextEditingController email,
  required TextEditingController firstName,
  required TextEditingController lastName,
  required TextEditingController password,
  required TextEditingController cpassword,
  required BuildContext context,
}) async {
  try {
        print("Starting the registration process...");

    // Call the registration use case
    final res = await RegisterUser(sl()).call(
      email: email.text,
      password: password.text,
      address: '', // Empty address as static value
      phone: '', // Empty phone as static value
      firstName: firstName.text,
      lastName: lastName.text,
      imageUrl: '',
      birthDate: DateTime.parse("2020-07-17T03:18:31.177769-04:00"), 
      gender: '', // Static gender
    ); 

    String userId = '';
    String message = '';

    // Handle success and failure cases
    res.fold(
      (failure) {
        // On failure
        message = failure.message ?? 'An unknown error occurred';
        print("Registration failed: $message");

        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return message;
      },
      (success) {
        // On success
        userId = success; // Assuming success returns user ID
        message = "Account created successfully!";
        final CreateOrGetCartUseCase createCartUseCase = sl<CreateOrGetCartUseCase>();
         createCartUseCase(userId: userId);
         final CreateWishListUseCase createWishListUseCase = sl<CreateWishListUseCase>();
         createWishListUseCase(userId: userId);

        // Clear input fields
        email.clear();
        password.clear();
        firstName.clear();
        lastName.clear();
        cpassword.clear();

        // Reset optional fields
        address = null;
        gender = null;
        birthDate = null;
        termsAccepted = false;

        // Update UI
        update();
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },

    );

    // Return user ID on success, or an empty string on failure
    return userId;
  } catch (e) {
    // Handle unexpected errors
        print("An error occurred during registration: $e");

    Fluttertoast.showToast(
      msg: "Unexpected error occurred: $e",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return '';
  }
}


  Future<void> login(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext context}) async {
    isLoading = true;
    update();
    final res =
        await LoginUsecase(sl())(email: email.text, password: password.text);
    res.fold(
        (l) {
          isLoading = false;
          update();
          return Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        }, (r) async {
      token = r;
      email.clear();
      password.clear();
         final userRes =await getCurrentUser(r.userId);
         final CartController cartController=Get.find();
        await cartController.getCartByUser(currentUser.id!);
         final WishlistController wishlistController=Get.find();
         print(currentUser.id);
        
        await wishlistController.getWishlistByUserId(currentUser.id!);
        


        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainPage()));

      // await getOneUser(r.userId).then((value) async {
      //   final WishListController wishListController = Get.find();
      //   final CartController cartController = Get.find();
      //   // final CategoryController categorControlller = Get.find();
      //   final AuthenticationController authController = Get.find();
      //   await wishListController
      //       .getUserWishlist(authController.currentUser.id!);
      //   await cartController.getUserCart(authController.currentUser.id!);
      //
      // });
    });
   
  }

  Future<void> logout(BuildContext context) async {
    isLoading = false;
    update();
    await LogoutUseCase(sl())();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()));
  }
    Future<void> sendFrogetPasswordRequest(TextEditingController useremail,
      String destionation, BuildContext context) async {
    String message = '';
    final res = await ForgetPasswordUsecase(sl())(
        email: useremail.text, destination: destionation);
    res.fold((l){ 
       print("Error Response: ${l.message}");
      message = l.message!;
    }, (r) {
       print("Success Response: Email sent successfully.");
      myemail = useremail.text;
      useremail.clear();
      message = "email sent";
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => OtpScreen()));
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> verifyOTP(
      TextEditingController otp, BuildContext context) async {
    if (otp.text.length == 4 && isNumeric(otp.text)) {
      final res = await OTPVerificationUsecase(sl())(
          email: myemail, otp: int.parse(otp.text));
      res.fold(
          (l) => Fluttertoast.showToast(
              msg: l.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0), (r) {
        otp.clear();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
      });
    }
  }

  Future<void> resetPassword(TextEditingController password,
      TextEditingController cpassword, BuildContext context) async {
    String message = '';
    final res = await ResetPasswordUsecase(sl())(
        password: password.text, email: myemail);
    res.fold((l) => message = l.message!, (r) {
      password.clear();
      cpassword.clear();
      message = "password_reset";
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool isNumeric(String number) {
    for (int i = 0; i < number.length; i++) {
      if (!'0123456789'.contains(number[i])) {
        return false;
      }
    }
    return true;
  }
    Future<void> getCurrentUser(String userId) async {
    final res = await GetUserByIdUsecase(sl())(userId: userId);
    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0), (r) {
      currentUser = r;
      gender = currentUser.gender;
      birthDate = currentUser.birthDate.toString();
    });
    update();
  }
  Future<void> updateUser({
  required String id,
  required TextEditingController firstName,
  required TextEditingController lastName,
  required String address,
  required String phone,
  required String gender,
  required DateTime birthDate,
  required BuildContext context,
}) async {
  // Indique que le processus de mise à jour est en cours
  isLoading = true;
  update(); // Met à jour l'interface utilisateur si nécessaire (via GetX)

  final result = await UpdateUserUsecase(sl()).call(
    id: id,
    firstName: firstName.text,
    lastName: lastName.text,
    address: address,
    phone: phone,
    gender: gender,
    birthDate: birthDate,
  );

  result.fold(
    (failure) {
      // Gestion de l'échec
      isLoading = false;
      update();
      print("Update failed: ${failure.message}");

      Fluttertoast.showToast(
        msg: failure.message ?? "An error occurred",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    },
    (success) {
      // Gestion du succès
      isLoading = false;
      update();
      print("Update successful");

      Fluttertoast.showToast(
        msg: "Profile updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    },
  );
}
 Future<void> updateImage(BuildContext context) async {
  print(currentUser.id);
    if (userImage == '') {
      await ClearUserImageUsecase(sl())(currentUser.id!);
    } else {
      await UpdateImageUsecase(sl())(image: f!, userId: currentUser.id!);
    }
    await getCurrentUser(currentUser.id!).then((value) =>
        Fluttertoast.showToast(
            msg:"profile_picture_updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0));
  }
  Future<void> updatePassword(TextEditingController currentPassword,
      TextEditingController password, BuildContext context) async {
    // Ensure currentUser is initialized first
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      await getCurrentUser(currentUser.id!); // Fetch current user if null
    }

    // Check if currentUser is still null after fetching
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      Fluttertoast.showToast(
          msg: "User data is not available. Please log in again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    String message = 'error';
    final res = await UpdatePassword(sl())(
      userId: currentUser.id!,
      newPassword: password.text,
      oldPassword: currentPassword.text,
    );
    res.fold((l) => message = l.message!, (r) async {
      message = "profile_updated";
      password.clear();
      currentPassword.clear();
      await getCurrentUser(currentUser.id!);
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

