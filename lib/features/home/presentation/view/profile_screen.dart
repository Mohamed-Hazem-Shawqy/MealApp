import 'package:flutter/material.dart';
import 'package:meal_app/features/home/presentation/view/widget/customTextForm.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_button.dart';

import '../../../../core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: appWhiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.08,
              vertical: height * 0.05,
            ),
            child: Form(
              key: _formKey, // 👈 wrap with Form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar with Edit Icon
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: width * 0.15,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: width * 0.05,
                          backgroundColor: appBlueColor,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: width * 0.06,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.04),

                  // Input fields with validation
                  CustomTextFiledLight(
                    controller: nameController,
                    hintText: "User Name",
                    obscureText: false,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomTextFiledLight(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomTextFiledLight(
                    controller: phoneController,
                    hintText: "Phone",
                    obscureText: false,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomTextFiledLight(
                    controller: passController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.04),

                  // Save Button with validation check
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(text: 'Save', onPressed: () {}),
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
