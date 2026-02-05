
import 'package:e_comm_app/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '/core/common/error_widget.dart' as custom;
import '/core/common/loading_widget.dart';
import '../controllers/product_detail_controller.dart';
import 'package:e_comm_app/presentations/products_details/widgets/widgets.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    final int productId = Get.arguments as int;
    controller.fetchProduct(productId);
    return Obx(() {
      if (controller.isLoading.value) {
        return const _LoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return _ErrorView(
          message: controller.errorMessage.value,
          onRetry: () => controller.fetchProduct(productId),
        );
      }
      final product = controller.product.value;
      if (product == null) return const _LoadingView();
      return _ProductScaffold(product: product);
    });
  }
}


class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const LoadingWidget(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: custom.ErrorWidget(
        message: message,
        onRetry: onRetry,
      ),
    );
  }
}

class _ProductScaffold extends StatelessWidget {
  final product;
  const _ProductScaffold({required this.product});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: context.bgColor,
      body: _ProductBody(product: product, isDark: isDark),
      bottomNavigationBar: BottomBar(product: product, isDark: isDark),
    );
  }
}

class _ProductBody extends StatelessWidget {
  final product;
  final bool isDark;
  const _ProductBody({
    required this.product,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          ProductImage(product: product, isDark: isDark),
          ProductInfo(product: product),
        ],
      ),
    );
  }
}
