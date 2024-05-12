import 'package:blog_app_clean_tdd/core/common/widgets/loader.dart';
import 'package:blog_app_clean_tdd/core/utils/show_snackbar.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/widgets/auth_custom_rich_text.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackbar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }

                return Form(
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
                      AuthGradientButton(
                        label: "Sign In",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      AuthCustomRichText(
                        onPressed: () => Navigator.of(context).push(
                          SignUpPage.route(),
                        ),
                        firstText: 'Don\'t have an account? ',
                        secondText: 'Sign Up',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
