import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
  int _medicineIdCounter = 0;
  @override
  void initState() {
    isFavorite = widget.medicine.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.cyan.shade600,
        title: Text(widget.medicine.scientificName, style: TextStyle(color: Colors.white),),
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
              isFavorite ? Icons.star_rate_rounded : Iconsax.star,
            ),
            tooltip: 'Add to favorites',
          ),
        ], // This bracket was misplaced
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Hero(
                tag: 'medicine-img-${widget.medicine}',
                child: Image.asset(
                  widget.medicine.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(7.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(width: 4, color: Colors.red)
                ),
                elevation: 0.0,
                color: Colors.deepOrangeAccent.shade100.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Center(
                          child: Text(
                            tr("Medicine Details"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Tajawal',
                                color: Colors.red

                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Trade Name : ${widget.medicine.tradeName}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade700,
                            fontFamily: 'Tajawal',

                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Category : ${widget.medicine.category}',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 22,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Medicine Scientific Name: ${widget.medicine.scientificName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 22,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Manufacturer: ${widget.medicine.manufacturer}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 22,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Expiry Date : ${widget.medicine.expiryDate}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 22,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Available Quantity: ${widget.medicine.maxQuantity}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 22,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Price: ${widget.medicine.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.green.shade700,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            )

          ]
        ),


      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton.icon(
          onPressed: () {
            bool wasAdded = Provider.of<CartModel>(context, listen: false).add(widget.medicine, context);
            if (wasAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Medicine added to cart'),
                ),
              );
            }
          },
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Buy Now'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan.shade600,
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
    );
  }
}
