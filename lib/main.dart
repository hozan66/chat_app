import 'package:chat_app/network/local/cache_helper.dart';
import 'package:chat_app/network/remote/dio_helper.dart';
import 'package:chat_app/shared/bloc_observer.dart';
import 'package:chat_app/shared/constants/strings.dart';
import 'package:chat_app/shared/styles/my_theme.dart';
import 'package:chat_app/ui/screens/all_chats/all_chats_screen.dart';
import 'package:chat_app/ui/screens/sign_in_and_sign_up/sign_in_and_sign_up_screen.dart';
import 'package:chat_app/ui/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isWelcomeScreen = CacheHelper.getData(key: 'welcome');
  debugPrint('isWelcomeScreen=$isWelcomeScreen');
  Widget? widget;
  token = CacheHelper.getData(key: 'token');
  debugPrint('token=$token');

  if (isWelcomeScreen != null) {
    if (token != null) {
      widget = const AllChatsScreen();
    } else {
      widget = const SignInAndSignUpScreen();
    }
  } else {
    widget = const WelcomeScreen();
  }
  // Create this screen
  widget = const AllChatsScreen();
  token = 'Hozan';

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isWelcomeScreen: isWelcomeScreen,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isWelcomeScreen;
  final Widget? startWidget;

  const MyApp({Key? key, this.isWelcomeScreen, this.startWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat App',
      theme: MyTheme.lightThemeData(context),
      darkTheme: MyTheme.darkThemeData(context),
      home: startWidget,
    );
  }
}
