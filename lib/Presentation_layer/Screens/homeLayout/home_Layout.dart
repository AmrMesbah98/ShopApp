import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Presentation_layer/Screens/search/search.dart';
import 'package:shopapp/Shared_Prefrence/Sheared_Prefrence.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

import '../Login/login_screen.dart';
import '../Register/register_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var Cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return SearchScreen();
                  }));
                }, icon: Icon(Icons.search,)),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    return ShopRegisterScreen();
                  }));
                }, icon: Icon(Icons.new_label))
              ],
              title: const Text('salla'),
            ),
            body: Cubit.bottomScreens[Cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              items: const[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ],
              currentIndex: Cubit.currentindex,
              onTap: (index) {
                Cubit.changeBottom(index);
              },
            ),
          );
        },
    );
  }
}

/*
                  CacheHelper.removeData(key: 'token').then((value) {
                    if (value) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) {
                          return ShopLogin();
                        }),
                        (Route<dynamic> route) => false,
                      );
                    }
                  });
 */
