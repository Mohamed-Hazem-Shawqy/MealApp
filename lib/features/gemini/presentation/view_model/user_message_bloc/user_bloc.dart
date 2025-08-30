import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserSendEvent>((event, emit) async {
      final List<String> userMessages = state is UserSendMessage
          ? state.usermessage
          : [];

      userMessages.add(event.userMessage);
      emit(UserSendMessage(usermessage: userMessages));
    });
  }
}
