// lib/data/repositories/command_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/command.dart';
import '../../domain/repositories/command_repository.dart';
import '../datasources/remote_data_source/command_remote_datasource.dart';
import '../models/command_model.dart';

class CommandRepositoryImpl implements CommandRepository {
  final CommandRemoteDataSource commandRemoteDataSource;

  CommandRepositoryImpl({required this.commandRemoteDataSource});




@override
  Future<Either<String, Command>> createCommand(Map<String, dynamic> commandData) async {
    try {
      final result = await commandRemoteDataSource.createCommand(commandData);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
  @override
  Future<Either<String, List<Command>>> getAllCommands() async {
    try {
      final result = await commandRemoteDataSource.getAllCommands();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }



  @override
  Future<Either<String, Command>> getCommandById(String id) async {
    try {
      final result = await commandRemoteDataSource.getCommandById(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Command>> updateCommand(String id, Map<String, dynamic> commandData) async {
    try {
      final result = await commandRemoteDataSource.updateCommand(id, commandData);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteCommand(String id) async {
    try {
      await commandRemoteDataSource.deleteCommand(id);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }














 
}
