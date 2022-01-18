import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app2/layout/news_app/cubit/cubit.dart';
import 'package:flutter_news_app2/modules/search/search_screen.dart';
import 'package:flutter_news_app2/shared/components/components.dart';
import 'package:flutter_news_app2/shared/cubit/cubit.dart';
import 'package:flutter_news_app2/shared/network/local/cache_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(cubit: NewsCubit.get(context),),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeAppMode(
                        fromShared: CacheHelper.getBoolean(key: 'isDark'));
                  },
                ),
              ],
            ),
            // body: cubit.screens[cubit.currentIndex],
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
