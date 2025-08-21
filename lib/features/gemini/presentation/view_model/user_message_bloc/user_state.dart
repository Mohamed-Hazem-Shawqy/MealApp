part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {
  final List<String> usermessage;
  const UserState({required this.usermessage});
}

final class UserInitial extends UserState {
  UserInitial() : super(usermessage: []);

  @override
  List<Object?> get props => [usermessage];
}

final class UserSendMessage extends UserState {
  const UserSendMessage({required super.usermessage});

  @override
  List<Object?> get props => [usermessage];
}
