
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/remote_data_source/cart_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/command_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/ingredient_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/pizzaCustom_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/pizza_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/sale_remote_data_source.dart';
import 'package:front/data/datasources/remote_data_source/side_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/user_remote_datasource.dart';
import 'package:front/data/repositories/cart_repository_impl.dart';
import 'package:front/data/repositories/command_repository_impl.dart';
import 'package:front/data/repositories/ingredient_repository_impl.dart';
import 'package:front/data/repositories/pizzaCustom_repository_impl.dart';

import 'package:front/data/repositories/pizza_repository_impl.dart';
import 'package:front/data/repositories/sale_repository_impl.dart';


import 'package:front/data/repositories/user_repository_impl.dart';
import 'package:front/domain/repositories/cart_repository.dart';
import 'package:front/domain/repositories/command_repository.dart';
import 'package:front/domain/repositories/ingredient_repository.dart';
import 'package:front/domain/repositories/pizza_custom_repository.dart';


import 'package:front/domain/repositories/pizza_repository.dart';
import 'package:front/domain/repositories/sale_repository.dart';
import 'package:front/domain/repositories/sides_repository.dart';

import 'package:front/domain/repositories/user_repository.dart';
import 'package:front/domain/usecases/cart_usecases/add_sale.dart';
import 'package:front/domain/usecases/cart_usecases/create_cart.dart';
import 'package:front/domain/usecases/cart_usecases/get_cart.dart';
import 'package:front/domain/usecases/cart_usecases/remove_sale.dart';
import 'package:front/domain/usecases/command_usecases/create_command.dart';
import 'package:front/domain/usecases/command_usecases/delete_command.dart';
import 'package:front/domain/usecases/command_usecases/get_all_commands.dart';
import 'package:front/domain/usecases/command_usecases/get_command_by_id.dart';
import 'package:front/domain/usecases/command_usecases/update_command.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_all_ingredients.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredient_by_id.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredients_by_layer.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/create_pizza.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_all_custom_pizzas.dart';
import 'package:front/domain/usecases/pizzaCustom_usecases/get_custom_pizza_by_id.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:front/domain/usecases/pizza_usecases/get_pizza_by_id.dart';
import 'package:front/domain/usecases/pizza_usecases/search_pizzas.dart';
import 'package:front/domain/usecases/sale_usecases/create_sale.dart';
import 'package:front/domain/usecases/sale_usecases/delete_sale.dart';
import 'package:front/domain/usecases/sale_usecases/get_all_sales.dart';
import 'package:front/domain/usecases/sale_usecases/get_sale_by_id.dart';
import 'package:front/domain/usecases/sale_usecases/update_sale.dart';
import 'package:front/domain/usecases/side_usecases/get_side_by_id.dart';
import 'package:front/domain/usecases/user_usecases/get_user_by_id.dart';
import 'package:front/domain/usecases/user_usecases/login_user.dart';
import 'package:front/domain/usecases/user_usecases/register_user.dart';
import 'package:front/domain/usecases/user_usecases/update_password.dart';
import 'package:front/domain/usecases/user_usecases/update_user.dart';
import 'package:front/domain/usecases/wishlist_usecases/create_wishlist.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/remote_data_source/wishlist_remote_datasource.dart';
import 'data/repositories/side_repository_impl.dart';
import 'data/repositories/wishlist_repository_impl.dart';
import 'domain/repositories/wishlist_repository.dart';
import 'domain/usecases/side_usecases/get_all_sides.dart';
import 'domain/usecases/wishlist_usecases/add_to_wishlist.dart';
import 'domain/usecases/wishlist_usecases/get_wishlist.dart';
import 'domain/usecases/wishlist_usecases/remove_from_wishlist.dart';


final sl = GetIt.instance;

