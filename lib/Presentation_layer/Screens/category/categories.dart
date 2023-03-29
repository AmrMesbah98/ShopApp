import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Data_layer/Models/Shop_app_Category_model.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/Cubit.dart';
import 'package:shopapp/busssines_logic_layer/Cubit/states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
              ShopCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => Divider(
            thickness: 2.0,
            color: Colors.black,
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${dataModel.image}'),
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${dataModel.name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
