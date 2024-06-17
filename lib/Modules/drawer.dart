import 'package:another_flushbar/flushbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_project/Const/Components.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';
import 'package:shop_project/Modules/CartScreen.dart';
import 'package:shop_project/Modules/Login/LoginScreen.dart';
import 'package:shop_project/Shared/Network/CasheHelper.dart';

import 'Update_Screens/Choose_Updates_Screen.dart';

class MyDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit=ShopHomeCubit.Get(context);
        return ConditionalBuilder(
          condition: cubit.userData !=null,
          builder: (BuildContext context) {
            return Drawer(
                child: SafeArea(
                  child: ListView(
                    children: [
                      Container(
                         
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(top: 40.0,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(child: Image.network('${cubit.userData!.data!.image}',width: 150.0,height: 150.0,)),
                                SizedBox(height: 10.0,),
                                Text('${cubit.userData!.data!.name}'),
                                SizedBox(height: 5.0,),

                                Text('${cubit.userData!.data!.email}',style: TextStyle(color:Colors.grey),),
                                SizedBox(height: 10.0,),

                                Container(
                                  width: 120.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadiusDirectional.circular(10.0),
                                    color: Colors.white
                                  ),
                                  child: MaterialButton(onPressed: (){
                                    navigatTo(context, UpdateScreen());
                                  },
                                  child: Text('Edit Profile'),
                                    
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Image.asset('icons/wishlist.png',width: 25.0,height: 25.0,),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){
                                    cubit.ChangeNavBar(2);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("My favorites",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Image.asset('icons/shopping-bag.png',width: 25.0,height: 25.0,),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){
                                    cubit.ChangeNavBar(3);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("My cart",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Icon(Icons.settings),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){

                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Settings",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Icon(Icons.logout),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: TextButton(
                                  onPressed: (){

                                    CacheHelper.deleteData(key: 'token'
                                    ).then((value) {
                                      if(value){
                                        ShopHomeCubit.Get(context).userData=null;
                                        ShopHomeCubit.Get(context).homeModel=null;
                                        ShopHomeCubit.Get(context).data=null;
                                        ShopHomeCubit.Get(context).categoriesModel=null;
                                        ShopHomeCubit.Get(context).cartModel=null;
                                        navigateAndFinish(context, ShopLogInScreen());
                                      }
                                    });

                                    cubit.LogOut();

                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("LogOut",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),



                    ],
                  ),
                )
            );
          },
          fallback: (BuildContext context) {
            return Center(
              child: SpinKitCircle(color: Colors.black,),
            );
          },

        );
      },
      listener: (BuildContext context, ShopStates state) {

        if (state is ShopSuccessLogOutState) {
          if (state.userData.status!) {
            Flushbar(
              padding: EdgeInsets.all(30.0),
              backgroundColor: Colors.green.withOpacity(.5),
              icon: Icon(Icons.check_circle_outline, color: Colors.white,),
              margin: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
              message: '${state.userData.message}',
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(20.0),
              barBlur: 15,
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            )..show(context);
          }
          else{

                Flushbar(
                  padding: EdgeInsets.all(30.0),
                  backgroundColor: Colors.red.withOpacity(.5),
                  icon: Icon(Icons.close_outlined, color: Colors.white,),
                  margin: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
                  message: '${state.userData.message}',
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  borderRadius: BorderRadius.circular(20.0),
                  barBlur: 15,
                  dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                )..show(context);
              }

        }
      },

    );
  }
}
