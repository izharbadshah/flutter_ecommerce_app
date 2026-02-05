
import 'package:e_comm_app/presentations/products_details/widgets/price_section.dart';
import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import 'add_to_cart_button.dart';

class BottomBar extends StatelessWidget {
  final product;
  final bool isDark;
  const BottomBar({super.key,
    required this.product,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? kBlack.withAlpha(100) : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x15000000),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            PriceSection(price: product.formattedPrice),
            const SizedBox(width: 16),
            Expanded(child: AddToCartButton(product: product)),
          ],
        ),
      ),
    );
  }
}