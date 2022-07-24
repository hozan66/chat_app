import 'package:chat_app/network/models/sign_up_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final SignUpModel signUpModel;

  SignUpSuccessState(this.signUpModel);
}

class SignUpErrorState extends SignUpStates {
  final String error;

  SignUpErrorState(this.error);
}

class SignUpChangePasswordVisibilityState extends SignUpStates {}
