
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/utils/utils.dart';
import '../../cart/controllers/cart_controller.dart';

class AddToCartButton extends StatelessWidget {
  final product;
  const AddToCartButton({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: 'Add to Cart',
      icon: Icons.shopping_cart_checkout_rounded,
      onPressed: () {
        final cartController = Get.find<CartController>();
        cartController.addItem(product);
        SnackBarUtil.showSuccess(
          context: context,
          title: 'Added to Cart',
          message: product.title.length > 25
              ? '${product.title.substring(0, 22)}...'
              : product.title,
          // onUndo: () {cartController.removeItem(product.id);
        );
      },
    );
  }
}
