import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Constant/End_Points.dart';
import 'package:shopapp/Data_layer/Models/Shop_app_Category_model.dart';
import 'package:shopapp/Data_layer/Models/Shop_app_Home_model.dart';
import 'package:shopapp/Presentation_layer/Screens/category/categories.dart';
import 'package:shopapp/Presentation_layer/Screens/favourite/favourite.dart';
import 'package:shopapp/Presentation_layer/Screens/proudcts/proudcts.dart';
import 'package:shopapp/Presentation_layer/Screens/settings/settings.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';
import 'package:shopapp/helper/dio_helper.dart';

import '../../Constant/const.dart';
import '../../Data_layer/Models/Change_favourite_model.dart';
import '../../Data_layer/Models/Get_Profile_Data.dart';
import '../../Data_layer/Models/Register.dart';
import '../../Data_layer/Models/ShopModel.dart';
import '../../Data_layer/Models/favouriteModel.dart';
import '../../Data_layer/Models/searchModel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InithialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> bottomScreens = [
    const ProudctssScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentindex = index;

    emit(ChangeBottonNaveShopState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelpper.GetData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        favourite.addAll({element.id!: element.inFavorites!});
      });

      print(favourite.toString());

      emit(ShopSucessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategory() {
    emit(ShopLoadingCategoryState());

    DioHelpper.GetData(
      url: GET_CATEGOY,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel!.data);

      emit(ShopSucessCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryState());
    });
  }

  Map<int?, bool?> favourite = {};
  ChangeFavouriteID? changeFavouriteID;

  void changeFavourite(int proudctId) {
    favourite[proudctId] = !favourite[proudctId]!;
    emit(ShopChangeFavouriteState());

    DioHelpper.PostData(
            url: FaVOURITE, data: {'product_id': proudctId}, token: mytoken)
        .then((value) {
      changeFavouriteID = ChangeFavouriteID.fromJson(value.data);

      print(value.data);

      if (!changeFavouriteID!.status!) {
        favourite[proudctId] = !favourite[proudctId]!;
      }

      emit(ShopSucessFavouriteState(changeFavouriteID!));
    }).catchError((error) {
      favourite[proudctId] = !favourite[proudctId]!;

      print(error.toString());
      emit(ShopErrorFavouriteState());
    });
  }

  // FavouriteModel? favouriteModel ;
  //
  // void getFavourite() {
  //   emit(ShopLoadingCategoryState());
  //
  //   DioHelpper.GetData(
  //     url: FaVOURITE,
  //     token: mytoken,
  //   ).then((value) {
  //     favouriteModel = FavouriteModel.fromJson(value.data!);
  //
  //     print(favouriteModel!.data!.toString());
  //
  //     emit(ShopSucessGetFavouriteState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorGetFavouriteState());
  //   });
  // }

  Usermodel? usermodel;

  getUserModel() {
    emit(ShopLoadingUserModelState());
    DioHelpper.GetData(
      url: PROFILE,
      token: mytoken,
    ).then((value) {
      usermodel = Usermodel.fromJson(value.data!);
      print(usermodel!.data);
      emit(ShopSucessUserModelState());
    }).catchError((error) {
      print(error.toString());
      print(error.toString());
      emit(ShopErrorUserModelState());
    });

  }

  ShopLoginModel? shopLoginModel;

  updateUserModel(
    @required String name,
    @required String email,
    @required String phone,
  ) {
    emit(ShopUpdateUserLoadingState());
    DioHelpper.putData(url: UPDATE_USER, token: 'mytoken', data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) async {
      shopLoginModel = await ShopLoginModel.fromJson(value.data!);
      emit(ShopUpdateUserSuccessState(shopLoginModel!));
    }).catchError((error) {
      emit(ShopUpdateUserErrorState());
    });
  }

  RegisterModel? registerModel ;

  void userRegister(
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  ) {
    emit(ShopRegisterLoadingState());
    DioHelpper.PostData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }



  SearchModel? searchModel;

   search(String text)
  {
    emit(SearchLoadingState());
    DioHelpper.PostData(url: SEARCH,
        token: mytoken,
        data: {
          'text': text
        }
    ).then((value) {
      emit(SearchSuccessState());
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel);

    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibaility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePaswword());
  }
}
