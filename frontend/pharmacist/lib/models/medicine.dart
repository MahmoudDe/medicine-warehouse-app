// ignore_for_file: file_names

class Medicine {
  final int quantity;
  final double price;
  final String scientificName,
      tradeName,
      classification,
      manufacturer,
      image,
      expiryDate,
      description;

  Medicine(
      this.price,
      this.quantity,
      this.scientificName,
      this.tradeName,
      this.classification,
      this.manufacturer,
      this.expiryDate,
      this.description,
      this.image,
      {required String medicineName});
}
