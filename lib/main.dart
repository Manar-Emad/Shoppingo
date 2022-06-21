import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_cubit/cubit.dart';
import 'package:shop/app_cubit/states.dart';
import 'package:shop/shop_cubit/shop_cubit.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/styles/themes.dart';

import 'faviroutes/favourities_screen.dart';
import 'layout/shop_layout.dart';
import 'network/remote/dio_helper.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget=Container();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding!=null){
    if(token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else {widget=OnBoardingScreen();}

  print(onBoarding);
  runApp(MyApp(isDark:isDark!, StartWidget: widget, onBoarding: onBoarding!, widget: Container(),));
}

class MyApp extends StatelessWidget {
  final bool isDark;
 final Widget widget;


  final bool onBoarding;
  final Widget StartWidget;

  MyApp({ required this.isDark, required this.StartWidget, required this.onBoarding, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //     create: (context) => NewsCubit()
        //       ..getBusiness()
        //       ..getSports()
        //       ..getScience()),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:darkTheme,
            home:  Directionality(
                textDirection: TextDirection.ltr,
                child: StartWidget,
               // onBoarding ? ShopLoginScreen() : OnBoardingScreen(),
            ),
          );
        },
      ),
    );
  }
}

