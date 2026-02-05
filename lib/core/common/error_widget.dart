import 'package:e_comm_app/core/common/custom_button.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';


class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryAccent.withOpacity(0.1),
              ),
              child: const Icon(Icons.error_outline_rounded, color: secondaryAccent, size: 40),
            ),
            const SizedBox(height: 20),
            Text('Something Went Wrong', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              CustomButton(label: "Tray again", onPressed: onRetry!,icon:Icons.refresh_rounded)
            ],
          ],
        ),
      ),
    );
  }
}
