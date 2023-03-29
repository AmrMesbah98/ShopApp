import '../../Data_layer/Models/Change_favourite_model.dart';

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