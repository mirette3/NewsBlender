import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_blender_app/Layout/Cubit/cubit.dart';
import 'package:news_blender_app/Layout/Cubit/states.dart';
import 'package:news_blender_app/modules/Search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "${cubit.titles[cubit.current_index]}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.article),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            body: cubit.screens[cubit.current_index],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navItems,
              currentIndex: cubit.current_index,
              onTap: (index) {
                cubit.changNavBottom(index);
              },
            ),
          );
        });
  }
}
