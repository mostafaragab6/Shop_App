import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_project/LayOut/States.dart';
import 'package:shop_project/Modules/Profile.dart';
import 'Const/Components.dart';
import 'LayOut/Cubit.dart';
import 'LayOut/ShopLayOut.dart';
import 'Modules/Login/LoginScreen.dart';
import 'Modules/OnBoardingScreen.dart';
import 'Modules/SearchScreen.dart';
import 'Modules/Shapes.dart';
import 'Shared/Network/CasheHelper.dart';
import 'Shared/Network/DioHelper.dart';
void main()async {


  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.GetData(key:'OnBoarding');
  token = CacheHelper.GetData(key:'token');

  print(onBoarding);
  print(token);


  Widget? widget;

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = ShopLogInScreen();
  }
  else{
    widget = OnBoardingScreen();
  }


  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({ required this.startWidget});

  @override
  Widget build(BuildContext context) {

    return
      MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (BuildContext context) =>ShopHomeCubit()..getHomeData()..getCategoriesData()..GetFav()..GetUserData()..getCartData(),
          ),
        ],

        child: BlocConsumer<ShopHomeCubit , ShopStates>(
          builder: (

              BuildContext context, ShopStates state) => MaterialApp(

              theme: ThemeData(
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),

                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                  ),

                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.teal[700]
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(


                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: MaterialColor(0xFFF5F1E5, {}),
                        statusBarIconBrightness: Brightness.dark
                    ),
                    backgroundColor: MaterialColor(0xFFF5F1E5, {}),
                    titleTextStyle: TextStyle(color: Colors.black ,fontSize: 45.0),
                    //titleSpacing: 25.0
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.grey[400]
                  )
              ),


              themeMode:  ThemeMode.light ,
              debugShowCheckedModeBanner: false,
                home: ShopLayout()
                // token !=null? ShopLayout():ShopLogInScreen()
          ),
          listener: (BuildContext context, ShopStates state) {  },

        ),

      );



  }

}