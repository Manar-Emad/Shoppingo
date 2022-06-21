import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/categories/categories_screen.dart';
import 'package:shop/faviroutes/favourities_screen.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/products/products_screen.dart';
import 'package:shop/settings/settings_screen.dart';
import 'package:shop/shared/components/constants.dart';
import '../models/change_fav_model.dart';
part 'shop_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopStatesInitial());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [

    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBar());
  }

  late HomeModel homeModel;
  Map<int, bool> favourities = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel.data?.banners![0].image);
      // print(homeModel.status);

      /// to add favorites
      homeModel.data?.products?.forEach((element) {
        favourities.addAll({element.id: element.inFavorites});
      });
      print(favourities.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    favourities[productId] =! favourities[productId]!;
    emit(ShopChangesFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'productId': productId},
      token: token ,
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel.status!){
        favourities[productId] = !favourities[productId]!;

      }
      emit(ShopSuccessChangesFavoritesState( changeFavoritesModel)
      );}).catchError((error)
    {

        favourities[productId] =! favourities[productId]!;

      emit(ShopErrorChangesFavoritesState());});
  }

}
