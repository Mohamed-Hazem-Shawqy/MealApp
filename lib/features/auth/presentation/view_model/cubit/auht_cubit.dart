import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/auth/data/repo_impl.dart';

part 'auht_state.dart';

class AuhtCubit extends Cubit<AuhtState> {
  AuhtCubit() : super(AuhtInitial());
  RepoImpl repoImpl = RepoImpl();
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
}
