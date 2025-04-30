import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/pizzaCustom.dart';

abstract class PizzaCustomRepository {

  Future<Either<Failure, String>> createPizza(
      String selectedSize, List<Map<String,dynamic>> ingredients,String userID , double price);   
       Future<Either<Failure, List<PizzaCustom>>> getAllCustomPizzas();

  Future<Either<Failure, PizzaCustom>> getCustomPizzaById(String id);
}
