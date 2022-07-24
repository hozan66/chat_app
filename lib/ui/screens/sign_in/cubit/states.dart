import '../../../../network/models/sign_in_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessState extends SignInStates {
  final SignInModel signInModel;

  SignInSuccessState(this.signInModel);
}

class SignInErrorState extends SignInStates {
  final String error;

  SignInErrorState(this.error);
}

class ChangePasswordVisibilityState extends SignInStates {}
