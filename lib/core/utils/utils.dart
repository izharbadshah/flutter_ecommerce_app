
import 'package:e_comm_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/custom_button.dart';

class SnackBarUtil {
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? title,
    VoidCallback? onUndo,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildSnackBarContent(
          icon: Icons.check_circle,
          title: title,
          message: message,
        ),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: onUndo != null
            ? SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: onUndo,
        )
            : null,
      ),
    );
  }

  // static void showError({
  //   required BuildContext context,
  //   required String message,
  //   String? title,
  // }) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: _buildSnackBarContent(
  //         icon: Icons.error,
  //         title: title,
  //         message: message,
  //       ),
  //       backgroundColor: Colors.red.shade700,
  //       duration: const Duration(seconds: 3),
  //       behavior: SnackBarBehavior.floating,
  //       margin: const EdgeInsets.all(16),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     ),
  //   );
  // }

  static void showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    IconData? icon,
    bool isDangerous = false,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: isDangerous ? Colors.red : primaryAccent),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 15)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(cancelText, style: const TextStyle(fontSize: 15)),
          ),
          CustomButton(
            label: confirmText,
            height: 40,
            backgroundColor: isDangerous ? Colors.red : primaryAccent,
            onPressed: () {
              Get.back();
              onConfirm();
            },
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showLoading({
    required BuildContext context,
    String message = 'Please wait...',
  }) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: primaryAccent),
              const SizedBox(height: 20),
              Text(message, style: const TextStyle(fontSize: 15), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  static Widget _buildSnackBarContent({
    required IconData icon,
    String? title,
    required String message,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(message, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}