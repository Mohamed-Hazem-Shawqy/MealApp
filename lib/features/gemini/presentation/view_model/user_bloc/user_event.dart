part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}
class UserSendEvent extends UserEvent{
  
  final String userMessage;

  UserSendEvent({required this.userMessage});

}
