
import 'package:flutter/material.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
import 'package:front/presentation/screens/pizza_details_screen.dart';
import 'package:get/get.dart';

class PizzaItem extends StatefulWidget {
  final Pizza pizza;

  const PizzaItem({Key? key, required this.pizza}) : super(key: key);

  @override
  _PizzaItemState createState() => _PizzaItemState();
}

class _PizzaItemState extends State<PizzaItem> {
  late bool isInWishlist; 

  @override
  void initState() {
    super.initState();
    isInWishlist = false; 
    _checkWishlistStatus(); 
  }

void _checkWishlistStatus() {
  final WishlistController wishlistController = Get.find();
  final AuthenticationController authenticationController = Get.find();
  final String? currentUserId = authenticationController.currentUser?.id;

  if (currentUserId != null) {
    wishlistController.getWishlistByUserId(currentUserId).then((success) {
      if (success && wishlistController.userWishlist != null) {
        print("Wishlist récupérée: ${wishlistController.userWishlist!.pizzas}");

        setState(() {
          isInWishlist = wishlistController.userWishlist!.pizzas
              .map((pizza) => pizza.id.toString()) // Ensure comparison as String
              .contains(widget.pizza.id.toString()); // Convert to string before comparing
        });

        print("État de isInWishlist mis à jour: $isInWishlist");
      }
    }).catchError((error) {
      print("Erreur lors de la récupération de la wishlist: $error");
    });
  }
}
  void _toggleFavorite() async {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser?.id;

    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to manage your wishlist')),
      );
      return;
    }
      bool previousState  = !isInWishlist;
    setState(() {
      isInWishlist =
          !isInWishlist; 
    });

     bool success = false;
    if (isInWishlist) {
      print("Adding pizza ${widget.pizza.id} to wishlist...");
      success = await wishlistController.addPizzaToWishlist(
          currentUserId, widget.pizza.id);
      if (!success) {
        print("Add failed, might already be in wishlist?");
        _checkWishlistStatus(); 
      }
    } else {
      print("Removing pizza ${widget.pizza.id} from wishlist...");
      success = await wishlistController.removePizzaFromWishlist(
          currentUserId, widget.pizza.id);
    }

    if (!success) {
      setState(() {
        isInWishlist = previousState;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update wishlist')),
      );
    } else {
      print("Wishlist update successful: isInWishlist = $isInWishlist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PizzaDetailsScreen(pizza: widget.pizza)),
        ).then((_) {
          _checkWishlistStatus();
        });
      },
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: const Color(0xFFFD9D9D9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.network(
                    widget.pizza.image,
                    height: 100, // Reduced height
                    width: 100, // Reduce width as well for proportional scaling
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ), 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pizza.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.pizza.description,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.pizza.sizes.medium.toStringAsFixed(2)} \$',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}