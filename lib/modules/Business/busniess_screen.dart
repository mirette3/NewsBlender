import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_blender_app/Layout/Cubit/cubit.dart';
import 'package:news_blender_app/Layout/Cubit/states.dart';
import 'package:news_blender_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: NewsCubit.get(context).business.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(
                  NewsCubit.get(context).business[index], context),
              separatorBuilder: (context, index) => Container(
                color: Colors.grey,
                width: 10,
                height: 1,
              ),
              itemCount: NewsCubit.get(context).business.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
