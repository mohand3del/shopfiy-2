import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled,
    this.readOnly = false,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.autocorrect = true,
    this.borderColor,
    this.fillColor,
  });
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final bool? enabled;
  final bool readOnly;
  final String? initialValue;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final Color? borderColor;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: AppStyles.regular14(color: const Color(0xff000000)),
      controller: controller,
      cursorColor: AppColors.lightPrimary,
      obscureText: obscureText,
      autocorrect: autocorrect,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      enabled: enabled,
      readOnly: readOnly,

      inputFormatters: inputFormatters,
      decoration: createInputDecoration(context),
    );
  }

  InputDecoration createInputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: fillColor ?? AppColors.white,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),

      labelText: labelText,
      labelStyle: AppStyles.semiBold14(),
      hintText: hintText,

      hintStyle: AppStyles.regular12(
        color: Theme.of(context).colorScheme.primary,
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      errorStyle: AppStyles.regular12().copyWith(color: AppColors.error),
    );
  }

  _buildBorder({Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        // Radius.circular(14),
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        width: 1,
        color: borderColor ?? Colors.transparent,
      ),
    );
  }
}
