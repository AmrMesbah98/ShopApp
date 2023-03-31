import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

import '../../../Data_layer/Models/searchModel.dart';

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
                      onChanged: (String text) {
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

                    SizedBox(height: 20),
                    Expanded(child: ListView.separated(
                      itemBuilder: (context, index) =>
                          buildSearchItem( ShopCubit.get(context).searchModel!.data!.pro![index] ),
                      separatorBuilder: (context, index) =>
                          Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                      itemCount: 20,
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }


  Widget buildSearchItem( prouduct model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                ),

                  Container(
                    color: Colors.red,
                    child: Text(
                      '${model.discount}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        SizedBox(width: 5),

                          Text(
                            '${model.oldPrice}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              //ShopCubit.get(context).changeFavourite(products.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: true ? Colors.blue : Colors.grey,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


