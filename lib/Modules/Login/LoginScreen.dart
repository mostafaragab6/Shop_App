import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import '../../Const/Components.dart';
import '../../LayOut/ShopLayOut.dart';
import '../../Shared/Network/CasheHelper.dart';
import 'LoginCubit/Cubit.dart';
import 'LoginCubit/States.dart';

class ShopLogInScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passController = TextEditingController();

  bool isPass= false;
  IconData icon = Icons.visibility_off_outlined;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        builder: (BuildContext context, ShopLoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15.0,),
                      Text('Login now to prowse our new offers',style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),),
                      SizedBox(height: 60.0,),
                      defaultForm(
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          label: "email address",
                          validate: (value){
                            if(value!.isEmpty){
                              return 'you must enter your email address ';
                            }
                          }),
                      SizedBox(height: 15.0,),
                      defaultForm(
                          controller: passController,
                          prefix: Icons.lock,
                          isPassword: ShopLoginCubit.get(context).isPass,
                          type: TextInputType.visiblePassword,
                          label: "email address",
                          validate: (value){
                            if(value!.isEmpty){
                              return 'you must enter your password ';
                            }
                          },
                          suffix: ShopLoginCubit.get(context).suffix,
                          onClick: (){
                            ShopLoginCubit.get(context).ChangePasswordVisibility();
                          }
                      ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginInLoadingState,
                        builder: (BuildContext context) =>  defaultButton(
                            text: 'LOGIN',
                            function: ()
                            {
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).UserData(
                                    email: emailController.value.text,
                                    password: passController.value.text);

                              }

                            },
                            color: Colors.teal),
                        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),

                      ),
                      SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not have an account?'),
                          TextButton(onPressed: (){}, child: Text("REGISTER"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, ShopLoginStates state) {
          if(state is ShopLoginInSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              print(state.loginModel.data!.name);

              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token;
                print('iam here');
                print(token);
                ShopHomeCubit.Get(context).GetUserData();
                ShopHomeCubit.Get(context).getCategoriesData();
                ShopHomeCubit.Get(context).getHomeData();
                ShopHomeCubit.Get(context).GetFav();
                navigateAndFinish (context , ShopLayout());
              });


            }else {
              print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
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

      ),
    );
  }
}
