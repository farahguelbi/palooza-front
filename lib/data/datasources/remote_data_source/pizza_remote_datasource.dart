import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;

import '../../models/pizza_model.dart';

abstract class PizzaRemoteDataSource {
  Future<List<PizzaModel>> getAllPizzas();
  Future<PizzaModel> getPizzaById(String id);
  Future<void> createPizza(Map<String, dynamic> pizzaData);
  Future<List<PizzaModel>> getPizzaByType(String type);
  Future<List<PizzaModel>> searchPizzas(String name);
}

class PizzaRemoteDataSourceImpl implements PizzaRemoteDataSource {
 

  PizzaRemoteDataSourceImpl();

 
   @override
  Future<List<PizzaModel>> getAllPizzas() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConst.getAllPizzas),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final pizzas = jsonResponse.map((data) => PizzaModel.fromJson(data)).toList();
        print('Parsed Pizzas: $pizzas');
        return pizzas;
      } else {
        print('Server returned error: ${response.statusCode}');
        throw ServerException();
      }
    } catch (e) {
      print('Error in getAllPizzas: $e');
      throw ServerException(); // Customize this if needed for more granular error handling
    }
  }


  @override
  Future<PizzaModel> getPizzaById(String id) async {
    final response = await http.get(
    
      Uri.parse('${ApiConst.getPizzaById}/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return PizzaModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> createPizza(Map<String, dynamic> pizzaData) async {
    final response = await http.post(
      Uri.parse(ApiConst.createPizza),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pizzaData),
    );

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<List<PizzaModel>> getPizzaByType(String type) async {
    final response = await http.get(
      Uri.parse('${ApiConst.getPizzaById}/$type'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PizzaModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PizzaModel>> searchPizzas(String name) async {
    final response = await http.get(
      Uri.parse(ApiConst.searchPizzas(name)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PizzaModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }
}
