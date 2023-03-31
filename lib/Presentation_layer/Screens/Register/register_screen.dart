import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

import '../../../Shared_Prefrence/Sheared_Prefrence.dart';
import '../Login/cubit/cubit.dart';
import '../Login/cubit/state.dart';
import '../homeLayout/home_Layout.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.registerModel.status == true) {
            print(state.registerModel.data!.token);
            print(state.registerModel.message);
            Fluttertoast.showToast(
                msg: state.registerModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);

            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.data!.token)
                .then((value) {
              print(state.registerModel.data!.token);

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) {
                  return const ShopLayout();
                }),
                (Route<dynamic> route) => false,
              );
            });
          } else {
            print(state.registerModel.message);
            Fluttertoast.showToast(
                msg: state.registerModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: TextStyle(fontSize: 25),
                        controller: nameController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person), hintText: 'Name'),
                        keyboardType: TextInputType.name,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'Please Enter Your Name ';
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(fontSize: 25),
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'phone',
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'phone is to Short';
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(fontSize: 25),
                        controller: emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Email Adress'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'Please Enter Your Email Address';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: ShopCubit.get(context).isPassword,
                        style: TextStyle(fontSize: 25),
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changePasswordVisibaility();
                            },
                            icon: Icon(ShopCubit.get(context).suffix),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: 'Password',
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'Password is to Short';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        // true statement
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                ShopCubit.get(context).userRegister(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  phoneController.text,
                                );
                              }
                            },
                            child: const Text(
                              'register',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        fallback: (context) => Center(
                            child:
                                const CircularProgressIndicator()), // false statement
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
