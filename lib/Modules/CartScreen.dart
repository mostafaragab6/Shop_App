import 'package:another_flushbar/flushbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopHomeCubit.Get(context);
        return ConditionalBuilder(
          condition: cubit.cartModel != null,
          builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadiusDirectional.circular(15.0)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.circular(10.0),
                                      color: Colors.white
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadiusDirectional.circular(10.0),
                                        child: Image(image: NetworkImage('${cubit.cartModel!.data!.cartItems[index].product!.image}'))),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(top: 8.0,start: 5.0,bottom: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${cubit.cartModel!.data!.cartItems[index].product!.name}'),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Text('${cubit.cartModel!.data!.cartItems[index].product!.price!*cubit.cartModel!.data!.cartItems[index].quantity!}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.blue
                                              ),),
                                              SizedBox(width: 10.0,),
                                              cubit.cartModel!.data!.cartItems[index].product!.discount !=0 ?
                                              Text('${cubit.cartModel!.data!.cartItems[index].product!.old_price}',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                decoration: TextDecoration.lineThrough
                                              ),):
                                              SizedBox(),
                                              Spacer(),
                                              InkWell(
                                                onTap: (){
                                                  ShopHomeCubit.Get(context).SelectFav(cubit.cartModel!.data!.cartItems[index].product!.id!);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.grey[300]!.withOpacity(0.7),
                                                  child: ShopHomeCubit.Get(context).fav[cubit.cartModel!.data!.cartItems[index].product!.id]!?
                                                  Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_outline,color: Colors.grey[600],),
                                                ),
                                              ),
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                      itemCount: cubit.cartModel!.data!.cartItems.length),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 85.0),
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadiusDirectional.circular(20.0)
                    ),
                    child: Center(child: Text('Check Out',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            );
          },
          fallback: (BuildContext context) {
            return Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 300.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/box.png',width: 300,height: 300,),
                    Text('No Products yet!!',style: TextStyle(color: Colors.grey[600]),)
                  ],
                ),
              ),
            );
          },

        );
      },
      listener: (BuildContext context, Object? state) {

        if(state is ShopSuccessSelectFavState){
          if(state.model.status!){

                Flushbar(
                  padding: EdgeInsets.all(30.0),
                  backgroundColor: Colors.green.withOpacity(.5),
                  icon: Icon(Icons.check_circle_outline,color: Colors.white,),
                  margin: EdgeInsets.only(top: 30.0,right: 10.0,left: 10.0),
                  message: '${state.model.message}',
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  borderRadius: BorderRadius.circular(20.0),
                  barBlur: 15,
                  dismissDirection:FlushbarDismissDirection.HORIZONTAL ,
                )..show(context);
              }
            }
        if(state is ShopErrorSelectFavState){

          Flushbar(
            padding: EdgeInsets.all(30.0),
            backgroundColor: Colors.red.withOpacity(.5),
            icon: Icon(Icons.close_rounded,color: Colors.white,),
            margin: EdgeInsets.only(top: 30.0,right: 10.0,left: 10.0),
            message: '${state.error}',
            duration: Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(20.0),
            barBlur: 15,
            dismissDirection:FlushbarDismissDirection.HORIZONTAL ,
          )..show(context);
        }
      },

    );
  }
}
