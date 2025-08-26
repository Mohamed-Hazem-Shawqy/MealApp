import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/other_login_method.dart';

import '../../../../core/utils/app_routes.dart';
import '../../../home/presentation/view/widget/customTextForm.dart';
import '../widget/authCustom.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool showed = true;

  @override
  void initState() {
    super.initState();
    context.read<AuhtCubit>().repoImpl.configDeepLink(context);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
                    SnackBar(content: Text('Registered successfully')),
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
                      controller: nameController,
                      hintText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiledLight(
                      obscureText: false,
                      controller: emailController,
                      hintText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined),
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
                      obscureText: false,
                      controller: phoneController,
                      hintText: 'Phone',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiledLight(
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => showed = !showed),
                        icon: Icon(
                          showed ? Icons.visibility_off : Icons.visibility,
                          color: appWhiteColor,
                        ),
                      ),
                      obscureText: showed,
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
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
                            text: 'Register',
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                await context.read<AuhtCubit>().signUpWithEmail(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 10),
                    const CustomDivider(),
                    const SizedBox(height: 20),
                    OtherLoginMethod(
                      onGoogleTap: () {
                        context.read<AuhtCubit>().loginWithGoogle(context);
                      },
                      onFacebookTap: () {
                        context.read<AuhtCubit>().loginWithFacebook();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.kLogin);
                      },
                      child: const Text(
                        'Already have an account? Login now',
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
