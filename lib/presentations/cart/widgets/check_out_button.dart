

import 'package:flutter/material.dart';
import '../../../core/common/custom_button.dart';
import '../../../core/utils/utils.dart';
import '../controllers/cart_controller.dart';

class CheckoutButton extends StatelessWidget {
  final CartController controller;

  const CheckoutButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Checkout — ${controller.formattedTotal}',
      width: double.infinity,
      onPressed: () => _handleCheckout(context),
    );
  }

  void _handleCheckout(BuildContext context) {
   SnackBarUtil.showConfirmation(
      context: context,
      title: 'Confirm Order',
      message: 'Total: ${controller.formattedTotal}.',
      icon: Icons.shopping_bag_outlined,
      confirmText: 'Place Order',
      onConfirm: () {
        SnackBarUtil.showLoading(context: context, message: 'Processing...');
        Future.delayed(const Duration(seconds: 1), () {
          SnackBarUtil.hide();
          controller.clearCart();
          SnackBarUtil.showSuccess(
            context: context,
            title: 'Order Placed',
            message: 'Your order has been placed successfully! 🎉',
          );
        });
      },
    );
  }
}