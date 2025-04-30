import 'package:equatable/equatable.dart';
import 'ingredient.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final String image; 
  final String reference;
  final String description; 
  final double price; 

  final String type;
  final PizzaSize sizes;

  const Pizza({
    required this.id,
    required this.name,
    required this.image,
    required this.reference,
    required this.description,
    required this.price,
 
    required this.type,
    required this.sizes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        reference,
        description,
        price,
        type,
        sizes,
      ];
}
class PizzaSize {
  final double small;
  final double medium;
  final double large;
  PizzaSize({required this.small, required this.medium, required this.large});
}










