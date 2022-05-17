
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/states.dart';
import '../../network/local/cache_helper.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // List<Widget> screens = [
  //   NewTasksScreen(),
  //   NewDoneTasksScreen(),
  //   ArchivedTasksScreen(),
  // ];
  // List<String> titles = [
  //   'New Tasks',
  //   'Done Tasks',
  //   'Archived Tasks',
  // ];
  //
  // void ChangeIndex(int index) {
  //   currentIndex = index;
  //   emit(AppChangeBottomNavBarState());
  // }
  //
  // bool isButtomSheetShown = false;
  // IconData fabIcon = Icons.edit;
  //
  // void AppChangeBottomSheetState({required isShown, required icon}) {
  //   isShown = isButtomSheetShown;
  //   icon = fabIcon;
  // }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }
}

