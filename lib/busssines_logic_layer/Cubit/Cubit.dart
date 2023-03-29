import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
import '../../Data_layer/Models/favouriteModel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InithialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> bottomScreens = [
    const ProudctssScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
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
        favourite.addAll({
          element.id!: element.inFavorites!
        });
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
        url: FaVOURITE,
        data: {'product_id': proudctId},
        token: mytoken
    ).then(( value) {
      changeFavouriteID = ChangeFavouriteID.fromJson(value.data);

      print(value.data);

      if(!changeFavouriteID!.status!)
        {
          favourite[proudctId] = !favourite[proudctId]!;
        }

      emit(ShopSucessFavouriteState(changeFavouriteID!));

    } ).catchError((error)
    {
      favourite[proudctId] = !favourite[proudctId]!;

      print(error.toString());
      emit(ShopErrorFavouriteState());
    });


  }


  FavouriteModel? favouriteModel ;

  void getFavourite() {
    emit(ShopLoadingCategoryState());

    DioHelpper.GetData(
      url: FaVOURITE,
      token: mytoken,
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);

      print(favouriteModel!.data.toString());

      emit(ShopSucessGetFavouriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouriteState());
    });
  }


}
