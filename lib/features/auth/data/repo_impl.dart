import 'dart:developer';

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
        GoRouter.of(context).go(AppRoutes.kHome);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> userLoginWithFacebook() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> userLoginWithGoogle(context) async {
    //first way
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback',
      );
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        if (event == AuthChangeEvent.signedIn) {
          GoRouter.of(context).go(AppRoutes.kHome);
        }
      });
    } catch (e) {
      rethrow;
    }

    // second way to signin with google
    // try {
    //   const webClientId =
    //       '37159414142-6tpuepo6os67vnnj3avcu5stfbb3keqk.apps.googleusercontent.com';
    //   const iosClientId =
    //       '37159414142-0rcmamdqg4de0p3g9np17ui168p8en1l.apps.googleusercontent.com';
    //   final googleSignIn = GoogleSignIn.instance;
    //   await googleSignIn.initialize(
    //     clientId: iosClientId,
    //     serverClientId: webClientId,
    //   );

    //   final googleAcount = await googleSignIn.authenticate();
    //   final idToken = googleAcount.authentication.idToken;

    //   if (idToken == null) return;

    //   await supabase.auth.signInWithIdToken(
    //     provider: OAuthProvider.google,
    //     idToken: idToken,
    //   );
    // } catch (e) {
    //   rethrow;
    // }
  }
}
