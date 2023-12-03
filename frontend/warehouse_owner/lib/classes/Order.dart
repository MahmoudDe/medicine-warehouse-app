class Order {
  final String medicineName;
  final int quantity;

  Order({
    required this.medicineName,
    required this.quantity,
  });
}
Order order = Order(medicineName: 'Medicine Name', quantity: 10);
