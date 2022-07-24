import 'package:chat_app/shared/styles/my_colors.dart';
import 'package:chat_app/ui/screens/sign_up/cubit/cubit.dart';
import 'package:chat_app/ui/screens/sign_up/cubit/states.dart';
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
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Keys are used to find a specific widget
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            if (state.signUpModel.status == 'success') {
              debugPrint(state.signUpModel.status);
              debugPrint(state.signUpModel.data.accessToken);

              CacheHelper.saveData(
                key: 'token',
                value: state.signUpModel.data.accessToken,
              ).then((value) {
                navigateAndFinish(context, const AllChatsScreen());
              });
            } else {
              debugPrint(state.signUpModel.status);

              showToast(
                text: state.signUpModel.status,
                state: ToastStates.error,
              );
            }
          } else if (state is SignUpErrorState) {
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
                            "SIGN UP",
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

                                SignUpCubit.get(context).userRegister(
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
                                SignUpCubit.get(context).isPasswordShown,
                            suffixPressed: () {
                              SignUpCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            suffix: SignUpCubit.get(context).suffix,
                            submit: (String? value) {
                              if (_formKey.currentState!.validate()) {
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');

                                SignUpCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignUpLoadingState,
                            builder: (context) => PrimaryButton(
                              text: 'Sign Up',
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      'emailController=${emailController.text}');
                                  print(
                                      'passwordController=${passwordController.text}');

                                  SignUpCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            fallback: (context) => buildLoadingIndicator(
                                color: MyColors.mySecondaryColor),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                              DefaultTextButton(
                                text: 'SIGN IN',
                                color: MyColors.mySecondaryColor,
                                press: () {
                                  navigateAndFinish(context, SignInScreen());
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
