import 'package:flutter/material.dart';
import '../models/medicine.dart';
import 'package:provider/provider.dart';

class MedicineDetailsScreen extends StatelessWidget {
  MedicineDetailsScreen({
    required this.medicine,
    required this.onToggleFavorite,
    super.key,
  });

  final Medicine medicine;
  final void Function(Medicine medicine) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.scientificName),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(medicine);
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    medicine.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Price: ${medicine.price}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement buy functionality
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
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
