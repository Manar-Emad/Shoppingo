import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop/network/end_points.dart';
import 'package:shop/network/remote/dio_helper.dart';

import '../../models/login_model.dart';

part 'shop_login_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void UserLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {'email': '', 'password': ''}, query: {},)
        .then((value) {
      print(value.data);
      loginModel =LoginModel.fromJson(value.data);
      // print(loginModel?.status);
      // print(loginModel?.message);
      // print(loginModel?.data?.token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true ;
  void changePasswordVisibility(){
    suffix=Icons.visibility_outlined;
    isPassword = ! isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}

