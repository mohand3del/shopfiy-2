
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 16),
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
             obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black54,
              size: 22,
            ),
            onPressed: (){
              setState(() {
                obscureText = !obscureText;
              });
            }
          )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}













// class AuthTextField extends StatefulWidget {
//   final String label;
//   final String hint;
//   final TextEditingController controller;
//   final bool isPassword;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final IconData? prefixIcon;
//
//   const AuthTextField({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     this.prefixIcon,
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//   });

//   @override
//   State<AuthTextField> createState() => _AuthTextFieldState();
// }
//
// class _AuthTextFieldState extends State<AuthTextField> {
//   bool _obscure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       keyboardType: widget.keyboardType,
//       obscureText: widget.isPassword ? _obscure : false,
//       validator: widget.validator,
//       decoration: InputDecoration(
//         labelText: widget.label,
//         hintText: widget.hint,
//         prefixIcon: Icon(widget.prefixIcon),
//         suffixIcon: widget.isPassword
//             ? IconButton(
//           icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
//           onPressed: () => setState(() => _obscure = !_obscure),
//         )
//             : null,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.primary,
//             width: 2,
//           ),
//         ),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//       ),
//     );
//   }
// }