import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import '../Provider/cart_model.dart';
import '../models/medicine.dart';
import 'package:provider/provider.dart';

class MedicineDetailsScreen extends StatefulWidget {
  MedicineDetailsScreen({
    required this.medicine,
    required this.onToggleFavorite,
    super.key,
  });

  final Medicine medicine;
  final void Function(Medicine medicine) onToggleFavorite;

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.medicine.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine.scientificName),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                print(widget.medicine.isFavorite);
                isFavorite = !isFavorite;
                widget.medicine.isFavorite = isFavorite;
                print(widget.medicine.isFavorite);
                if (isFavorite == true) {
                  print('hello');
                  if (!favoritList.contains(widget.medicine)) {
                    favoritList.add(widget.medicine);
                    print('Add it');
                  } else {
                    print('Already exsist');
                  }
                } else {
                  favoritList.remove(widget.medicine);
                }
              });
            },
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
            ),
            tooltip: 'Add to favorites',
          ),
        ], // This bracket was misplaced
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'medicine-img-${widget.medicine}',
              child: Image.asset(
                widget.medicine.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.medicine.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Price: ${widget.medicine.price}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Provider.of<CartModel>(context, listen: false).add(widget.medicine);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Medicine added to cart'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan.shade800,
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
