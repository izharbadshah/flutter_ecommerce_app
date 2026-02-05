
import 'package:e_comm_app/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors.dart';
import '../controllers/cart_controller.dart';
import '/core/common/empty_state_widget.dart';
import '/presentations/cart/widgets/widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          Obx(() => controller.items.isNotEmpty
              ? TextButton(
            onPressed: controller.clearCart,
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: secondaryAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const EmptyStateWidget(
            icon: Icons.shopping_cart_outlined,
            title: 'Your Cart is Empty',
            subtitle: 'Start shopping to add items!',
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return CartItemCard(
                    item: item,
                    controller: controller,
                  );
                },
              ),
            ),
            CartSummarySection(
              controller: controller,
              isDark: isDark,
            ),
          ],
        );
      }),
    );
  }
}
