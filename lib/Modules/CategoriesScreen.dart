
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../LayOut/Cubit.dart';
import '../LayOut/States.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit , ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopHomeCubit.Get(context);
        return ListView.separated(
            itemBuilder: (context, index)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image(image: NetworkImage('${cubit.categoriesModel!.data!.data[index].image}'),
                    width: 80.0,
                    height: 80.0,),
                  Text('${cubit.categoriesModel!.data!.data[index].name}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_sharp)
                ],
              ),
            ),
            separatorBuilder: (context, index)=>SizedBox(height: 8.0,),
            itemCount: cubit.categoriesModel!.data!.data.length
        );
      },
      listener: (BuildContext context, ShopStates state) {  },

    );
  }
}
