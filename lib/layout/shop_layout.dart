import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shop_cubit/shop_cubit.dart';
import 'package:shop/login/login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/search/search_screen.dart';
import 'package:shop/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (BuildContext context, Object? state) {  },
      builder: (context, state) {
          var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: (){navigateTo(context, const SearchScreen());}
              ),
            ],
            title: const Text('Salla'),
          ),
        body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){cubit.changeBottom(index);},
            currentIndex: cubit.currentIndex,
            items:const [
             BottomNavigationBarItem(icon: const Icon(Icons.home),label: 'Home' ),
             BottomNavigationBarItem(icon: const Icon(Icons.apps),label: 'Categories' ),
             BottomNavigationBarItem(icon: const Icon(Icons.favorite) ,label: 'Favourities'),
             BottomNavigationBarItem(icon: const Icon(Icons.settings),label: 'Settings' ),
          ],),
        );},);
  }
}
