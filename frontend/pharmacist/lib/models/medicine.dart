class Medicine {
  const Medicine({
    required this.imageUrl,
    required this.medicineName,
    required this.description,
    required this.price,
    required this.categories,
  });
  final String imageUrl;
  final String medicineName;
  final List<String> description;
  final int price;
  final List<String> categories;
}
