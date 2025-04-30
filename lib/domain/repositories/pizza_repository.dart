import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../entities/pizza.dart';

abstract class PizzaRepository {
  Future<Either<Failure, List<Pizza>>> getAllPizzas();
  Future<Either<Failure, Pizza>> getPizzaById({required String id});
  Future<Either<Failure, List<Pizza>>> getPizzaByType(String type);
  Future<Either<Failure, List<Pizza>>> searchPizzas(String name);
}
