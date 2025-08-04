import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/widget/auth_button.dart';
import 'package:meal_app/features/auth/presentation/widget/custom_text_filed.dart';
import 'package:meal_app/features/auth/presentation/widget/other_login_method.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  bool showed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlueColor,
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 55),
                CustomTextFiled(
                  obscureText: false,
                  controller: userNameController,
                  hintText: 'user name',
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
                AuthButton(
                  text: 'LogIn',
                  onPressed: () {
                    if (key.currentState!.validate()) {}
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
                OtherLoginMethod(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'donot have an account ? register now',
                    style: TextStyle(color: appWhiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
