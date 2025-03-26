import 'package:flutter/material.dart';

class PizzaGridView extends StatelessWidget {
  final List<Map<String, dynamic>> pizzas;
  final void Function(int) onFavoriteToggle; 

  const PizzaGridView({
    Key? key,
    required this.pizzas,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color

      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.65, // Adjusted ratio for larger cards
        ),
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
          return Card(
            color: const Color(0xFFD9D9D9), // Light gray background for the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pizza Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                  child: Image.asset(
                    pizza['image'],
                    height: 150, // Adjusted height for larger image
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Pizza Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    pizza['name'],
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Pizza Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    pizza['description'],
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                // Price, Rating, and Heart Icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price and Rating
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pizza['price'],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4.0),
                              Text(
                                pizza['rating'].toString(),
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Favorite Icon
                      IconButton(
                        icon: Icon(
                          pizza['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: pizza['isFavorite'] ? Colors.red : Colors.black54,
                        ),
                        onPressed: () => onFavoriteToggle(index),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
