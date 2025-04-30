import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;

import '../../models/command_model.dart';

abstract class CommandRemoteDataSource {
 
   Future<CommandModel> createCommand(Map<String, dynamic> commandData);
  Future<List<CommandModel>> getAllCommands();
  Future<CommandModel> getCommandById(String id);
  Future<CommandModel> updateCommand(String id, Map<String, dynamic> commandData);
  Future<void> deleteCommand(String id);
}

class CommandRemoteDataSourceImpl implements CommandRemoteDataSource {

  CommandRemoteDataSourceImpl();


@override
Future<CommandModel> createCommand(Map<String, dynamic> commandData) async {
  try {

    // Ensure the saleId field is a single value
    if (commandData.containsKey('saleId')) {
      if (commandData['saleId'] is List) {
        // If saleId is an array, use the first value
        commandData['saleId'] = commandData['saleId'].first;
      }
    }

    // Log the request data for debugging
    print('Request Data: ${jsonEncode(commandData)}');

    // Make the HTTP POST request
    print('Making HTTP POST request...');
    final response = await http.post(
      Uri.parse(ApiConst.createCommand),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(commandData),
    );

    // Log the response status code
    print('Response Status Code: ${response.statusCode}');

    // Check the response status code
    if (response.statusCode == 201) {
      // Log the response body
      print('Response Body: ${response.body}');

      // Parse the response body
      print('Parsing response body...');
      final data = jsonDecode(response.body);

      // Log the parsed data
      print('Parsed Data: $data');

      // Convert JSON to CommandModel
      print('Creating CommandModel from JSON...');
      return CommandModel.fromJson(data); // Assuming backend returns the created command
    } else {
      // Log the error response body
      print('Error Response Body: ${response.body}');

      // Throw an exception for non-201 status codes
      throw ServerException();
    }
  } on FormatException catch (e) {
    // Log URL parsing errors
    print('FormatException: ${e.message}');
    throw ServerException();
  } on http.ClientException catch (e) {
    // Log network-related errors
    print('ClientException: ${e.message}');
    throw ServerException();
  } on Exception catch (e) {
    // Log any other exceptions
    print('Unexpected Exception: ${e.toString()}');
    throw ServerException();
  } finally {
    // Log the end of the process
    print('Command creation process completed.');
  }
}


  @override
  Future<CommandModel> getCommandById(String id) async {
    final response = await http.get
    (Uri.parse( '${ApiConst.getCommandById} + $id'));
    

    if (response.statusCode == 200) {
      return CommandModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch command");
    }
  }

  @override
  Future<CommandModel> updateCommand(String id, Map<String, dynamic> commandData) async{
   final response = await http.post(
      Uri.parse('${ApiConst.updateCommand} + $id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(commandData),
    );

    if (response.statusCode == 200) {
      return CommandModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update command");
    }
  }
    @override
  Future<void> deleteCommand(String id) async {
    final response = await http.delete(Uri.parse(ApiConst.baseUrl + ApiConst.deleteCommand + id));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete command");
    }
  }


  @override
  Future<List<CommandModel>> getAllCommands() async {
    final response = await http.get(
      Uri.parse(ApiConst.getAllCommands),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      // final data = jsonDecode(response.body) as List;
      return jsonList.map((json) => CommandModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}

