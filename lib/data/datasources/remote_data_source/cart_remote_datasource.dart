import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/local_data_source/settings_local_data_source.dart';
import 'package:front/data/datasources/remote_data_source/user_remote_datasource.dart';
import 'package:front/data/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import '../../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> createOrGetCart(String userId);
  Future<void> addSaleToCart(String userId, String saleId);
  Future<CartModel> getCart(String userId);
  Future<void> removeSaleFromCart(String userId, String saleId);
  Future<void> clearCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
   Future<TokenModel?>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
     Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
     return await token.then((value) async{
      if(value!.expiryDate.isBefore(DateTime.now())){
        
      }
    });
  }


  CartRemoteDataSourceImpl();

  @override
  Future<CartModel> createOrGetCart(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.createOrGetCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CartModel.fromJson(jsonResponse);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> addSaleToCart(String userId, String saleId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.addSaleToCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId,'saleId':saleId}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
 Future<CartModel> getCart(String userId) async {
    try {
      print(" [API REQUEST] Fetching Cart for User: $userId");


      final response = await http.get(
        Uri.parse(ApiConst.getCart(userId)),
        headers: {'Content-Type': 'application/json'},
      );

      print(" [API RESPONSE] Status Code: ${response.statusCode}");
      print(" [API RESPONSE] Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // 🛠 Vérification de la structure JSON avant parsing
        if (!jsonResponse.containsKey("salesID")) {
          print(" [ERROR] API response does NOT contain 'salesID'!");
        } else if (jsonResponse["salesID"] == null) {
          print(" [ERROR] 'salesID' is NULL in API response!");
        } else if (jsonResponse["salesID"] is! List) {
          print("[ERROR] 'salesID' is NOT a List! Type: ${jsonResponse["salesID"].runtimeType}");
        } else {
          print("[SUCCESS] 'salesID' is a valid List with ${jsonResponse["salesID"].length} items.");
        }

        return CartModel.fromJson(jsonResponse);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(" [EXCEPTION] Error Fetching Cart: $e");
      throw ServerException();
    }
  }





  @override
  Future<void> removeSaleFromCart(String userId, String saleId) async {
    try {
      final response = await http.delete(
        Uri.parse(ApiConst.removeSaleFromCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId, 'saleId': saleId}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.clearCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}


