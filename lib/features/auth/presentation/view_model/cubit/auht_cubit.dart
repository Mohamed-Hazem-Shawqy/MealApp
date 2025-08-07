import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/auth/data/repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auht_state.dart';

class AuhtCubit extends Cubit<AuhtState> {
  AuhtCubit() : super(AuhtInitial());
  RepoImpl repoImpl = RepoImpl();
  final _supabase = Supabase.instance.client;
  Future loginWithGoogle(BuildContext context) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userLoginWithGoogle();
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        if (event == AuthChangeEvent.signedIn) {
          emit(AuhtSuccess());
          GoRouter.of(context).go(AppRoutes.kHome);
        }
      });
    } catch (e) {
      emit(AuhtFailuer(errMessage: e.toString()));
    }
  }

  Future<void> loginwithEmail(String email, String password) async {
    emit(AuhtLoading());
    try {
      repoImpl.userLogin(email, password);
      emit(AuhtSuccess());
    } catch (e) {
      emit(AuhtFailuer(errMessage: e.toString()));
    }
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(AuhtLoading());
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
          'phone': phone,
        },
      );
      if (response.user != null) {
        emit(AuhtSuccess());
      } else {
        emit(AuhtFailuer(errMessage: 'Signup failed.'));
      }
    } on AuthException catch (e) {
      emit(AuhtFailuer(errMessage: e.message));
    } catch (e) {
      emit(AuhtFailuer(errMessage: 'Something went wrong.'));
    }
  }
}

