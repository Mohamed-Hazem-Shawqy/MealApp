import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/custom_text_filed.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlueColor,
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 10, right: 10),
          child: SingleChildScrollView(
            child: BlocConsumer<AuhtCubit, AuhtState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password reset email sent')),
                  );
                  GoRouter.of(context).go('/change-password');
                } else if (state is ResetPasswordFailuer) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(height: 55),
                    CustomTextFiled(
                      obscureText: false,
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 25),
                    state is AuhtLoading
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            text: 'Reset Password',
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await context.read<AuhtCubit>().resetPassword(
                                  emailController.text,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/login');
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(color: appWhiteColor),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
