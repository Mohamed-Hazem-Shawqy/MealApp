part of 'auht_cubit.dart';

sealed class AuhtState {}

final class AuhtInitial extends AuhtState {}

final class AuhtLoading extends AuhtState {}

final class AuhtSuccess extends AuhtState {}

final class AuhtFailuer extends AuhtState {
  final String errMessage;

  AuhtFailuer({required this.errMessage});
}

final class ResetPasswordSuccess extends AuhtState {}
final class ResetPasswordFailuer extends AuhtState {
  final String errMessage;

  ResetPasswordFailuer({required this.errMessage});
  
}
