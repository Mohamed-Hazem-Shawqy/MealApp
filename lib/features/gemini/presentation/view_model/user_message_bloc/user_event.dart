part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();
}

class UserSendEvent extends UserEvent {
  final String userMessage;

  const UserSendEvent({required this.userMessage});

  @override
  List<Object?> get props => [userMessage];
}
