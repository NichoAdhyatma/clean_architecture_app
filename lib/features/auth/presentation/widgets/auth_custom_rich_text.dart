import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../pages/sign_in_page.dart';

class AuthCustomRichText extends StatelessWidget {
  const AuthCustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(SignInPage.route()),
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