import 'package:dartz/dartz.dart';
import 'package:front/data/models/sale_model.dart';
import '../../core/errors/failures/failures.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../datasources/remote_data_source/sale_remote_data_source.dart';

class SaleRepositoryImpl implements SaleRepository {
  final SaleRemoteDataSource saleRemoteDataSource;

  SaleRepositoryImpl({required this.saleRemoteDataSource});

  @override
  Future<Either<Failure, List<Sale>>> getAllSales() async {
    try {
      final sales = await saleRemoteDataSource.getAllSales();
      return Right(sales);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sale>> getSaleById(String saleId) async {
    try {
      final sale = await saleRemoteDataSource.getSaleById(saleId);
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

 




  @override
  Future<Either<Failure, Unit>> deleteSale(String saleId) async {
    try {
      await saleRemoteDataSource.deleteSale(saleId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> createSale({required String userID, required String pizzaId, required int quantityPizza,required totalPrice,required pizzaType}) async {
   try {
     
    
      final sale = await saleRemoteDataSource.createSale(userID, pizzaId, quantityPizza, totalPrice,pizzaType );
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
@override
Future<Either<Failure, void>> addMultipleSides(
    String saleId, List<SaleSide> sides, double totalPrice) async {
  try {
    print("Calling addMultipleSides in SaleRemoteDataSource...");
    print("Sale ID: $saleId");
    print("Sides to add: ${sides.map((s) => {'sideId': s.sideId, 'quantity': s.quantity}).toList()}");
    print("Total Price: $totalPrice");

    await saleRemoteDataSource.addMultipleSides(
      saleId,
      sides.map((side) => SaleSideModel(sideId: side.sideId, quantity: side.quantity)).toList(),
      totalPrice,
    );

    print("Successfully added sides to sale ID: $saleId");
    return const Right(null);
  } catch (error) {
    print("Error in addMultipleSides: $error");
    return Left(ServerFailure());
  }
}

  
  @override
  Future<Either<Failure, Unit>> updateSale(Sale sale) {
    // TODO: implement updateSale
    throw UnimplementedError();
  }
}
  

