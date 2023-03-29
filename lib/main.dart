import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Constant/Themes.dart';
import 'package:shopapp/Presentation_layer/Screens/Onboarding/on_boarding_screen.dart';
import 'package:shopapp/helper/dio_helper.dart';

import 'Constant/bloc_observer.dart';
import 'Presentation_layer/Screens/Login/login_screen.dart';
import 'Presentation_layer/Screens/homeLayout/home_Layout.dart';
import 'Shared_Prefrence/Sheared_Prefrence.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelpper.init();
  bool? onBoarding =await CacheHelper.getData('OnBoarding');
  String? token = await CacheHelper.getData('token');
  print(onBoarding);

  Widget? widget;

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else ShopLogin();
  }else
  {
    widget = OnBoardingScreen();
  }


  runApp(ShopApp(startWidget: widget!,));
}

class ShopApp extends StatelessWidget {

  final Widget startWidget;


  const ShopApp({super.key, required this.startWidget});





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: startWidget
    );
  }
}


// String? token = CacheHelper.getData('token');

/*
  Widget? widget;

  if(onBoarding != null)
    {
      if(token != null) widget = ShopLayout();
      else ShopLogin();
    }else
      {
        widget = OnBoardingScreen();
      }
 */


// final Widget startWidget;