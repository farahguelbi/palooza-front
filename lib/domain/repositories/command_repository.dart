import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../entities/command.dart';

abstract class CommandRepository {

   Future<Either<String, Command>> createCommand(Map<String, dynamic> commandData);
  Future<Either<String, List<Command>>> getAllCommands();
  Future<Either<String, Command>> getCommandById(String id);
  Future<Either<String, Command>> updateCommand(String id, Map<String, dynamic> commandData);
  Future<Either<String, void>> deleteCommand(String id);
}
