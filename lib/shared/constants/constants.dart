import '../../network/local/cache_helper.dart';
import '../../ui/screens/sign_in/sign_in_screen.dart';
import '../components/components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, SignInScreen());
    }
  });
}
