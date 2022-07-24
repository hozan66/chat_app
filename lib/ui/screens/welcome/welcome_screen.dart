import 'package:flutter/material.dart';

import '../../../network/local/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/constants/default_values.dart';
import '../sign_in_and_sign_up/sign_in_and_sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/welcome_image.png"),
            const Spacer(flex: 3),
            Text(
              "Welcome to our freedom \nmessaging app",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(), // Spacer(flex: 1)
            Text(
              "Freedom talk any person of your \nmother language.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
            const Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () {
                    CacheHelper.saveData(key: 'welcome', value: true)
                        .then((value) {
                      if (value) {
                        navigateAndFinish(
                            context, const SignInAndSignUpScreen());
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Skip',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.8),
                            ),
                      ),
                      const SizedBox(width: myDefaultPadding / 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.0,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.8),
                      ),
                    ],
                  )),
            ),
            const Spacer(), // Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}
