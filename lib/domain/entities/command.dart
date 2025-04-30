

import 'package:equatable/equatable.dart';
import 'cart.dart';
import 'user.dart';
class Command extends Equatable {
  final String id; 
  final String user; 
  final String address;
  final List<String> saleIds;
  final String orderStatus; 
  final String paymentStatus; 
  final String paymentMethod; 
  final double totalPrice; 

  const Command({
    required this.id,
    required this.user,
    required this.address,
    required this.saleIds,
    required this.orderStatus,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        address,
        saleIds,
        orderStatus,
        paymentStatus,
        paymentMethod,
        totalPrice,
      ];
}
