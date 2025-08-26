import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      await repoImpl.userLoginWithGoogle(context);

      emit(AuhtSuccess());
    } catch (e) {
      emit(AuhtFailuer(errMessage: e.toString()));
    }
  }

  Future<void> loginwithEmail(String email, String password, context) async {
    emit(AuhtLoading());
    try {
      await repoImpl.userLogin(email, password, context);
      emit(AuhtSuccess());
    } catch (e) {
      emit(AuhtFailuer(errMessage: e.toString()));
    }
  }

//   to Reset Password
  // Future<void> userResetPassword(String email) async {
  //   try {
  //     await repoImpl.userResetPassword(email);
  //     emit(ResetPasswordSuccess());
  //   } catch (e) {
  //     emit(ResetPasswordFailuer(errMessage: e.toString()));
  //   }
  // }
  // Future<void> userChangePassword(String password) async {
  //   try {
  //     await repoImpl.userChangePassword(password);
  //     emit(ResetPasswordSuccess());
  //   } catch (e) {
  //     emit(ResetPasswordFailuer(errMessage: e.toString()));
  //   }
  // }


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

