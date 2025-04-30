import 'package:front/data/models/ingredient_model.dart';
import 'package:front/domain/entities/pizzaCustom.dart';

class PizzacustomModel extends PizzaCustom {
   PizzacustomModel({
    required String id,
    required String name,
    required double price,
    required String size,
    required List<Map<String,dynamic>> ingredients,
        required String image,

  }) : super(
          id: id,
          name: name,
          price: price,
          ingredients: ingredients,
          size: size,
          image: image,

        );
 factory PizzacustomModel.fromJson(Map<String, dynamic> json) {
    return PizzacustomModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: double.parse(json['price'].toString()),
    size: json['size'] ?? 'medium', // Adjust based on your model
      ingredients: (json['ingredients'] as List)
          .map((ingredientJson) => ingredientJson as Map<String, dynamic>)
          .toList(),
            image: json['image']??'',
    );
  }



  // Method to convert PizzacustomModel instance into JSON
  Map<String, dynamic> toJson() {
    return {
     
      'name': name,
      'price': price,
      'size': size,
      'ingredients':ingredients,
      
    };
  }
}

class PizzaSizeModel extends PizzaSize {
  PizzaSizeModel({
    required double small,
    required double medium,
    required double large,
  }) : super(small: small, medium: medium, large: large);

  factory PizzaSizeModel.fromJson(Map<String, dynamic> json) {
    return PizzaSizeModel(
      small: double.parse(json['small']['price'].toString()),
      medium: double.parse(json['medium']['price'].toString()),
      large: double.parse(json['large']['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'small': {'price': small},
      'medium': {'price': medium},
      'large': {'price': large},
    };
  }
}
