import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_project/Const/Components.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';

import 'ItemDetails.dart';

class Search1Screen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, state) { 
        var cubit = ShopHomeCubit.Get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              cubit.searchModel =null;
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new)),
          ),
          backgroundColor: MaterialColor(0xFFF5F1E5, {}),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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

                  ),

                  SizedBox(height: 15.0,),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.searchModel != null,
                      builder: (BuildContext context) {
                        return  ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                  width:double.infinity,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(15.0),
                                    color: Colors.grey[200]
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadiusDirectional.circular(20.0),
                                            child: Image(image: NetworkImage('${cubit.searchModel!.data!.prodData[index].image}'))),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[
                                              Text('${cubit.searchModel!.data!.prodData[index].name}',
                                             maxLines: 2,
                                              overflow: TextOverflow.ellipsis,),
                                              SizedBox(height: 20.0,),
                                              Text('\$${cubit.searchModel!.data!.prodData[index].price}',style: TextStyle(color: Colors.blue),),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: (){
                                                      navigatTo(context, ItemDetails(Data: cubit.searchModel!.data!.prodData[index],));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text('More'),
                                                        Icon(Icons.arrow_forward)
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  )) ;
                            },
                            separatorBuilder: (context,index){
                              return SizedBox(height: 10.0,);
                            },
                            itemCount: cubit.searchModel!.data!.prodData.length);
                      },
                      fallback: (BuildContext context) {
                        return SpinKitCircle(color: Colors.black,);
                      },

                    ),
                  )
                  //Text('${cubit.searchModel!.data!.prodData![0].name}')
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {  },
      
    );
  }
}
