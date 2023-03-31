import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: SearchController,
                      onChanged: (String text){
                        ShopCubit.get(context).search(text);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          )),
                    ),

                    const SizedBox(height: 10),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
