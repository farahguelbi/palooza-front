import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../domain/entities/ingredient.dart';
import '../../domain/repositories/ingredient_repository.dart';
import '../datasources/remote_data_source/ingredient_remote_datasource.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientsRemoteDataSource ingredientsRemoteDataSource;

  IngredientRepositoryImpl({required this.ingredientsRemoteDataSource});

   @override
  Future<Either<Failure, List<Ingredient>>> getAllIngredients() async {
    try {
          print('Fetching ingredients from remote data source...');

      final ingredients = await ingredientsRemoteDataSource.getAllIngredients();
          print('Fetched ingredients: $ingredients');

      return Right(ingredients);
    } catch (e) {
          print('Error in repository: $e');

      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, Ingredient>> getIngredientById(String id) async {
    try {
      final ingredient = await ingredientsRemoteDataSource.getIngredientById(id);
      return Right(ingredient);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Map<String, List<Ingredient>>>> getIngredientsByLayer() {
    // TODO: implement getIngredientsByLayer
    throw UnimplementedError();
  }

}
