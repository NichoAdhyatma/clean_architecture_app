import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const SignInPage());

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign In.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 30.0),
                  AuthField(
                    controller: emailController,
                    hintText: "Insert email here",
                    labelText: "Email",
                  ),
                  const SizedBox(height: 15.0),
                  AuthField(
                    controller: passwordController,
                    hintText: "Insert password here",
                    labelText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  const AuthGradientButton(label: "Sign In"),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(SignUpPage.route()),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account ? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
