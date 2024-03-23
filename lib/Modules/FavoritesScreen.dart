import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';
import 'package:shop_project/Model/FavouritesGetModel.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopHomeCubit.Get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel !=null && state is! ShopLoadingGetFavoritesDataState,
          builder: (BuildContext context) {
            return ListView.separated(
                itemBuilder: (context , index){

                  return itemFavBuilder(cubit.data!,index,context);
                },
                separatorBuilder: (context , index)=> Padding(
                  padding: const EdgeInsetsDirectional.only(start:15.0,end: 15.0,top: 5.0,bottom: 5.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount:cubit.data!.data!.Pdata.length );
          },
          fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },

        );
      },
      listener: (BuildContext context, ShopStates state) {  },

    );
  }
}

Widget itemFavBuilder(favData data , int index,context)=>
    Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    height: 120.0,

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(image: NetworkImage("${data.data!.Pdata[index].product!.image}"),
              width: 120.0,
              height: 120.0,

            ),
            if(data.data!.Pdata[index].product!.discount != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 6.0),
                  child: Text('DISCOUNT',style: TextStyle(color: Colors.white),),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.0,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data.data!.Pdata[index].product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                ),
                SizedBox(height: 8.0,),
                Spacer(),
                Row(
                  children: [
                    Text('${data.data!.Pdata[index].product!.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    if(1!=0)
                      Text('${data.data!.Pdata[index].product!.old_price}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough

                        ),

                      ),
                    Spacer(),
                    IconButton(onPressed: (){
                      ShopHomeCubit.Get(context).SelectFav(data.data!.Pdata[index].product!.id!);
                    },
                      icon: ShopHomeCubit.Get(context).fav[data.data!.Pdata[index].product!.id]!
                       ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_outline),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),

              ],
            ),
          ),
        ),

      ],
    ),
  ),
);