class ApiConst {
  static const baseUrl ='http://192.168.1.11:5000/api';

  // Authentication APIs
  static const RegisterUser = '$baseUrl/users/register'; 
  static const login = '$baseUrl/users/login';
  static const getOneUser = '$baseUrl/users';
  static const updateUser = '$baseUrl/users/update';
  static const updateUserPassword = '$baseUrl/users/update-password';
  static const verfiyCode = "$baseUrl/users/verify-code";
  static const resetPassword = "$baseUrl/users/reset-password";
  static const delete = "$baseUrl/users/delete";
  static const logout = "$baseUrl/users/logout";
  static const getAllUsers = "$baseUrl/users/all";
  static const forgetPassword = "$baseUrl/users/forget-password";
  static const updateUserImage = '$baseUrl/users/updateImage';



  // Wishlist APIs
  static const addToWishlist = '$baseUrl/wishlist/add';
  static const removeFromWishlist = '$baseUrl/wishlist/remove';
  // static String getWishlist  (String userId) => '$baseUrl/wishlist/$userId';
    static String getWishlist = '$baseUrl/wishlist';

  static const createWishList = '$baseUrl/wishList/create';


  // Ingredient APIs
  static const getAllIngredients = '$baseUrl/ingredients';
  static const  getIngredientById ='$baseUrl/ingredients';
  static const  getIngredientsByLayer = '$baseUrl/ingredients/by-layer';

  // Command APIs
  // static const createCommand = '$baseUrl/command/checkout';
  // static String getCommandById(String commandId) => '$baseUrl/command/$commandId';
  // static String getAllCommands(String userId) => '$baseUrl/commands?userId=$userId';
  // static const cancelCommand = '$baseUrl/command/cancel';
  // static const completeCommand = '$baseUrl/command/complete';
  // static const changePaymentStatus = '$baseUrl/command/payment-status';
  // static const changePaymentMethod = '$baseUrl/command/change-payment-method';
   static const String createCommand = '$baseUrl/command';
  static const String getAllCommands = "'$baseUrl/commands'";
  static const String getCommandById = "'$baseUrl/commands/'";
  static const String updateCommand = "'$baseUrl/commands/'";
  static const String deleteCommand = "'$baseUrl/commands/'";

  // Cart APIs
  static const createOrGetCart = '$baseUrl/cart/cart';
  static const addSaleToCart = '$baseUrl/cart/cart/add-sale';
  static String getCart(String userId) => '$baseUrl/cart/cart/$userId';
  static const removeSaleFromCart = '$baseUrl/cart/cart/remove-sale';
  static const clearCart = '$baseUrl/cart/cart/clear';

  // Pizza APIs
static const String getAllPizzas = '$baseUrl/pizzas';
static const String getPizzaById = '$baseUrl/pizzas';
static String getPizzaByType(String type) => '$baseUrl/pizzas/type/$type';
static String searchPizzas(String name) => '$baseUrl/pizzas/search/$name';


  // Side APIs
static const String getAllSides = '$baseUrl/sides';
static String getSideById(String id) => '$baseUrl/sides/$id';
static const String createSide = '$baseUrl/sides';

static String deleteSide(String id) => '$baseUrl/sides/$id';

 // Sale APIs
static const String createSale = '$baseUrl/sales/create';
static const String getAllSales = '$baseUrl/sales';
static const String AddMultipleSides = '$baseUrl/sales/add-sides';
static String getSaleById(String id) => '$baseUrl/sales/$id';
static String updateSale ='$baseUrl/sales/update';
static String deleteSale(String id) => '$baseUrl/sales/delete/$id';

  // Type APIs
static String getTypeById(String id) => '$baseUrl/types/$id';
//customPizza
  static const getAllCustomPizzas = '$baseUrl/pizzaCustom';
  static const  getCustomPizzaById ='$baseUrl/pizzaCustom';
  static const  createPizza ='$baseUrl/pizzaCustom/create';

}
