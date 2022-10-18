import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsLayout extends StatelessWidget
{
  const NewsLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    AppCubit.get(context).getBusinessData();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News APP'),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>const SearchScreen())
                    );
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_6_outlined)
              ),

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
