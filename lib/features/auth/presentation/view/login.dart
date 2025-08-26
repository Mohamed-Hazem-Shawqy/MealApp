import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/authCustom.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/other_login_method.dart';

import '../../../../core/utils/app_routes.dart';
import '../../../home/presentation/view/widget/customTextForm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  bool showed = false;

  @override
  void initState() {
    super.initState();
    context.read<AuhtCubit>().repoImpl.configDeepLink(context);
  }

  @override
  void dispose() {
    emailController.dispose();
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
                if (state is AuhtSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged in successfully')),
                  );
                  GoRouter.of(context).go(AppRoutes.kNav);
                } else if (state is AuhtFailuer) {
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
                    CustomTextFiledLight(
                      obscureText: false,
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiledLight(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showed = !showed;
                          });
                        },
                        icon: showed
                            ? Icon(Icons.visibility_off, color: appWhiteColor)
                            : Icon(Icons.visibility, color: appWhiteColor),
                      ),
                      obscureText: showed,
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    state is AuhtLoading
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            text: 'Log In',
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await context.read<AuhtCubit>().loginwithEmail(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 10),
                    CustomDivider(),
                    const SizedBox(height: 20),
                    OtherLoginMethod(
                      onGoogleTap: () async {
                        await context.read<AuhtCubit>().loginWithGoogle(
                          context,
                        );
                      },
                      onFacebookTap: () async {
                        await context.read<AuhtCubit>().loginWithFacebook();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.kSignup);
                      },
                      child: Text(
                        'Don\'t have an account? Register now',
                        style: TextStyle(color: appWhiteColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.kResetPassword);
                      },
                      child: Text(
                        'Forgot Password?',
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
