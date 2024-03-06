import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';

class HintTextField extends StatelessWidget {
  const HintTextField({
    Key? key,
    required this.hintText,
    this.maxLength,
    this.suffix,
    this.obscureText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.hintStyle,
    this.contentPadding,
    this.style,
    this.onFieldSubmitted,
    this.onChanged,
    this.isDense,
    this.constraints,
    this.prefixConstraints,
    this.focusNode,
    this.onEditingComplete,
    this.enabled,
  }) : super(key: key);
  final String hintText;
  final int? maxLength;
  final Widget? suffix;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final RegExp? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final bool? isDense;
  final BoxConstraints? constraints;
  final FocusNode? focusNode;
  final BoxConstraints? prefixConstraints;
  final bool? enabled;
  // @override
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatter = inputFormatters == null
        ? []
        : [FilteringTextInputFormatter.allow(inputFormatters!)];
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0, color: AppColors.colorStroke),
        gapPadding: 6);
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatter,
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      controller: controller,
      validator: validator,
      style: style ??
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 19.0.toFigmaHeight(16.0),
          ),
      decoration: InputDecoration(
        constraints: constraints,
        prefixIconConstraints: prefixConstraints,
        isDense: isDense,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        counterText: '',
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.colorGray),
        filled: true,
        fillColor: AppColors.colorStroke,
        suffixIcon: suffix,
        prefixIcon: prefixIcon,
        enabledBorder: border,
        disabledBorder: border,
        border: border,
        focusedBorder: border,
        errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error.withOpacity(0.8)),
        errorBorder: border,
        focusedErrorBorder: border,
      ),
    );
  }
}
