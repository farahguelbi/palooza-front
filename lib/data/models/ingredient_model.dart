
import '../../domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  IngredientModel({
    required String id,
    required String name,
    required double price,
    required String image,
    // required IngredientLayer layer,
  }) : super(
          id: id,
          name: name,
          price: price,
          image: image,
          // layer: layer,
        );

  /// Méthode pour convertir un JSON en une instance de `IngredientModel`
  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['_id']??'',
      name: json['name'] ?? 'Unknown',
      image: json['image']??'',

      price: (json['price'] as num).toDouble(),
      // layer: IngredientLayerExtension.fromValue(json['layer']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      // 'layer': layer.value,
    };
  }
}