import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/custom_text_filed.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();
  bool showed = true;

  @override
  void dispose() {
    passwordController.dispose();
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
                    SnackBar(content: Text('Password changed successfully')),
                  );
                  GoRouter.of(context).go('/login');
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
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => showed = !showed),
                        icon: Icon(
                          showed ? Icons.visibility_off : Icons.visibility,
                          color: appWhiteColor,
                        ),
                      ),
                      obscureText: showed,
                      controller: passwordController,
                      hintText: 'New Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 25),
                    state is AuhtLoading
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            text: 'Change Password',
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await context.read<AuhtCubit>().changePassword(
                                  passwordController.text,
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
