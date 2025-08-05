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
}
