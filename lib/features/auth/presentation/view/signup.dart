import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/custom_text_filed.dart';
import 'package:meal_app/features/auth/presentation/widget/other_login_method.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/app_routes.dart';
import '../widget/authCustom.dart'; // adjust path

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
  final supabase = Supabase.instance.client;
  bool showed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlueColor,
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 10, right: 10),
          child: SingleChildScrollView(
            child: BlocBuilder<AuhtCubit, AuhtState>(
              builder: (context, state) {
                if (state is AuhtLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AuhtFailuer) {
                  return Center(
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(height: 55),
                    CustomTextFiled(
                      obscureText: false,
                      controller: nameController,
                      hintText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outlined),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled(
                      obscureText: false,
                      controller: emailController,
                      hintText: 'Email Address',
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled(
                      obscureText: false,
                      controller: phoneController,
                      hintText: 'Phone',
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    const SizedBox(height: 15),
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
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 25),
                    AuthButton(
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
                      onFacebookTap: () {},
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
