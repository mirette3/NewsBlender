import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_blender_app/Layout/Cubit/cubit.dart';
import 'package:news_blender_app/Layout/Cubit/states.dart';
import 'package:news_blender_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.white60,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (validate) {
                      if (validate!.isEmpty) {
                        return 'search must be not empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: NewsCubit.get(context).search.length > 0,
                  builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildArticleItem(
                        NewsCubit.get(context).search[index], context),
                    separatorBuilder: (context, index) => Container(
                      color: Colors.grey,
                      width: 10,
                      height: 1,
                    ),
                    itemCount: NewsCubit.get(context).search.length,
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
