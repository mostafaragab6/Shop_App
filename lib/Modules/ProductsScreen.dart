import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../LayOut/Cubit.dart';
import '../LayOut/States.dart';
import '../Model/CategoriesModel.dart';
import '../Model/HomeModel.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
        builder: (context, state) {
          var cubit = ShopHomeCubit.Get(context);
          return ConditionalBuilder(
              condition:cubit.homeModel != null && cubit.categoriesModel != null,
              builder:(context) {
                return BuilderWidget(cubit.homeModel!, cubit.categoriesModel!,context);
              } ,
              fallback: (context) => Center(child: SpinKitCircle(color: Colors.black,)));
        }
        ,
        listener: (context, state) {
          if(state is ShopSuccessAddCartState){
            if(state.cartData.status!){
              Flushbar(
                padding: EdgeInsets.all(30.0),
                backgroundColor: Colors.green.withOpacity(.5),
                icon: Icon(Icons.check_circle_outline,color: Colors.white,),
                margin: EdgeInsets.only(top: 30.0,right: 10.0,left: 10.0),
                message: '${state.cartData.message}',
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                borderRadius: BorderRadius.circular(20.0),
                barBlur: 15,
                dismissDirection:FlushbarDismissDirection.HORIZONTAL ,
              )..show(context);
            }
          }
          if(state is ShopErrorAddCartState){

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

        }
    );


  }
  Widget BuilderWidget (HomeModel model, CategoriesModel Cmodel,context)=>
  Padding(
    padding: const EdgeInsetsDirectional.only(top: 20.0),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CarouselSlider(
            items: List.generate(
                model.data!.banners.length, (index) =>
                ClipRRect(

                  child: Image(
                    image: NetworkImage(
                      '${model.data!.banners[index].image}',),
                    width: double.infinity,
                    fit: BoxFit.cover,),
                )
            ),
            options:  CarouselOptions(

                height: 230.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.decelerate,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: Duration(seconds: 1)
            ),),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Products',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w400
            ),),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              childAspectRatio: 1.6/2.7,
              children: List.generate(model.data!.products.length, (index) =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 230.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child:
                          ClipRRect(

                            borderRadius: BorderRadius.circular(5.0),
                            child: FittedBox(
                              child: Image(

                                image: NetworkImage(
                                    '${model.data!.products[index].image}'),
                                width: 50.0,
                                height: 50.0,

                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 5.0,end: 5.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    ShopHomeCubit.Get(context).SelectFav(model.data!.products[index].id!);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300]!.withOpacity(0.7),
                                    child: ShopHomeCubit.Get(context).fav[model.data!.products[index].id]!?
                                    Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_outline,color: Colors.grey[600],),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                InkWell(
                                  onTap:(){
                                    ShopHomeCubit.Get(context).AddCartData(model.data!.products[index].id!);
                                    print(ShopHomeCubit.Get(context).cart[model.data!.products[index].id!]);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:ShopHomeCubit.Get(context).cart[model.data!.products[index].id!]!?
                                    Colors.green.withOpacity(0.4):Colors.grey[300]!.withOpacity(0.7),
                                    child: Image.asset('icons/shopping-bag (1).png',width: 25.0,height: 25.0,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                       model.data!.products[index].discount!=0? Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(5.0))
                            ),
                            width: 80.0,
                            height: 20.0,
                            child: Center(child: Text('DISCOUNT',style: TextStyle(color: Colors.white),)),
                          ),
                        ):SizedBox(),

                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Text("${model.data!.products[index].name}",
                    style: TextStyle(

                    ),maxLines: 1,
                    overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5.0,),
                    Row(
                      children: [
                        Text("${model.data!.products[index].price} \$",
                          style: TextStyle(
                            color: Colors.blue
                          ),maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                        SizedBox(width: 8.0,),
                       model.data!.products[index].discount!=0? Text("${model.data!.products[index].old_price} \$",
                          style: TextStyle(
                            color: Colors.grey[700],
                            decoration: TextDecoration.lineThrough
                          ),maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                        ):SizedBox(),
                      ],
                    ),

                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    ),
  )
  ;
}
