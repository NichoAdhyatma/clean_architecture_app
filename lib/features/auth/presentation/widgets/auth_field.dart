import 'package:blog_app_clean_tdd/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.obscureText,
    this.validator,
  });

  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: widget.obscureText != null
          ? AppTheme.obscureInputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            )
          : AppTheme.defaultInputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
            ),
      validator: widget.validator ??
          (String? value) {
            if (value!.isEmpty) return "${widget.labelText} is missing";
            return null;
          },
      obscureText: widget.obscureText != null && !isObscure,
    );
  }
}
