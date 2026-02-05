
import 'package:flutter/material.dart';

import '../../../core/common/input_text_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../extension/decoration_extension.dart';

class ValidatedField extends StatelessWidget {
  final String hintText;
  final int MaxLine;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData? icon;
  final String label;
  final bool obscureText;
  final VoidCallback? onToggleObscure;

  const ValidatedField({
    super.key,
    required this.hintText,
    required this.controller,
    this.MaxLine = 1,
    required this.validator,
    required this.icon,
    required this.label,
    this.obscureText = false,
    this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (val) {
        final value = controller.text.trim();
        if (value.isEmpty) return "Please enter $label";
        return validator(val);
      },
      builder: (field) {
        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: context.roundedDecorationWithShadow.copyWith(
                borderRadius: BorderRadius.circular(12),
                border: hasError
                    ? Border.all(color: Colors.red.shade400)
                    : Border.all(color: kWhite),
              ),
              child: CustomTextFormField(
                MaxLine: MaxLine,
                controller: controller,
                obscureText: obscureText,
                onChanged: (val) => field.didChange(val),
                prefixIcon: icon != null ? Icon(icon) : null,

                suffixIcon: onToggleObscure != null
                    ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: onToggleObscure,
                )
                    : null,

                border: InputBorder.none,
                hintText: hintText,
                hintStyle:
                const TextStyle(color: Colors.grey, fontSize: 15),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 14,
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(
                  field.errorText ?? '',
                  style:
                  const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
