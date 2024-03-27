import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/Const/Components.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';

class Search1Screen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, state) { 
        var cubit = ShopHomeCubit.Get(context);
        return Scaffold(

          body: SafeArea(
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      prefixIcon: Icon(Icons.search),

                      label: Text('Search')

                  ),

                  onFieldSubmitted: (value){
                    cubit.getSearchData(searchController.text);
                  },
                  // onChanged: (value){
                  //   cubit.getSearchData(value.toString());
                  // },
                )
                
                //Text('${cubit.searchModel!.data!.prodData![0].name}')
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {  },
      
    );
  }
}
