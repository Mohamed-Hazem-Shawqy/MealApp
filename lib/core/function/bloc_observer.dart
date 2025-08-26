import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('\u{1F7E1} Changed: ${bloc.runtimeType}:$change');
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    print('\u{1F7E2} Created: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('\u{274C} Error: ${bloc.runtimeType}:$error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    print('\u{1F534} Closed: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
