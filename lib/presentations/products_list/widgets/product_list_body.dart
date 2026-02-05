import 'package:e_comm_app/core/theme/app_colors.dart';
import 'package:e_comm_app/presentations/products_list/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import '/core/common/empty_state_widget.dart';
import '../../../core/common/error_widget.dart' as custom;
import '../../../core/common/loading_widget.dart';
import '../../../core/common/product_card.dart';
import '../../../core/routes/app_routes.dart';
import '../controller/product_controller.dart';

class ProductListBody extends StatelessWidget {
  final ProductController controller;
  const ProductListBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: SearchField(controller: controller),
        ),

        Obx(() {
          if (controller.categories.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Obx(
                          () => CategoryChip(
                        label: 'All',
                        isSelected: controller.selectedCategory.value == null,
                        onTap: () => controller.filterByCategory(null),
                      ),
                    );
                  }

                  final category = controller.categories[index - 1];
                  return Obx(
                        () => CategoryChip(
                      label: category.capitalize!,
                      isSelected: controller.selectedCategory.value == category,
                      onTap: () => controller.filterByCategory(category),
                    ),
                  );
                },
              ),
            ),
          );
        }),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingWidget();
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: custom.ErrorWidget(
                    message: controller.errorMessage.value,
                    onRetry: controller.fetchProducts,
                  ),
                ),
              );
            }
            if (controller.filteredProducts.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    EmptyStateWidget(
                      icon: Icons.search_off_rounded,
                      title: 'No Products Found',
                      subtitle: 'Try adjusting your search or filter.',
                      actionLabel: 'Clear Filter',
                      onAction: () {
                        controller.filterByCategory(null);
                        controller.searchProducts('');
                      },
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: controller.refreshProducts,
              color: primaryAccent,
              backgroundColor: kWhite,
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];

                  return ProductCard(
                    product: product,
                    onTap: () => Get.toNamed(
                      AppRoutes.productDetail,
                      arguments: product.id,
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}


class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
  final  isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryAccent
              : isDark ? kBlack.withAlpha(100) : kWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? kWhite : kWhite)
        ),
        child: Center(
          child: Text(label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}