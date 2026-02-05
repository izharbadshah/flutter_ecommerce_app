import 'package:e_comm_app/presentations/cart/widgets/quantity_control.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';
import '../controllers/cart_controller.dart';

class CartItemActions extends StatelessWidget {
  final dynamic item;
  final CartController controller;

  const CartItemActions({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: secondaryAccent,
            iconSize: 22,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
            onPressed: () => _handleDelete(context),
          ),
        ),
        const SizedBox(height: 8),
        QuantityControl(
          quantity: item.quantity,
          onDecrease: () => controller.decreaseQuantity(item.product.id),
          onIncrease: () => controller.increaseQuantity(item.product.id),
        ),
      ],
    );
  }

  void _handleDelete(BuildContext context) {
    final productTitle = item.product.title;
    final productId = item.product.id;
    final quantity = item.quantity;
    controller.removeItem(productId);
    SnackBarUtil.showSuccess(
      context: context,
      title: 'Item Removed',
      message: productTitle.length > 30
          ? '${productTitle.substring(0, 27)}...'
          : productTitle,
      onUndo: () {
        // Restore item
        controller.addItemWithQuantity(item.product, quantity);
      },
    );
  }
}