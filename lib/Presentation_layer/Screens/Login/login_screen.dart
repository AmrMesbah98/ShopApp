import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Presentation_layer/Screens/Login/cubit/cubit.dart';
import 'package:shopapp/Presentation_layer/Screens/Login/cubit/state.dart';
import 'package:shopapp/Presentation_layer/Screens/Register/register_screen.dart';
import 'package:shopapp/Shared_Prefrence/Sheared_Prefrence.dart';

import '../homeLayout/home_Layout.dart';

class ShopLogin extends StatelessWidget {
  ShopLogin({Key? key}) : super(key: key);

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          listener: (context, state) => {
            if (state is ShopLoginSuccessState)
              {
                if (state.shopLoginModel.status == true)
                  {
                    print(state.shopLoginModel.data!.token),
                    print(state.shopLoginModel.message),
                    Fluttertoast.showToast(
                        msg: state.shopLoginModel.message,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    ),

                    CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token  ).then((value) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) {
                          return const ShopLayout();
                        }),
                            (Route<dynamic> route) => false,
                      );
                    })


                  }
                else
                  {
                    print(state.shopLoginModel.message),
                    Fluttertoast.showToast(
                        msg: state.shopLoginModel.message,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
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
                            'Login',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            style: TextStyle(fontSize: 25),
                            controller: EmailController,
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
                          const SizedBox(height: 15),
                          TextFormField(
                            obscureText: ShopLoginCubit.get(context).isPassword,
                            onChanged: (value) {
                              if (_key.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                );
                              }
                            },
                            style: TextStyle(fontSize: 25),
                            controller: PasswordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  ShopLoginCubit.get(context)
                                      .changePasswordVisibaility();
                                },
                                icon: Icon(ShopLoginCubit.get(context).suffix),
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
                            condition: state is! ShopLoginLoadingState,
                            // true statement
                            builder: (context) => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            fallback: (context) => Center(
                                child:
                                    const CircularProgressIndicator()), // false statement
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 17),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return ShopRegisterScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
