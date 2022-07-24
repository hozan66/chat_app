import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/primary_button.dart';
import '../../../shared/constants/default_values.dart';
import '../sign_in/sign_in_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInAndSignUpScreen extends StatelessWidget {
  const SignInAndSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: myDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? 'assets/images/Logo_light.png'
                    : 'assets/images/Logo_dark.png',
                height: 146.0,
              ),
              const Spacer(), // flex: 1
              PrimaryButton(
                  text: 'Sign In',
                  press: () {
                    navigateAndFinish(context, SignInScreen());
                  }),
              const SizedBox(
                height: myDefaultPadding * 1.5,
              ),
              PrimaryButton(
                text: 'Sign Up',
                press: () {
                  navigateAndFinish(context, SignUpScreen());
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
