import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app2/layout/news_app/cubit/cubit.dart';
import 'package:flutter_news_app2/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var cubit;
  var searchController = TextEditingController();

  SearchScreen({Key? key,this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>.value(
      value: cubit,
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit
              .get(context)
              .search;

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
                Expanded(
                  child: articleBuilder(
                    list,
                    context,
                    isSearch: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
