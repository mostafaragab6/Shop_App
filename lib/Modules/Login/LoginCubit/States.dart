
import '../../../Model/LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginInLoadingState extends ShopLoginStates{}
class ShopLoginInSuccessState extends ShopLoginStates
{
  ShopLoginModel loginModel ;
  ShopLoginInSuccessState(this.loginModel);
}
class ShopLoginInErrorState extends ShopLoginStates{
  final String error;
  ShopLoginInErrorState(this.error);
}

class ShopLoginInChangePasswordState extends ShopLoginStates{}