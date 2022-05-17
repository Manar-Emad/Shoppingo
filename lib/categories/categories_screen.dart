import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shop_cubit/shop_cubit.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ListView.separated(itemBuilder: (context, index) =>buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index]) ,
        separatorBuilder: (context,index)=>myDivider(), itemCount: ShopCubit.get(context).categoriesModel.data.data.length);
  },
);
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),height: 100,width: 100,fit: BoxFit.cover,),
        SizedBox(width: 20,),
        Text(model.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  ) ;
}

