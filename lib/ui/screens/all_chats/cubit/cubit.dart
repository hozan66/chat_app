import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AllChatsCubit extends Cubit<AllChatsStates> {
  AllChatsCubit() : super(AllChatsInitialState());

  // Create an object from cubit
  static AllChatsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // List<Widget> bottomScreens = [
  // const ProductsScreen(),
  // const CategoriesScreen(),
  // const FavoritesScreen(),
  // ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AllChatsChangeBottomNavState());
  }
}
