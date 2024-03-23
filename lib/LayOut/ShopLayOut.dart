
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/Modules/drawer.dart';

import '../Const/Components.dart';
import '../Modules/SearchScreen.dart';
import 'Cubit.dart';
import 'States.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit , ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopHomeCubit.Get(context);
        return Scaffold(
          backgroundColor: MaterialColor(0xFFF5F1E5, {}),

          body:Stack(
              children:[
                cubit.Screens[cubit.currentIndex],
                 Padding(
                   padding: const EdgeInsetsDirectional.only(bottom: 20.0,start: 10.0,end: 10.0),
                   child: Align(
                     alignment: Alignment(0.0,1.0),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(20.0),
                       child: BottomNavigationBar(

                        items: cubit.items,
                        currentIndex: cubit.currentIndex,
                        onTap: (index){
                          cubit.ChangeNavBar(index);
                        },
                ),
                     ),
                   ),
                 ),

              ])
          ,

        );
      },
      listener: (BuildContext context, ShopStates state) {  },

    );
  }
}
