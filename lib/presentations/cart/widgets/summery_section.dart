import 'package:e_comm_app/presentations/cart/widgets/summery_row.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/cart_controller.dart';
import 'check_out_button.dart';

class CartSummarySection extends StatelessWidget {
  final CartController controller;
  final bool isDark;

  const CartSummarySection({
    super.key,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ?kBlack.withAlpha(100) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          SummaryRow(label: 'Subtotal', value: controller.formattedSubtotal),
          SummaryRow(label: 'Tax (8%)', value: controller.formattedTax),
          const Divider(height: 24, thickness: 1),
          SummaryRow(
            label: 'Total',
            value: controller.formattedTotal,
            isBold: true,
          ),
          const SizedBox(height: 20),
          CheckoutButton(controller: controller),
        ],
      ),
    );
  }
}