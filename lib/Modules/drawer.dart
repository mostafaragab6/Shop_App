import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/Const/Components.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';
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
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey
                      ),
                      accountName: Text('${cubit.userData!.data!.name}'),
                      accountEmail: Text('${cubit.userData!.data!.email}'),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Image(image: AssetImage('images/118364.jpg'),width:150.0,fit: BoxFit.cover,),
                        ),
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
                                      navigateAndFinish(context, ShopLogInScreen());
                                    }
                                  });

                                  cubit.LogOut();

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("LogOut",
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
                          Icon(Icons.security_update),
                          SizedBox(width: 10.0,),
                          Expanded(
                            child: TextButton(
                                onPressed: (){

                                  navigatTo(context, UpdateScreen());

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Update",
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            );
          },
          fallback: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },

        );
      },
      listener: (BuildContext context, ShopStates state) {  },

    );
  }
}
