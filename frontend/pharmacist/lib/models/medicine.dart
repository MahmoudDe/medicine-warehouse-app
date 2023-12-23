// ignore_for_file: file_names

class Medicine {
  int quantity;
  final double price;
  bool isFavorite;
  final String scientificName;
  final String tradeName;
  final String classification;
  final String manufacturer;
  final String image;
  final String expiryDate;
  final String description;
  Medicine(
      this.isFavorite,
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
