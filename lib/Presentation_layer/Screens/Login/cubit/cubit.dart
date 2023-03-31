import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Constant/End_Points.dart';
import 'package:shopapp/Data_layer/Models/ShopModel.dart';
import 'package:shopapp/Presentation_layer/Screens/Login/cubit/state.dart';

import '../../../../Constant/const.dart';
import '../../../../helper/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? shopLoginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelpper.PostData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      //print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibaility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePaswwordSuccessState());
  }



}
