import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';

class UpdatePass extends StatelessWidget {

  var newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit =ShopHomeCubit.Get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Name'),
          ),
          body: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: cubit.isPass,
                decoration: InputDecoration(
                  label: Text('Old password'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  suffixIcon: IconButton( onPressed: () {
                    cubit.ChangePasswordVisibility();
                  }, icon: Icon(cubit.suffix),),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Write your old password";
                  }
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: cubit.isPass,
                decoration: InputDecoration(
                  label: Text('New password'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  suffixIcon: IconButton( onPressed: () {
                    cubit.ChangePasswordVisibility();
                  }, icon: Icon(cubit.suffix),),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Write your new password";
                  }
                },

              ),
              SizedBox(height: 10.0,),

              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: newPass,
                obscureText: cubit.isPass,
                decoration: InputDecoration(
                    label: Text('New password'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                  suffixIcon: IconButton( onPressed: () {
                    cubit.ChangePasswordVisibility();
                  }, icon: Icon(cubit.suffix),),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Write your new password";
                  }
                },

              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: MaterialButton(onPressed: (){

                  cubit.UpdateData(name: cubit.userData!.data!.name!, email: cubit.userData!.data!.email!, phone: cubit.userData!.data!.phone!,password: newPass.text);
                }),
              )
            ],
          ),
        );
      },
      listener: (BuildContext context, ShopStates state) {
        if(state is ShopSuccessUpdateState){
          if(state.userData.status){
            Fluttertoast.showToast(
                msg: state.userData.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            ShopHomeCubit.Get(context).GetUserData();
          }else{
            Fluttertoast.showToast(
                msg: state.userData.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },

    );
  }
}
