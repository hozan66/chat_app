import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/local/cache_helper.dart';
import '../../../shared/components/build_form_field.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/default_text_button.dart';
import '../../../shared/components/primary_button.dart';
import '../../../shared/constants/default_values.dart';
import '../all_chats/all_chats_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Keys are used to find a specific widget
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            if (state.signInModel.status == 'success') {
              debugPrint(state.signInModel.status);
              debugPrint(state.signInModel.accessToken);
              // We need to store (token) in share_preference for every login
              // It will be delete it from share_preference once user logout

              CacheHelper.saveData(
                key: 'token',
                value: state.signInModel.accessToken,
              ).then((value) {
                navigateAndFinish(context, const AllChatsScreen());
              });
            } else {
              debugPrint(state.signInModel.status);

              showToast(
                text: state.signInModel.status,
                state: ToastStates.error,
              );
            }
          } else if (state is SignInErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(context),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: myDefaultPadding),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      // This widget used for validation
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "SIGN IN",
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(0.8),
                                    ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          BuildFormField(
                            controller: emailController,
                            label: 'Email Address',
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty ||
                                  !EmailValidator.validate(value)) {
                                return 'Email address is not valid';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            submit: (String? value) {
                              if (_formKey.currentState!.validate()) {
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');

                                SignInCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          BuildFormField(
                            controller: passwordController,
                            label: 'Password',
                            isPassword:
                                SignInCubit.get(context).isPasswordShown,
                            suffixPressed: () {
                              SignInCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            suffix: SignInCubit.get(context).suffix,
                            submit: (String? value) {
                              if (_formKey.currentState!.validate()) {
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');

                                SignInCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextButton(
                            press: () {},
                            text: 'Forget Password',
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignInLoadingState,
                            builder: (context) => PrimaryButton(
                                text: 'Sign In',
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    print(
                                        'emailController=${emailController.text}');
                                    print(
                                        'passwordController=${passwordController.text}');

                                    SignInCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                }),
                            fallback: (context) => buildLoadingIndicator(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                              DefaultTextButton(
                                text: 'SIGN UP',
                                press: () {
                                  navigateAndFinish(context, SignUpScreen());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
