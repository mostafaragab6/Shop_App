import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              fallback: (context) => Center(child: CircularProgressIndicator()));
        }
        ,
        listener: (context, state) {
          if(state is ShopSuccessSelectFavState){
            if(!state.model.status!){
              print(state.model.message!);
              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          }
        }
    );


  }
  Widget BuilderWidget (HomeModel model, CategoriesModel Cmodel,context)=>
  Padding(
    padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0,top: 45.0),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [

          CarouselSlider(
            items: List.generate(
                model.data!.banners.length, (index) =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(
                      '${model.data!.banners[index].image}',),
                    width: double.infinity,
                    fit: BoxFit.cover,),
                )
            ),
            options:  CarouselOptions(
                height: 180.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.decelerate,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: Duration(seconds: 1)
            ),),
          SizedBox(height: 30.0,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 60.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                      onPressed: (){},
                    child: Text("All",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                    ),),

                  ),
                ),
                SizedBox(width: 5.0,),
                Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text("Electronics",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),),

                  ),
                ),
                SizedBox(width: 5.0,),
                Container(
                  width: 85.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text("Sports",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),),

                  ),
                ),
                SizedBox(width: 5.0,),
                Container(
                  width: 100.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text("Clothes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),),

                  ),
                ),
                SizedBox(width: 5.0,),
                Container(
                  width: 110.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text("Lighting",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),),

                  ),
                ),
              ],
            ),
          ),

          GridView.count(
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
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child:
                        ClipRRect(
                          
                          borderRadius: BorderRadius.circular(10.0),
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
                          child: InkWell(
                            onTap: (){
                              ShopHomeCubit.Get(context).SelectFav(model.data!.products[index].id!);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300]!.withOpacity(0.7),
                              child: ShopHomeCubit.Get(context).fav[model.data!.products[index].id]!?
                              Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_outline,color: Colors.grey[600],),
                            ),
                          ),
                        ),
                      ),

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

                        ),maxLines: 1,
                        overflow: TextOverflow.ellipsis,),
                      SizedBox(width: 8.0,),
                      Text("${model.data!.products[index].old_price} \$",
                        style: TextStyle(
                          color: Colors.grey[700],
                          decoration: TextDecoration.lineThrough
                        ),maxLines: 1,
                        overflow: TextOverflow.ellipsis,

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
  )
  ;
}
// Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Stack(
//     alignment: Alignment.bottomLeft,
//     children: [
//     Image(image: NetworkImage(model.data!.products[index].image!),
//     width: double.infinity,
//     height: 200.0,
//
//     ),
//     if(model.data!.products[index].discount!=0)
//     Container(BoxDecoration(
// //     color: Colors.red,
// //     ),
// //     child: Padding(
// //     padding: const EdgeInsetsDirectional.symmetric(horizontal: 6.0),
// //     child: Text('DISCOUNT',style: TextStyle(color: Colors.white),),
// //     ),
// //     ),
// //     ],
// //     ),
// //     SizedBox(height: 8.0,),
// //     Text('${model.data!.products[index].name}',
// //     maxLines: 2,
// //     overflow: TextOverflow.ellipsis,
// //     ),
// //     SizedBox(height: 8.0,),
// //     Row(
// //     children: [
// //     Text('${model.data!.products[index].price}',
// //     maxLines: 1,
// //     overflow: TextOverflow.ellipsis,
// //     style: TextStyle(
// //     color: Colors.blue
// //     ),
// //     ),
// //     SizedBox(width: 8.0,),
// //     if(model.data!.products[index].discount!=0)
// //     Text('${model.data!.products[index].old_price}',
// //     maxLines: 1,
// //     overflow: TextOverflow.ellipsis,
// //     style: TextStyle(
// //     color: Colors.grey[500],
// //     decoration: TextDecoration.lineThrough
// //
// //     ),
// //
// //     ),
// //     Spacer(),
// //     IconButton(onPressed: (){
// //     ShopHomeCubit.Get(context).SelectFav(ShopHomeCubit.Get(context).homeModel!.data!.products[index].id!);
// //     },
// //     icon: ShopHomeCubit.Get(context).fav[model.data!.products[index].id]!
// //     ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_outline),
// //     padding: EdgeInsets.zero,
// //     )
// //     ],
// //     ),
// //     ],
// //     ),
// // ),
//     decoration: