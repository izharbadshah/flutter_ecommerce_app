import 'package:e_comm_app/data/models/product.dart';


class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
  String get formattedTotal => '\$${totalPrice.toStringAsFixed(2)}';
}
