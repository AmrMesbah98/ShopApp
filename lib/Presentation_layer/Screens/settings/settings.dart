import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

import '../../../Shared_Prefrence/Sheared_Prefrence.dart';
import '../../../busssines_logic_layer/Cubit/Cubit.dart';
import '../Login/cubit/cubit.dart';
import '../Login/cubit/state.dart';
import '../Login/login_screen.dart';

class SettingsScreen extends StatelessWidget {


  TextEditingController nameController = TextEditingController();
  TextEditingController emilController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  GlobalKey<FormState> _key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state)  {
        var model =  ShopCubit.get(context).usermodel;

        nameController.text = model!.data!.name!;
        emilController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).usermodel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  if(state is ShopUpdateUserLoadingState )
                    LinearProgressIndicator(),
                  SizedBox(height: 10),

                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return 'Name must be not empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    validator: (String? email) {
                      if (email!.isEmpty) {
                        return 'Email must be not empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emilController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Phone',
                      prefixIcon: Icon(Icons.phone_android),
                      hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    validator: (String? Phone) {
                      if (Phone!.isEmpty) {
                        return 'Phone must be not empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepOrange)
                          ),
                          onPressed: () {
                            if(_key.currentState!.validate()){
                              ShopCubit.get(context).updateUserModel(
                                nameController.text,
                                emilController.text,
                                phoneController.text,
                              );
                            }

                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 17),
                          ),
                        )

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrange)
                        ),
                          onPressed: () {
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
                          },
                          child: const Text(
                            'LOGOUT',style: TextStyle(fontSize: 17),
                          )),
                    ),
                  ),



                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

/*

BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).getUserModel() != null,
          builder: (context)=>  Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  validator: (String? name) {
                    if (name!.isEmpty) {
                      return 'Name must be not empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  validator: (String? email) {
                    if (email!.isEmpty) {
                      return 'Email must be not empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: emilController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                    prefixIcon: Icon(Icons.phone_android),
                    hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  validator: (String? Phone) {
                    if (Phone!.isEmpty) {
                      return 'Phone must be not empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                ),
              ],
            ),
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator(),) ,
        );
      },
    );
 */
