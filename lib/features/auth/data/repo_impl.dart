import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/auth/data/repo_decl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RepoImpl implements RepoDecl {
  final supabase = Supabase.instance.client;

  @override
  Future<void> userLogin(String email, String password, context) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.session != null) {
        log('Login successful, session created');
        GoRouter.of(context).go(AppRoutes.kNav);
      } else {
        throw AuthException('Login failed: Invalid credentials');
      }
    } on AuthException catch (e) {
      log('Login error: ${e.message}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred during login');
    }
  }

  @override
  Future<void> userLoginWithFacebook() async {
    try {
      final response = await supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
      if (!response) {
        throw AuthException('Facebook login failed: No response');
      }
      log('Facebook login initiated');
    } on AuthException catch (e) {
      log('Facebook login error: ${e.message}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred during Facebook login');
    }
  }

  @override
  Future<void> userLoginWithGoogle(context) async {
    try {
      final response = await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
      if (!response) {
        throw AuthException('Google login failed: No response');
      }
      log('Google login initiated');
      supabase.auth.onAuthStateChange.listen((data) {
        if (data.event == AuthChangeEvent.signedIn) {
          log('Google login successful, session created');
          GoRouter.of(context).go(AppRoutes.kNav);
        }
      });
    } on AuthException catch (e) {
      log('Google login error: ${e.message}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred during Google login');
    }
  }

  @override
  Future<void> userResetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutter://change-password',
      );
      log('Password reset email sent');
    } on AuthException catch (e) {
      log('Reset password error: ${e.message}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred during password reset');
    }
  }

  @override
  Future<void> userChangePassword(String password) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: password));
      log('Password changed successfully');
    } on AuthException catch (e) {
      log('Change password error: ${e.message}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred during password change');
    }
  }

  @override
  configDeepLink(BuildContext context) async {
    final appLinks = AppLinks();
    final deepLink = appLinks.uriLinkStream.listen((uri) {
      log('Deep link received: $uri');
      if (uri.host == 'change-password') {
        GoRouter.of(context).go(AppRoutes.kChangePassword);
      } else if (uri.host == 'login-callback') {
        GoRouter.of(context).go(AppRoutes.kNav);
      }
    });
    log('Deep link configured');
  }
}
