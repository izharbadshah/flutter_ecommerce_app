
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/utils.dart';
import '../cart/controllers/cart_controller.dart';
import '../cart/views/cart_page.dart';
import '../products_list/view/product_list_page.dart';
import '../profile/views/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _selectedIndex = 0.obs;
  final cartController = Get.find<CartController>();

  final _pages = const [
    ProductListPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_selectedIndex.value != 0) {
          _selectedIndex.value = 0;
        } else {
          _showExitDialog(context);
        }
      },
      child: Obx(
            () => Scaffold(
          body: IndexedStack(
            index: _selectedIndex.value,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x15000000),
                  blurRadius: 12,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: NavigationBar(
              indicatorColor: primaryAccent.withAlpha(100),
              backgroundColor: isDark ? kBlack.withAlpha(100) : Colors.white,
              selectedIndex: _selectedIndex.value,
              onDestinationSelected: (index) =>
              _selectedIndex.value = index,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.store_outlined),
                  selectedIcon: Icon(Icons.store),
                  label: 'Products',
                ),
                NavigationDestination(
                  label: 'Cart',
                  icon: Obx(() {
                    final count = cartController.itemCount;
                    return Badge(
                      isLabelVisible: count > 0,
                      backgroundColor: Colors.redAccent,
                      label: Text(
                        count > 9 ? '9+' : count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child:
                      const Icon(Icons.shopping_cart_outlined),
                    );
                  }),
                  selectedIcon: Obx(() {
                    final count = cartController.itemCount;
                    return Badge(
                      isLabelVisible: count > 0,
                      backgroundColor: Colors.redAccent,
                      label: Text(
                        count > 9 ? '9+' : count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Icon(Icons.shopping_cart),
                    );
                  }),
                ),
                const NavigationDestination(
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    SnackBarUtil.showConfirmation(
      context: context,
      title: 'Exit App',
      message: 'Are you sure you want to close the app?',
      icon: Icons.exit_to_app_rounded,
      isDangerous: true,
      confirmText: 'Exit',
      onConfirm: () {
        SystemNavigator.pop();
      },
    );
  }
}
