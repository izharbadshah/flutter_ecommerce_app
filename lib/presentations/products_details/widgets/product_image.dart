import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProductImage extends StatelessWidget {
  final product;
  final bool isDark;

  const ProductImage({
    required this.product,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: isDark ? surfaceDark : Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: isDark ? cardDark : const Color(0xFFF0F0F0),
          child: CachedNetworkImage(
            imageUrl: product.image,
            fit: BoxFit.contain,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(color: primaryAccent),
            ),
            errorWidget: (_, __, ___) =>
            const Icon(Icons.broken_image_outlined, size: 64),
          ),
        ),
      ),
    );
  }
}