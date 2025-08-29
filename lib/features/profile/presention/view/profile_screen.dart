import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/home/presentation/view/widget/customTextForm.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    nameController.text = user?.userMetadata?['full_name'] ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.userMetadata?['phone'] ?? '';
    imageUrl = user?.userMetadata?["avatar_url"];
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }

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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null, 
                        backgroundColor: Colors.grey,
                        radius: width * 0.15,
                        child: (imageUrl.isEmpty)
                            ? Text(
                                nameController.text.isNotEmpty
                                    ? nameController.text[0]
                                          .toUpperCase() 
                                    : "",
                                style: TextStyle(
                                  fontSize: width * 0.1,
                                  color: Colors.white,
                                ),
                              )
                            : null,
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
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Save',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Supabase.instance.client.auth.updateUser(
                              UserAttributes(
                                email: emailController.text,
                                data: {
                                  'full_name': nameController.text,
                                  'phone': phoneController.text,
                                },
                              ),
                            );
                            if (passController.text.isNotEmpty) {
                              await Supabase.instance.client.auth.updateUser(
                                UserAttributes(password: passController.text),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Profile updated successfully'),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error updating profile: $e'),
                              ),
                            );
                          }
                        }
                      },
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
