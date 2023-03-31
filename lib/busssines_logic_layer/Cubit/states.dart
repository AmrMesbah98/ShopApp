import '../../Data_layer/Models/Change_favourite_model.dart';
import '../../Data_layer/Models/Register.dart';
import '../../Data_layer/Models/ShopModel.dart';

abstract class ShopStates {}

class InithialShopState extends ShopStates{}

class ChangeBottonNaveShopState extends ShopStates{}


class ShopLoadingHomeDataState extends ShopStates{}

class ShopSucessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopLoadingCategoryState extends ShopStates{}

class ShopSucessCategoryState extends ShopStates{}

class ShopErrorCategoryState extends ShopStates{}


class ShopSucessFavouriteState extends ShopStates{
  final ChangeFavouriteID model ;
  ShopSucessFavouriteState(this.model);
}


class ShopChangeFavouriteState extends ShopStates{}
class ShopErrorFavouriteState extends ShopStates{}


class ShopSucessGetFavouriteState extends ShopStates{}

class ShopErrorGetFavouriteState extends ShopStates{}


class ShopLoadingUserModelState extends ShopStates{}

class ShopSucessUserModelState extends ShopStates{}

class ShopErrorUserModelState extends ShopStates{}









class ShopRegisterInitialState extends ShopStates {}

class ShopRegisterLoadingState extends ShopStates {}

class ShopRegisterSuccessState extends ShopStates {
  final RegisterModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}
class ShopRegisterErrorState extends ShopStates {
  final String error;
  ShopRegisterErrorState(this.error);

}



class ShopUpdateUserLoadingState extends ShopStates {}

class ShopUpdateUserSuccessState extends ShopStates {
  final ShopLoginModel shopLoginModel;

  ShopUpdateUserSuccessState(this.shopLoginModel);
}

class ShopUpdateUserErrorState extends ShopStates {}





class ShopChangePaswwordSuccessState extends ShopStates {}


class ShopChangePaswword extends ShopStates {}



class SearchInitialState extends ShopStates{}
class SearchLoadingState extends ShopStates{}
class SearchSuccessState extends ShopStates{}
class SearchErrorState extends ShopStates{}




