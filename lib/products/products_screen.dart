import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shop_cubit/shop_cubit.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if(state is ShopSuccessChangesFavoritesState){
            if(!state.model.status){
              showToast(text: state.model.message, state: ToastStates.ERROR);
            }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel !=null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel , ShopCubit.get(context).categoriesModel , context ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel model, CategoriesModel categoriesModel , context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 20,
          ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text(
                  'Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),
                ),
               const SizedBox(
                 height: 20,
               ),
               Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data.length[index]),
                    separatorBuilder: (context, index) =>SizedBox(width: 10,),
                    itemCount: categoriesModel.data.data.length),
        ),
               const SizedBox(
                 height: 20,
               ),
               const Text('New Products'),
             ],
           ),
         ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              children: List.generate(model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index], context)),
            ),
          ),
        ],
      ),
    );
  }
Widget buildCategoryItem(DataModel model)=>
    Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
     Image(
      image: NetworkImage(model.image),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
    Container(
        width: double.infinity,
        color: Colors.black.withOpacity(.6),
        child: Text(
          model.name,textAlign: TextAlign.center,maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white,),
        )),
  ],
);
  Widget buildGridProduct(model , context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                ),
                if (model.discuont != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round}',
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          //  padding: EdgeInsets.zero,
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id);
                              print(model.id);
                            },
                            icon:const CircleAvatar(

                               backgroundColor: ShopCubit.get(context).favourities![model.id] ? defaultColor: Colors.grey ,
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
      );
}
