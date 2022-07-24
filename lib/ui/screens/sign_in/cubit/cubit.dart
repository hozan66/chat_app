import 'package:chat_app/ui/screens/sign_in/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/end_points.dart';
import '../../../../network/models/sign_in_model.dart';
import '../../../../network/remote/dio_helper.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInInitialState());

  // Create an object from cubit
  static SignInCubit get(context) => BlocProvider.of(context);

  // All logic in cubit
  late SignInModel signInModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SignInLoadingState());

    DioHelper.postData(
      url: signInEndPoint, // endpoint
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      signInModel = SignInModel.fromJson(value.data);
      emit(SignInSuccessState(signInModel));
    }).catchError((error) {
      debugPrint('Error=${error.toString()}');
      emit(SignInErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
