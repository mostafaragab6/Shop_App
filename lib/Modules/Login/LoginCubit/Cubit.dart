
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/LoginModel.dart';
import '../../../Shared/Network/DioHelper.dart';
import 'States.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit(): super (ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);


  late ShopLoginModel loginModel;
  void UserData({required String email,required String password}){
    emit(ShopLoginInLoadingState());

    DioHelper.PostData(
        url: 'login',
        data: {
          'email':email,
          'password':password
        }
    ).then((value) {

      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.data!.phone);
      emit(ShopLoginInSuccessState(loginModel));
    }).catchError((error){

      emit(ShopLoginInErrorState(error.toString()));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_off_outlined;
  void ChangePasswordVisibility(){
    isPass=!isPass;
    isPass? suffix = Icons.visibility_off_outlined : suffix = Icons.visibility_outlined;
    emit(ShopLoginInChangePasswordState());
  }

}