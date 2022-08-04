import 'package:path_provider/path_provider.dart';

import 'business_logic/bloc_exports.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'shared/bloc_observer.dart';
import 'shared/constants/strings.dart';
import 'shared/styles/my_theme.dart';
import 'ui/screens/all_chats/all_chats_screen.dart';
import 'ui/screens/sign_in_and_sign_up/sign_in_and_sign_up_screen.dart';
import 'ui/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

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

  HydratedBlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isWelcomeScreen: isWelcomeScreen,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
    // Implement the storage
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final bool? isWelcomeScreen;
  final Widget? startWidget;

  const MyApp({Key? key, this.isWelcomeScreen, this.startWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Global access object
      create: (context) => UserChatBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat App',
        theme: MyTheme.lightThemeData(context),
        darkTheme: MyTheme.darkThemeData(context),
        home: startWidget,
      ),
    );
  }
}
