import '../../domain/entities/pizza.dart';
import '../../domain/entities/ingredient.dart';
import 'ingredient_model.dart';

class PizzaModel extends Pizza {
  const PizzaModel({
    required String id,
    required String name,
    required String image,
    required String reference,
    required String description,
    required double price,
    required String type,
    required  sizes,
  }) : super(
          id: id,
          name: name,
          image: image,
          reference: reference,
          description: description,
          price: price,
          type: type,
          sizes: sizes,
        );

  /// Méthode pour convertir un JSON en une instance de PizzaModel
  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      id: json['_id']??'',
      name: json['name']??'',
      image: json['image']??'',
      reference: json['reference']??'',
      description: json['description']??'',
      price: double.parse(json['price'].toString()),
      
       type: json['type'] ?? '',

      sizes: PizzaSizeModel.fromJson(json['size']));

    
  }


 }
class PizzaSizeModel extends PizzaSize {
  PizzaSizeModel({required super.small,required  super.medium,required  super.large});

  factory PizzaSizeModel.fromJson(Map<String, dynamic> json) =>
      PizzaSizeModel(
          small: double.parse( json["small"].toString()),
          medium:double.parse(  json["medium"].toString()),
          large: double.parse( json["large"].toString())
          );
}




