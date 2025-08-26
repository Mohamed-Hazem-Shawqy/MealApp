import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/auth/data/repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auht_state.dart';

class AuhtCubit extends Cubit<AuhtState> {
  AuhtCubit() : super(AuhtInitial());
  final RepoImpl repoImpl = RepoImpl();
  final _supabase = Supabase.instance.client;

  Future loginWithGoogle(BuildContext context) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userLoginWithGoogle(context);
      if (_supabase.auth.currentSession != null) {
        emit(AuhtSuccess());
      } else {
        emit(
          AuhtFailuer(errMessage: 'Google login failed: No session created'),
        );
      }
    } catch (e) {
      emit(AuhtFailuer(errMessage: 'Google login error: $e'));
    }
  }

  Future loginWithFacebook() async {
    emit(AuhtLoading());
    try {
      await repoImpl.userLoginWithFacebook();
      if (_supabase.auth.currentSession != null) {
        emit(AuhtSuccess());
      } else {
        emit(
          AuhtFailuer(errMessage: 'Facebook login failed: No session created'),
        );
      }
    } catch (e) {
      emit(AuhtFailuer(errMessage: 'Facebook login error: $e'));
    }
  }

  Future<void> loginwithEmail(String email, String password, context) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userLogin(email, password, context);
      if (_supabase.auth.currentSession != null) {
        emit(AuhtSuccess());
      } else {
        emit(AuhtFailuer(errMessage: 'Email login failed: No session created'));
      }
    } catch (e) {
      emit(AuhtFailuer(errMessage: 'Email login error: $e'));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userResetPassword(email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailuer(errMessage: 'Reset password error: $e'));
    }
  }

  Future<void> changePassword(String password) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userChangePassword(password);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailuer(errMessage: 'Change password error: $e'));
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
        data: {'full_name': name, 'phone': phone},
      );
      if (response.session != null) {
        emit(AuhtSuccess());
      } else {
        emit(AuhtFailuer(errMessage: 'Signup failed: No session created'));
      }
    } on AuthException catch (e) {
      emit(AuhtFailuer(errMessage: 'Signup error: ${e.message}'));
    } catch (e) {
      emit(AuhtFailuer(errMessage: 'Signup error: $e'));
    }
  }
}
