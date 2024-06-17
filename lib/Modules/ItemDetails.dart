import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Model/SearchModel.dart';

class ItemDetails extends StatelessWidget {

  ProdData Data;
  var pageController = PageController();
  ItemDetails({required this.Data});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, state) {
        var cubit= ShopHomeCubit.Get(context);

        return Scaffold(
          backgroundColor: MaterialColor(0xFFF5F1E5, {}),

          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }
                , icon: Icon(Icons.arrow_back_ios_new)),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70.0,
                          child: Image(image: NetworkImage('${Data.image}'),width: 100.0,height: 100.0)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${Data.name}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400
                                ),),
                              SizedBox(height: 20.0,),
                              Text('\$${Data.price}.00',style: TextStyle(color: Colors.blue),),
                              SizedBox(height:10.0,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      cubit.AddCartData(Data.id!);
                                      print(cubit.cart[Data.id!]);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:cubit.cart[Data.id!]!? Colors.green.withOpacity(0.4):Colors.grey[300]!.withOpacity(0.7),
                                      child: Image.asset('icons/shopping-bag (1).png',width: 25.0,height: 25.0,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  InkWell(
                                    onTap: (){
                                      cubit.SelectFav(Data.id!);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300]!.withOpacity(0.7),
                                      child: cubit.fav[Data.id]!?
                                      Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_outline,color: Colors.grey[600],),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),

                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Text('Model Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0
                    ),),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(15.0)
                    ),
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemBuilder:(context , index)=> ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(8.0),
                          child: Image(image: NetworkImage('${Data.images[index]}',))),
                      itemCount: Data.images.length,
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: Data.images.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Colors.teal,
                        dotColor: Colors.grey,
                        expansionFactor: 3,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 6
                    ),
                  ),
                ),

                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Text('Description:',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17.0
                    ),),
                ),



                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 30.0,top:12.0 ,end: 12.0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10.0),
                              color: Colors.black54
                          ),
                          child: Text('${Data.description}',style: TextStyle(color: Colors.grey[600]),)),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0,top: 20.0,end: 20.0),
                      child: Container(
                        width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10.0),
                              color: Colors.grey[300]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('${Data.description}'),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),


              ],
            ),
          ),

        );
      }, 
      listener: (BuildContext context, Object? state) {
        if (state is ShopSuccessAddCartState) {
          if (state.cartData.status!) {
            Flushbar(
              padding: EdgeInsets.all(30.0),
              backgroundColor: Colors.green.withOpacity(.5),
              icon: Icon(Icons.check_circle_outline, color: Colors.white,),
              margin: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
              message: '${state.cartData.message}',
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(20.0),
              barBlur: 15,
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            )..show(context);
          }
        }
        if (state is ShopErrorAddCartState) {
          Flushbar(
            padding: EdgeInsets.all(30.0),
            backgroundColor: Colors.red.withOpacity(.5),
            icon: Icon(Icons.close_rounded, color: Colors.white,),
            margin: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
            message: '${state.error}',
            duration: Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(20.0),
            barBlur: 15,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          )
            ..show(context);
        }

        if (state is ShopSuccessSelectFavState) {
          if (state.model.status!) {
            Flushbar(
              padding: EdgeInsets.all(30.0),
              backgroundColor: Colors.green.withOpacity(.5),
              icon: Icon(Icons.check_circle_outline, color: Colors.white,),
              margin: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
              message: '${state.model.message}',
              duration: Duration(seconds: 3),
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(20.0),
              barBlur: 15,
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
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
