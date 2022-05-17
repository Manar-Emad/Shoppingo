import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shop_cubit/shop_cubit.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(itemBuilder: (context, index) => buildFavItem() ,
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: 10 ,
        );
      },
    );
  }
  Widget buildFavItem()=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              const Image(
                image: NetworkImage('https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
              if (1 != 0)
                Container(
                  color: Colors.red,
                  padding:const  EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child:const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const  Text(
                  'Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    const   Text(
                      '2000',
                      style: TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    const  SizedBox(
                      width: 5,
                    ),
                    if (1 != 0)
                      const Text(
                        '2000',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      //  padding: EdgeInsets.zero,
                      onPressed: () {
                        // ShopCubit.get(context).changeFavorites(model.id);
                        //  print(model.id);
                      },
                      icon:const CircleAvatar(

                          backgroundColor: true ? defaultColor: Colors.grey ,
                          radius: 15.0,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

