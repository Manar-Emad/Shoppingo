part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopStatesInitial extends ShopStates {}

class ShopChangeBottomNavBar extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}


class ShopSuccessChangesFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangesFavoritesState(this.model);
}

class ShopErrorChangesFavoritesState extends ShopStates{}

class ShopChangesFavoritesState extends ShopStates{}
