import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

//MyBlocObserver helps in (We will keep track where are we)
class MyBlocObserver extends BlocObserver {
  //It comes from => bloc: ^7.0.0
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint(
        'onCreate -- ${bloc.runtimeType}'); //runtimeType determines which type (data type) of object bloc is
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- ${bloc.runtimeType}');
  }
}
