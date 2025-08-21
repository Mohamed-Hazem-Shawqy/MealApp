part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class UserSendMessage extends UserState {
  final String usermessage;

  UserSendMessage({required this.usermessage});
}

