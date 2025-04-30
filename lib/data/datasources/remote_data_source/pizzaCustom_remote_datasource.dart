
import 'dart:convert';
import 'package:front/data/models/pizzaCustom_model.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:http/http.dart' as http;
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';

abstract class PizzaCustomRemoteDataSource {
  Future<List<PizzacustomModel>> getAllCustomPizzas();
  Future<PizzacustomModel> getCustomPizzaById(String id);
  Future<String> createPizza(String selectedSize, List<Map<String,dynamic>> ingredients, String userID , double price);
}

class PizzaCustomRemoteDataSourceImpl implements PizzaCustomRemoteDataSource {

  PizzaCustomRemoteDataSourceImpl();

  @override
  Future<List<PizzacustomModel>> getAllCustomPizzas() async {
    // throw UnimplementedError();
    try {
  
      final response = await http.get(
        Uri.parse(ApiConst.getAllCustomPizzas),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['data'];
        return jsonResponse
            .map((data) => PizzacustomModel.fromJson(data))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('Error fetching all pizzas: $e');
      throw ServerException();
    }
  }

  @override
  Future<PizzacustomModel> getCustomPizzaById(String id) async {
    // throw UnimplementedError();
    try {
      final response = await http.get(
 Uri.parse('${ApiConst.getCustomPizzaById}/$id'),     
    headers: {'Content-Type': 'application/json'},
      );

     
    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Check if the response contains the 'data' field
      if (responseBody.containsKey('data')) {
        final Map<String, dynamic> jsonResponse = responseBody['data'];
        return PizzacustomModel.fromJson(jsonResponse);
      } else {
        throw ServerException(message: "Invalid response format: 'data' field missing");
      }
    } else {
      throw ServerException(message: "Failed to fetch pizza: ${response.statusCode}");
    }
  } catch (e) {
    print('Error fetching pizza by ID: $e');
    throw ServerException(message: "Failed to fetch pizza: ${e.toString()}");
  }
}
  @override
  Future<String> createPizza(String selectedSize, List<Map<String,dynamic>> ingredients , String userID , double price) async {
    try {
      print(ingredients);
      final response = await http.post(
        Uri.parse(ApiConst.createPizza),
        headers: {'Content-Type': 'application/json'},
        body:json.encode( {
          "size": selectedSize,
          "ingredients": ingredients,
          "userId" : userID,
          "price" : price
        },
      ));
          print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        
        final pizzaId = responseData['data']['_id'];
         print('Pizza created successfully with ID: $pizzaId');
        return pizzaId;
      } else {
              print('Error: API request failed with status code ${response.statusCode}');

        throw ServerException();
      }
    } catch (e) {
      print('Error creating pizza: ${e.toString()}');
      throw ServerException();
    }
  }
}