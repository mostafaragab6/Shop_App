
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/Model/RegisterModel.dart';
import 'package:shop_project/Modules/Register/RegisterCubit/states.dart';

import '../../../Shared/Network/DioHelper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit(): super (ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=> BlocProvider.of(context);


  RegisterModel? registerModel;
  void RegisterData({
    required String email,
    required String name,
    required String phone,
    required String password
  }){
    emit(ShopRegisterLoadingState());

    DioHelper.PostData(
        url: 'register',
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        }
    ).then((value) {

      registerModel = RegisterModel.fromJson(value.data);
      //print(registerModel!.message);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_off_outlined;
  void ChangePasswordVisibility(){
    isPass=!isPass;
    isPass? suffix = Icons.visibility_off_outlined : suffix = Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordState());
  }

}