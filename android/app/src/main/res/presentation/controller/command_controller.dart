import 'package:front/di.dart';
import 'package:front/domain/entities/command.dart';
import 'package:front/domain/usecases/command_usecases/create_command.dart';
import 'package:front/domain/usecases/command_usecases/delete_command.dart';
import 'package:front/domain/usecases/command_usecases/get_all_commands.dart';
import 'package:front/domain/usecases/command_usecases/get_command_by_id.dart';
import 'package:front/domain/usecases/command_usecases/update_command.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



class CommandController extends GetxController {

Command?currentCommand;
  List<Command> userCommands= [];
  bool isLoading=false;
  String errorMessage='';
  // Future<void>getAllCommands()async{
  //   isLoading=true;
  //   update();
  //   final result=await GetAllCommands(sl())();
  //   result.fold(
  //     (faillure){
  //       print("erreur fetching commands:$faillure");
  //       isLoading=false;
  //       update();
  //     },
  //     (command){
  //       userCommads=command;
  //       isLoading=false;
  //       update();

  //     }

  //   );

  // }
    Future<bool> getAllCommands() async {
    isLoading = true;
    update();
    final result = await GetAllCommands(sl())();
    bool success = false;
    result.fold(
      (failure) {
        print("Error fetching commands: $failure");
        errorMessage = "Error fetching commands: $failure";
      },
      (commands) {
        userCommands = commands;
        success = true;
      },
    );
    isLoading = false;
    update();
    return success;
  }

  // Future<void>getCommandById(String id)async {
  //   isLoading=true;
  //   update();
  //   final result=await GetCommandById(sl())(id);
  //   result.fold(
  //     (faillure){
  //       print("error fetching command:$faillure");
  //     },
  //     (command){
  //       currentCommand=command;


  //     },

  //   );
  //   isLoading=false;
  //   update();
  // }
   Future<bool> getCommandById(String id) async {
    isLoading = true;
    update();
    final result = await GetCommandById(sl())(id);
    bool success = false;
    result.fold(
      (failure) {
        print("Error fetching command: $failure");
        errorMessage = "Error fetching command: $failure";
      },
      (command) {
        currentCommand = command;
        success = true;
      },
    );
    isLoading = false;
    update();
    return success;
  }
  // Future<void> createNewCommand(Map<String, dynamic> commandData) async {
  //   final result = await CreateCommand(sl())(commandData);
  //   result.fold(
  //     (failure) {
  //       print("Error creating command: $failure");
  //     },
  //     (data) {
  //       userCommads.add(data);
  //       update();
  //     },
  //   );
  // }
    Future<bool> createNewCommand(Map<String, dynamic> commandData) async {
    final result = await CreateCommand(sl())(commandData);
    bool success = false;
    result.fold(
      (failure) {
        print("Error creating command: $failure");
      },
      (command) {
        userCommands.add(command);
        update();
        success = true;
      },
    );
    return success;
  }
  //   Future<void> updateExistingCommand(String id, Map<String, dynamic> commandData) async {
  //   final result = await UpdateCommand(sl())(id, commandData);
  //   result.fold(
  //     (failure) {
  //       print("Error updating command: $failure");
  //     },
  //     (data) {
  //       userCommads = userCommads.map((cmd) => cmd.id == id ? data : cmd).toList();
  //       update();
  //     },
  //   );
  // }
    Future<bool> updateExistingCommand(String id, Map<String, dynamic> commandData) async {
    final result = await UpdateCommand(sl())(id, commandData);
    bool success = false;
    result.fold(
      (failure) {
        print("Error updating command: $failure");
      },
      (updatedCommand) {
        userCommands = userCommands.map((cmd) => cmd.id == id ? updatedCommand : cmd).toList();
        update();
        success = true;
      },
    );
    return success;
  }
  // Future<void> deleteExistingCommand(String id) async {
  //   final result = await DeleteCommand(sl())(id);
  //   result.fold(
  //     (failure) {
  //       print("Error deleting command: $failure");
  //     },
  //     (_) {
  //       userCommads.removeWhere((cmd) => cmd.id == id);
  //       update();
  //     },
  //   );
  // }
    Future<bool> deleteExistingCommand(String id) async {
    final result = await DeleteCommand(sl())(id);
    bool success = false;
    result.fold(
      (failure) {
        print("Error deleting command: $failure");
      },
      (_) {
        userCommands.removeWhere((cmd) => cmd.id == id);
        update();
        success = true;
      },
    );
    return success;
  }
}
