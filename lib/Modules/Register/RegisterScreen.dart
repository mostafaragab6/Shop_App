
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_project/LayOut/Cubit.dart';
import 'package:shop_project/LayOut/ShopLayOut.dart';
import 'package:shop_project/LayOut/States.dart';

import '../../Const/Components.dart';
import '../../Shared/Network/CasheHelper.dart';
import '../Login/LoginScreen.dart';
import 'RegisterCubit/cubit.dart';
import 'RegisterCubit/states.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPass = true;

  IconData icon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        builder: (BuildContext context,  state) {
          return Scaffold(

            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          //height: 899.3,
                          color: Colors.black,
                          child: Image(image: AssetImage(
                            "images/desktop-wallpaper-aesthetic-green-green.jpg",),
                              fit: BoxFit.cover
                          )
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 55.0, vertical: 130.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          width: 300.0,
                          height: 650.0,
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 15.0, end: 15.0, top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Register",
                                    style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[700]
                                    ),), SizedBox(height: 15.0,),
                                  defaultForm(controller: nameController,
                                      prefix: Icons.person,
                                      type: TextInputType.text,
                                      label: "First Name",
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "PLease enter your first name";
                                        }
                                      }
                                  ),
                                  SizedBox(height: 15.0,),
                                  defaultForm(controller: emailController,
                                      prefix: Icons.email_outlined,
                                      type: TextInputType.emailAddress,
                                      label: "Email Address",
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "PLease enter your email";
                                        }
                                      }
                                  ), SizedBox(height: 15.0,),
                                  defaultForm(controller: passController,
                                      prefix: Icons.lock,
                                      type: TextInputType.visiblePassword,
                                      label: "Password",
                                      isPassword: isPass,
                                      suffix:
                                      isPass ? icon = Icons.visibility_off : icon =
                                          Icons.visibility,
                                      onClick: () {
                                        setState(() {
                                          isPass = !isPass;
                                        });
                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "PLease enter your password";
                                        }
                                      }
                                  ), SizedBox(height: 15.0,),
                                  defaultForm(controller: phoneController,
                                      prefix: Icons.phone,
                                      type: TextInputType.phone,
                                      label: "Phone",
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "PLease enter your phone number";
                                        }
                                      }
                                  ),
                                  SizedBox(height: 20.0,),
                                  ConditionalBuilder(
                                    condition: state is! ShopRegisterLoadingState,
                                    builder: (BuildContext context) =>  defaultButton(
                                        text: 'REGISTER',
                                        function: ()
                                        {
                                          if(formKey.currentState!.validate()){
                                            ShopRegisterCubit.get(context).RegisterData(
                                                email: emailController.text,
                                                password: passController.text,
                                                name: nameController.text,
                                                phone: phoneController.text);
                                          }

                                        },
                                        color: Colors.teal),
                                    fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }, listener: (BuildContext context, ShopRegisterStates state) {
        if(state is ShopRegisterSuccessState){
          if(state.registerModel.status!){
            print(state.registerModel.message);
            print(state.registerModel.Info!.token);

            CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.Info!.token).then((value) {

                  token=state.registerModel.Info!.token;

                  navigateAndFinish (context , ShopLayout());
            });


          }
        }
      },

      ),
    );
  }


    }

