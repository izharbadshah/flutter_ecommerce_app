import 'package:get/get.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/product.dart';



class CartController extends GetxController {
  final items = <CartItem>[].obs;

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08;
  double get total => subtotal + tax;

  String get formattedSubtotal => '\$${subtotal.toStringAsFixed(2)}';
  String get formattedTax => '\$${tax.toStringAsFixed(2)}';
  String get formattedTotal => '\$${total.toStringAsFixed(2)}';

  int get itemCount => items.length;

  void addItem(Product product) {
    final existingIndex = items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      items[existingIndex] = items[existingIndex].copyWith(
        quantity: items[existingIndex].quantity + 1,
      );
    } else {
      items.add(CartItem(product: product));
    }
  }

  void addItemWithQuantity(Product product, int quantity) {
    final existingIndex = items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      items[existingIndex] = CartItem(
        product: product,
        quantity: quantity,
      );
    } else {
      items.add(CartItem(
        product: product,
        quantity: quantity,
      ));
    }
  }

  void removeItem(int productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  void increaseQuantity(int productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
  }

  void decreaseQuantity(int productId) {
    final index = items.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    if (items[index].quantity <= 1) {
      removeItem(productId);
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
    }
  }

  void clearCart() {
    items.clear();
  }
}
