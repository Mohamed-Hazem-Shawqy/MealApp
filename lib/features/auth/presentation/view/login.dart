import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/data/repo_impl.dart';
import 'package:meal_app/features/auth/presentation/view_model/cubit/auht_cubit.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/custom_text_filed.dart';
import 'package:meal_app/features/auth/presentation/widget/other_login_method.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  final supabase = Supabase.instance.client;
  bool showed = false;
  RepoImpl repoImpl = RepoImpl();
  Future<void> signup() async {
    await supabase.auth.signUp(
      email: 'hazm05771@gmail.com',
      password: '123456',
    );
  }

  @override
  void initState() {
    signup();

    super.initState();
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
                if (state is AuhtFailuer) {
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
                      hintText: 'email',
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled(
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
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 25),
                    state is AuhtLoading
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            text: 'LogIn',
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                context.read<AuhtCubit>().loginwithEmail(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: appWhiteColor,
                            thickness: 1,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          "or login with",
                          style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: appWhiteColor,
                            thickness: 1,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OtherLoginMethod(
                      onGoogleTap: () async {
                        context.read<AuhtCubit>().loginWithGoogle(context);
                      },
                      onFacebookTap: () async {},
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'donot have an account ? register now',
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
