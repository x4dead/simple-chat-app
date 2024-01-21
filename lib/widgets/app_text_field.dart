import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
// import '../../../../themes/colors/colors.dart';
// import '../../../../themes/text_style/text_style.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.text,
    this.maxLength = 16,
    this.suffix,
    this.obscureText,
    this.icon,
    this.controller,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);
  final String text;
  final int? maxLength;
  final Widget? suffix;
  final bool? obscureText;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final RegExp? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(inputFormatters ?? ''),
      ],
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      controller: controller,
      validator: validator,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
          // color: AppColors.color000000.withOpacity(0.85)
          ),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.zero,
        counterText: '',
        hintText: text,
        hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.colorGray),
        filled: true,
        fillColor: AppColors.colorStroke,
        suffixIcon: suffix,
        prefixIcon: Icon(
          icon,
          color: AppColors.colorGray,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error.withOpacity(0.8)),
        errorBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5)),
        ),
      ),
    );
  }
}
