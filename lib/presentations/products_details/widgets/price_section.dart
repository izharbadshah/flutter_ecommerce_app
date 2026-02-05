import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PriceSection extends StatelessWidget {
  final String price;

  const PriceSection({required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Price', style: Theme.of(context).textTheme.bodySmall),
        Text(
          price,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: primaryAccent,
          ),
        ),
      ],
    );
  }
}