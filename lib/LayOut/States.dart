import 'package:shop_project/Model/FavouritesGetModel.dart';
import 'package:shop_project/Model/RegisterModel.dart';

import '../Model/AddCartModel.dart';
import '../Model/FavModel.dart';
import '../Model/LogOutModel.dart';
import '../Model/LoginModel.dart';

abstract class ShopStates{}

class ShopInitialStete extends ShopStates{}

class ShopChangeNavBarState extends ShopStates {}

class ShopLoadingGetDataState extends ShopStates {}

class ShopSuccessGetDataState extends ShopStates {}

class ShopErrorGetDataState extends ShopStates {
  String error ;
  ShopErrorGetDataState(this.error);
}

class ShopLoadingGetCategoriesDataState extends ShopStates {}

class ShopSuccessGetCategoriesDataState extends ShopStates {}

class ShopErrorGetCategoriesDataState extends ShopStates {
  String error ;
  ShopErrorGetCategoriesDataState(this.error);
}

class ShopLoadingSearchDataState extends ShopStates {}

class ShopSuccessSearchDataState extends ShopStates {}

class ShopErrorSearchDataState extends ShopStates {
  String error ;
  ShopErrorSearchDataState(this.error);
}

class ShopLoadingCartDataState extends ShopStates {}

class ShopSuccessCartDataState extends ShopStates {}

class ShopErrorCartDataState extends ShopStates {
  String error ;
  ShopErrorCartDataState(this.error);
}


class ShopSelectFavState extends ShopStates {}
class ShopSuccessSelectFavState extends ShopStates {
  final FavModel model;

  ShopSuccessSelectFavState(this.model);
}

class ShopErrorSelectFavState extends ShopStates {
  String error ;
  ShopErrorSelectFavState(this.error);
}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesDataState extends ShopStates {
  final favData data;

  ShopSuccessGetFavoritesDataState(this.data);
}

class ShopErrorGetFavoritesDataState extends ShopStates {
  String error ;
  ShopErrorGetFavoritesDataState(this.error);
}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel userData;

  ShopSuccessGetUserDataState(this.userData);
}

class ShopErrorGetUserDataState extends ShopStates {
   String error ;
  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingLogOutState extends ShopStates {}

class ShopSuccessLogOutState extends ShopStates {
  final LogOutModel userData;

  ShopSuccessLogOutState(this.userData);
}

class ShopErrorLogOutState extends ShopStates {
  String error ;
  ShopErrorLogOutState(this.error);
}

class ShopLoadingAddCartState extends ShopStates {}

class ShopSuccessAddCartState extends ShopStates {
  final AddCartModel cartData;

  ShopSuccessAddCartState(this.cartData);
}

class ShopErrorAddCartState extends ShopStates {
  String error ;
  ShopErrorAddCartState(this.error);
}

class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {
  final ShopLoginModel userData;

  ShopSuccessUpdateState(this.userData);
}

class ShopErrorUpdateState extends ShopStates {
  String error ;
  ShopErrorUpdateState(this.error);
}

class ShopChangePassState extends ShopStates {}
class ShopGetImageState extends ShopStates {}