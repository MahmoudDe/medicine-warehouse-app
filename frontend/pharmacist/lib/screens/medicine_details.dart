import 'package:flutter/material.dart';
import '../models/Medicine.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final Medicine medicine;
  MedicineDetailsScreen({required this.medicine, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.scientificName),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement favorite functionality
            },
            icon: const Icon(Icons.star_border),
            tooltip: 'Add to favorites',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'medicine-img-${medicine}',
              child: Image.network(
                medicine.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medicine.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Price: ${medicine.price}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement buy functionality
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
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
