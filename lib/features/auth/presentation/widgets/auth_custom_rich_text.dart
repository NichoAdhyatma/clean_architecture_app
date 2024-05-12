import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthCustomRichText extends StatelessWidget {
  const AuthCustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onPressed,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: secondText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPallete.gradient2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
