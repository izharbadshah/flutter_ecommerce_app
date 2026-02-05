import 'package:e_comm_app/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../widgets/product_list_body.dart';
import '/core/local_storage/storage_service.dart';
import '/core/theme/app_colors.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final storageService = Get.find<StorageService>();
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: const Text('ShopZone'),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              storageService.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: storageService.toggleDarkMode,
          )),
          Obx(() => Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
              if (cartController.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: secondaryAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cartController.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          )),
          const SizedBox(width: 4),
        ],
      ),
      body:  ProductListBody(controller: controller),
    );
  }
}
