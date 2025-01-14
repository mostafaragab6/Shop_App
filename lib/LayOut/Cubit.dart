
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_project/Model/AddCartModel.dart';
import 'package:shop_project/Model/GetCartModel.dart';
import 'package:shop_project/Model/LogOutModel.dart';
import 'package:shop_project/Model/LoginModel.dart';
import 'package:shop_project/Model/RegisterModel.dart';
import 'package:shop_project/Model/SearchModel.dart';
import 'package:shop_project/Modules/CartScreen.dart';
import 'package:shop_project/Modules/Profile.dart';

import '../Const/Components.dart';
import '../Model/CategoriesModel.dart';
import '../Model/FavModel.dart';
import '../Model/FavouritesGetModel.dart';
import '../Model/HomeModel.dart';
import '../Model/UserProfileModel.dart';
import '../Modules/CategoriesScreen.dart';
import '../Modules/FavoritesScreen.dart';
import '../Modules/ProductsScreen.dart';
import '../Modules/SettingsScreen.dart';
import '../Shared/Network/DioHelper.dart';
import 'States.dart';

class ShopHomeCubit extends Cubit<ShopStates> {
  ShopHomeCubit() :super(ShopInitialStete());

  static ShopHomeCubit Get(context) => BlocProvider.of(context);


  List<BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(icon: Image(
      image: AssetImage("icons/home.png"), width: 25.0, height: 25.0,),
        label: 'Products'),
    BottomNavigationBarItem(icon: Image(
      image: AssetImage("icons/category.png"), width: 25.0, height: 25.0,),
        label: 'Categories'),
    BottomNavigationBarItem(icon: Image(
      image: AssetImage("icons/wishlist.png"), width: 25.0, height: 25.0,),
        label: 'Favorites'),
    BottomNavigationBarItem(icon: Image(
      image: AssetImage("icons/shopping-bag.png"), width: 25.0, height: 25.0,),
        label: 'Cart'),


  ];

  List<Widget> Screens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen()

  ];


  int currentIndex = 0;

  void ChangeNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> fav = {};
  Map<int, bool>cart={};
  void getHomeData() {
    emit(ShopLoadingGetDataState());

    DioHelper.GetData(
        url: 'home',
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        fav.addAll({
          element.id!: element.in_favorite!
        });
      }
      );
      homeModel!.data!.products.forEach((element) {
        cart.addAll({
          element.id!: element.in_cart!
        });
      }
      );

      emit(ShopSuccessGetDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetDataState(error.toString()));
    });
  }

  SearchModel? searchModel;

  void getSearchData(String searchedName) {
    emit(ShopLoadingSearchDataState());
    DioHelper.PostData(
      url: 'products/search',
      query: {
        'text': searchedName,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);


      emit(ShopSuccessSearchDataState());
    }).catchError((error) {
      print('>>>>>>>>>>>>');
      print(error.toString());
      emit(ShopErrorSearchDataState(error.toString()));
    });
  }

  AddCartModel? addCartModel;

  void AddCartData(int id) {
    cart[id] = !cart[id]!;
    emit(ShopLoadingAddCartState());
    DioHelper.PostData(
      url: 'carts',
      query: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      addCartModel = AddCartModel.fromJson(value.data);
      getCartData();

      if (!addCartModel!.status!) {
        cart[id] = !cart[id]!;
      }

      print(addCartModel!.message!);
      emit(ShopSuccessAddCartState(addCartModel!));
    }).catchError((error) {
      print('>>>>>>>>>>>>');
      print(error.toString());
      emit(ShopErrorAddCartState(error.toString()));
    });
  }


  int totalPrice = 0;
  GetCartModel? cartModel;

  void getCartData() {
    emit(ShopLoadingCartDataState());
    DioHelper.GetData(
      url: 'carts',
      token: token,
    ).then((value) {
      cartModel = GetCartModel.fromJson(value.data);
      cartModel!.data!.cartItems.forEach((element) {
        totalPrice = totalPrice + element.product!.price!;
      });

      emit(ShopSuccessCartDataState());
    }).catchError((error) {
      print('>>>>>>>>>>>>');
      print(error.toString());
      emit(ShopErrorCartDataState(error.toString()));
    });
  }


  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingGetCategoriesDataState());

    DioHelper.GetData(
        url: 'categories',
        token: token
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data!.current_page);
      emit(ShopSuccessGetCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCategoriesDataState(error.toString()));
    });
  }

  FavModel? favModel;

  void SelectFav(int prodId) {
    fav[prodId] = !fav[prodId]!;
    emit(ShopSelectFavState());
    DioHelper.PostData(

      url: 'favorites',
      data:
      {
        'product_id': prodId
      },
      token: token,
    ).then((value) {
      favModel = FavModel.fromJson(value.data!);
      GetFav();
      emit(ShopSuccessSelectFavState(favModel!));
      if (!favModel!.status!) {
        fav[prodId] = !fav[prodId]!;
      }
    }).catchError((Error) {
      emit(ShopErrorSelectFavState(Error));
      fav[prodId] = !fav[prodId]!;
      print(Error.toString());
    });
  }


  favData? data;

  void GetFav() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.GetData(
      url: 'favorites',
      token: token,
    ).then((value) {
      data = favData.fromJson(value.data);
      print('555555');
      print(data!.data!.current_page);
      emit(ShopSuccessGetFavoritesDataState(value.data));
    }).catchError((Error) {
      print(Error.toString());
      emit(ShopErrorGetFavoritesDataState(Error.toString()));
    });
  }


  ShopUserProfileModel? userData;

  void GetUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.GetData(
      url: 'profile',
      token: token,
    ).then((value) {
      userData = ShopUserProfileModel.fromJson(value.data);

      print(userData!.data!.name);
      emit(ShopSuccessGetUserDataState(value.data));
    }).catchError((Error) {
      print(Error.toString());
      emit(ShopErrorGetUserDataState(Error.toString()));
    });
  }

  LogOutModel? logOutData;

  void LogOut() {
    emit(ShopLoadingLogOutState());
    DioHelper.PostData(
        url: 'logout',
        data: {
          'fcm_token': token
        }).then((value) {
      logOutData = LogOutModel.fromJson(value.data);
      emit(ShopSuccessLogOutState(logOutData!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorLogOutState(onError.toString()));
    });
  }

  ShopLoginModel? updatedData;

  void UpdateData({
    required String name,
    required String email,
    required String phone,
    String? password,
    String? image,
  }) {
    emit(ShopLoadingUpdateState());

    DioHelper.PutData(
      url: "update-profile",
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "image": image
      },
      token: token,
    ).then((value) {
      updatedData = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateState(updatedData!));
    }).catchError((Error) {
      print(Error.toString());
      emit(ShopErrorUpdateState(Error));
    });
  }

  bool isPass = true;
  IconData suffix = Icons.visibility_off_outlined;

  void ChangePasswordVisibility() {
    isPass = !isPass;
    isPass ? suffix = Icons.visibility_off_outlined : suffix =
        Icons.visibility_outlined;
    emit(ShopChangePassState());
  }


  Future PickedImage(File? image) async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    image = File(returnedImage!.path);

    emit(ShopGetImageState());
  }

}