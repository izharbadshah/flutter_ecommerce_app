import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProductInfo extends StatelessWidget {
  final product;

  const ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Text(
            product.category.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: primaryAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF39C12), size: 18),
              const SizedBox(width: 4),
              Text(
                '${product.rating.rate} (${product.rating.count} reviews)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: primaryAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 100),
        ]),
      ),
    );
  }
}