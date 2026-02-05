

import 'package:e_comm_app/presentations/cart/widgets/product_image.dart';
import 'package:e_comm_app/presentations/cart/widgets/product_info.dart';
import 'package:flutter/material.dart';

import '../controllers/cart_controller.dart';
import 'cart_items_action.dart';

class CartItemCard extends StatelessWidget {
  final dynamic item;
  final CartController controller;

  const CartItemCard({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductImagee(imageUrl: item.product.image),
            const SizedBox(width: 14),
            Expanded(
              child: CartProductInfo(product: item.product),
            ),
            const SizedBox(width: 8),
            CartItemActions(
              item: item,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}