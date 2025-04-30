
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/data/datasources/remote_data_source/pizzaCustom_remote_datasource.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/repositories/pizza_custom_repository.dart';


class PizzaCustomRepositoryImpl implements PizzaCustomRepository {
  final PizzaCustomRemoteDataSource custompizzaremoteDataSource;

  PizzaCustomRepositoryImpl({required this.custompizzaremoteDataSource});

  @override
  Future<Either<Failure, String>> createPizza(
    String selectedSize, 
    List<Map<String,dynamic>> ingredients,
    String userID ,
     double price
  ) async {
    try {
      final pizza = await custompizzaremoteDataSource.createPizza(selectedSize, ingredients,userID,price);
      return Right(pizza);  // Return the created pizza
    } catch (e) {
      return Left(ServerFailure());  // Return failure in case of an error
    }
  }

  @override
  Future<Either<Failure, List<PizzaCustom>>> getAllCustomPizzas() async {
    try {
      final pizzas = await custompizzaremoteDataSource.getAllCustomPizzas();
      return Right(pizzas);  // Return the list of pizzas
    } catch (e) {
      return Left(ServerFailure());  // Return failure in case of an error
    }
  }

  @override
  Future<Either<Failure, PizzaCustom>> getCustomPizzaById(String id) async {
    try {
      final pizza = await custompizzaremoteDataSource.getCustomPizzaById(id);
      return Right(pizza);  // Return the fetched pizza by ID
    } catch (e) {
      return Left(ServerFailure());  // Return failure in case of an error
    }
  }




}