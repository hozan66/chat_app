import 'states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/end_points.dart';
import '../../../../network/models/sign_up_model.dart';
import '../../../../network/remote/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  // Create an object from cubit
  static SignUpCubit get(context) => BlocProvider.of(context);

  late SignUpModel signUpModel;
  // All logic in cubit
  void userRegister({
    required String email,
    required String password,
  }) {
    emit(SignUpLoadingState());

    DioHelper.postData(
      url: signUpEndPoint, // endpoint
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      debugPrint(value.data.toString());
      signUpModel = SignUpModel.fromJson(value.data);

      emit(SignUpSuccessState(signUpModel));
    }).catchError((error) {
      debugPrint('Error=${error.toString()}');
      emit(SignUpErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SignUpChangePasswordVisibilityState());
  }
}