Future<void> init() async {

 // /* data sources */
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<PizzaRemoteDataSource>(
  () => PizzaRemoteDataSourceImpl(),);

   sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(),
  );
 
      sl.registerLazySingleton<IngredientsRemoteDataSource>(
    () => IngredientsRemoteDataSourceImpl(),
  );

     sl.registerLazySingleton<PizzaCustomRemoteDataSource>(
    () => PizzaCustomRemoteDataSourceImpl(),
  );
    sl.registerLazySingleton<SideRemoteDataSource>(
    () => SideRemoteDataSourceImpl(),
  );
    sl.registerLazySingleton<SaleRemoteDataSource>(
    () => SaleRemoteDataSourceImpl(),
  );
     sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(),
  );
     sl.registerLazySingleton<CommandRemoteDataSource>(
    () => CommandRemoteDataSourceImpl(),
  );


  /* repositories */
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
    sl.registerLazySingleton<PizzaRepository>(
      () =>  PizzaRepositoryImpl(pizzaRemoteDataSource: sl())
    );


 sl.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(wishlistRemoteDataSource: sl()));



sl.registerLazySingleton<IngredientRepository>(
  ()=>IngredientRepositoryImpl(ingredientsRemoteDataSource: sl())
  
);
sl.registerLazySingleton<PizzaCustomRepository>(
  ()=>PizzaCustomRepositoryImpl(custompizzaremoteDataSource: sl())
  
);
sl.registerLazySingleton<SidesRepository>(
  ()=>SideRepositoryImpl(sideRemoteDataSource: sl())
  
);
sl.registerLazySingleton<SaleRepository>(
  ()=>SaleRepositoryImpl(saleRemoteDataSource: sl())
  
);
sl.registerLazySingleton<CartRepository>(
  ()=>CartRepositoryImpl(cartremoteDataSource: sl())
  
);
sl.registerLazySingleton<CommandRepository>(
  ()=>CommandRepositoryImpl(commandRemoteDataSource: sl())
  
);

  // sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  // sl.registerLazySingleton<WishListRepository>(
  //     () => WishListRepositoryImpl(sl()));

  // sl.registerLazySingleton<CartRemoteDataSource>(
  //     () => CartRemoteDataSourceImpl());
  // sl.registerLazySingleton<WishListRemoteDataSource>(
  //     () => WishListRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePassword(sl()));
//pizza//
  sl.registerLazySingleton(() => getAllPizzasUseCase(sl()));
  sl.registerLazySingleton(() => GetPizzaByIdUsecase(sl()));
  sl.registerLazySingleton(() => SearchPizzas(sl()));


//ingredient 
  sl.registerLazySingleton(() => GetAllIngredients(sl()));
  sl.registerLazySingleton(() => GetIngredientById(sl()));
  sl.registerLazySingleton(() => GetIngredientsByLayer(sl()));
//sides 
  sl.registerLazySingleton(() => GetSideById(sl()));
  sl.registerLazySingleton(() => GetAllSidesUseCase(sl()));
  //Sales 
  sl.registerLazySingleton(() => GetSaleById(sl()));
  sl.registerLazySingleton(() => UpdateSale(sl()));
    sl.registerLazySingleton(() => CreateSale(sl()));
      sl.registerLazySingleton(() => DeleteSale(sl()));
        sl.registerLazySingleton(() => GetAllSales(sl()));
//cart
  sl.registerLazySingleton(() => CreateOrGetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddSaleToCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveSaleFromCartUseCase(sl()));
//wishlist
sl.registerLazySingleton(() => CreateWishListUseCase(sl()));
sl.registerLazySingleton(() => GetWishlist(sl()));
sl.registerLazySingleton(() => RemoveFromWishlist(sl()));
sl.registerLazySingleton(() => AddToWishlist(sl()));
//customPizza 
sl.registerLazySingleton(() => GetCustomPizzaById(sl()));
sl.registerLazySingleton(() => GetAllCustomPizzas(sl()));
sl.registerLazySingleton(() => CreatePizza(sl()));
//command 
sl.registerLazySingleton(() => CreateCommand(sl()));
sl.registerLazySingleton(() => DeleteCommand(sl()));
sl.registerLazySingleton(() => UpdateCommand(sl()));
sl.registerLazySingleton(() => GetAllCommands(sl()));
sl.registerLazySingleton(() => GetCommandById(sl()));
}