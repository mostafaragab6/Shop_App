import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/States.dart';

class UpdateName extends StatelessWidget {

  var FnameController = TextEditingController();
  var LnameController = TextEditingController();
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
                keyboardType: TextInputType.text,
                controller: FnameController,
                decoration: InputDecoration(
                    label: Text('First Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Write your first name";
                  }
                },

              ),
              SizedBox(height: 10.0,),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: LnameController,
                decoration: InputDecoration(
                    label: Text('Last Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Write your Last name";
                  }
                },

              ),
              SizedBox(height: 10.0,),

              Container(
                width: double.infinity,
                height: 50.0,
                color: Colors.blueGrey,
                child: MaterialButton(onPressed: (){
                  String fullName=FnameController.text+LnameController.text;
                  cubit.UpdateData(name: fullName, email: cubit.userData!.data!.email!, phone: cubit.userData!.data!.phone!);
                },
                child: Text('Edit'),),
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
