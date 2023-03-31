import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

import '../../../Data_layer/Models/favouriteModel.dart';
import '../../../Data_layer/Models/searchModel.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFAVItem(ShopCubit.get(context)
                .favouriteModel!
                .data!
                .data![index]
                .product!),
            separatorBuilder: (context, index) => Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            itemCount:
                ShopCubit.get(context).favouriteModel!.data!.data!.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFAVItem(model) {
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
                        if (1 != 0)
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
