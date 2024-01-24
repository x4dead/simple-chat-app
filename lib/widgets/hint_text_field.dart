import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_chat_app/themes/colors/app_colors.dart';
import 'package:simple_chat_app/utils/extentions/figma_height.dart';

class HintTextField extends StatefulWidget {
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
  final Function(String)? onChanged;
  final bool? isDense;
  final BoxConstraints? constraints;
  final BoxConstraints? prefixConstraints;
  @override
  State<HintTextField> createState() => _HintTextFieldState();
}

class _HintTextFieldState extends State<HintTextField> {
  late List<TextInputFormatter> inputFormatters;
  @override
  void initState() {
    super.initState();

    inputFormatters = widget.inputFormatters == null
        ? <TextInputFormatter>[]
        : [FilteringTextInputFormatter.allow(widget.inputFormatters!)];
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 0, color: AppColors.colorStroke),
        gapPadding: 6);
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      inputFormatters: inputFormatters,
      obscureText: widget.obscureText ?? false,
      maxLength: widget.maxLength,
      controller: widget.controller,
      validator: widget.validator,
      style: widget.style ??
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 19.0.toFigmaHeight(16.0),
          ),
      decoration: InputDecoration(
        constraints: widget.constraints,
        prefixIconConstraints: widget.prefixConstraints,
        isDense: widget.isDense,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        counterText: '',
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.colorGray),
        filled: true,
        fillColor: AppColors.colorStroke,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefixIcon,
        enabledBorder: border,
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
