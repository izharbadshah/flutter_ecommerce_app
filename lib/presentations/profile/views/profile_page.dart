
import 'package:e_comm_app/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/common/error_widget.dart' as custom;
import '/core/common/loading_widget.dart';
import '/core/local_storage/storage_service.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/utils.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final storageService = Get.find<StorageService>();
    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Obx(() => IconButton(
            icon: Icon(storageService.isDarkMode.value
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded),
            onPressed: storageService.toggleDarkMode,
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();

        if (controller.errorMessage.value.isNotEmpty) {
          return custom.ErrorWidget(
            message: controller.errorMessage.value,
            onRetry: controller.fetchProfile,
          );
        }

        final user = controller.user.value;
        if (user == null) return const LoadingWidget();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Avatar
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4AA), Color(0xFF00B894)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryAccent.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    user.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                '@${user.username}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              _InfoCard(
                  icon: Icons.email_outlined, title: 'Email', value: user.email),
              const SizedBox(height: 12),
              _InfoCard(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: user.phone.isNotEmpty ? user.phone : 'Not available',
              ),
              const SizedBox(height: 12),
              _InfoCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                value: user.address.formatted,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => _showLogoutDialog(context, controller),
                  icon: const Icon(Icons.logout_rounded, color: secondaryAccent),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: secondaryAccent,
                    side: const BorderSide(color: secondaryAccent, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileController controller) {
    SnackBarUtil.showConfirmation(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      icon: Icons.logout_rounded,
      confirmText: 'Logout',
      isDangerous: true,
      onConfirm: () {
        controller.logout();
        SnackBarUtil.showSuccess(
          context: context,
          message: 'Logged out successfully',
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.roundedDecorationWithShadow,
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration:
          BoxDecoration(
            color: primaryAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryAccent),
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}