import 'package:flutter/material.dart';

import '../classes/Medicine.dart';
class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detailed page
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100, // Specify a fixed width
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // More circular border
            ),
            child: SingleChildScrollView(
              // Add this
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align text to the left
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      // Slightly rounded image border
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'assets/images/Profile.jpg', // Replace with your image
                        width: 300, // Larger image
                        height: 150, // Larger image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    // Reduced vertical padding
                    child: Text(
                      medicine.commercialName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan, // Change color to cyan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    // Reduced vertical padding
                    child: Text(
                      medicine.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    // Reduced vertical padding
                    child: Text(
                      'Manufacturer: ${medicine.manufacturer}', // Display manufacturer
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black, // Change color to black
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        // Reduced vertical padding
                        child: Text(
                          'Quantity: ${medicine.quantity}', // Display quantity
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black, // Change color to black
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '\$${medicine.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green, // Keep price color as green
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
