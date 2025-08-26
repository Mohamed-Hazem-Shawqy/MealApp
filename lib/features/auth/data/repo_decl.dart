import 'package:flutter/material.dart';

abstract class RepoDecl {
  Future<void> userLogin(String email, String password, context);
  Future<void> userLoginWithGoogle(context);
  Future<void> userLoginWithFacebook();
  Future<void> userResetPassword(String email);
  Future<void> userChangePassword(String password);
  configDeepLink(BuildContext context) {}
}
