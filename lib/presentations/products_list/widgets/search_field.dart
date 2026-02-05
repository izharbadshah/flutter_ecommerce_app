import 'package:e_comm_app/core/common/input_text_field.dart';
import 'package:e_comm_app/extension/decoration_extension.dart';
import 'package:e_comm_app/presentations/products_list/controller/product_controller.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ProductController controller;
  const SearchField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.roundedDecorationWithShadow,
      child: CustomTextFormField(hintText: "Search products...",
        prefixIcon:  Icon(Icons.search_rounded),
        onChanged: controller.searchProducts,
      ),
    );
  }
}
