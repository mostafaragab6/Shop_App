
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_project/Const/Components.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';
import 'package:shop_project/Modules/Update_Screens/Update_Name.dart';
import 'package:shop_project/Modules/Update_Screens/Update_Password.dart';

class UpdateScreen extends StatefulWidget {

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  File? selectedImage;

  Future PickedImage() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if( returnedImage != null){
        selectedImage = File(returnedImage.path);
      }
      else {
        print('No Image');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit=ShopHomeCubit.Get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("UPDATE"),
          ),
          body: Column(
            children: [

              Stack(
                children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundImage:NetworkImage('${cubit.userData!.data!.image}') ,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: IconButton(
                        onPressed: (){
                          PickedImage();
                        },
                        icon: Icon(Icons.add_a_photo_outlined)),
                  )
                ],
              ),

              SizedBox(height: 10.0,),
              TextButton(onPressed: (){
                navigatTo(context, UpdateName());
              }, child: Text("Edit name")),
              SizedBox(height: 10.0,),
              TextButton(onPressed: (){
                navigatTo(context, UpdatePass());
              }, child: Text("Edit password")),
            ],
          ),
        );
      },
      listener: (BuildContext context, ShopStates state) {  },

    );
  }
}
