import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_blender_app/Layout/Cubit/cubit.dart';
import 'package:news_blender_app/Layout/Cubit/states.dart';
import 'package:news_blender_app/Layout/news_layout.dart';
import 'package:news_blender_app/network/local/cach_helper.dart';
import 'package:news_blender_app/network/remote/dio_helper.dart';

void main() async{
  //to check all method are done then open app
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
 await CacheHelper.init();
 dynamic isDark =CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
   dynamic isDark;

   MyApp( this.isDark, {Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => NewsCubit()..changeAppMode(saveShared: isDark)..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:  (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarColor: Colors.black45,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.black,
                showUnselectedLabels: true,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.green,
                scaffoldBackgroundColor: Colors.black45,
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.black45,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                    statusBarColor: Colors.black,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.black45,
                  selectedItemColor: Colors.green,
                  unselectedItemColor: Colors.white,
                  showUnselectedLabels: true,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light,
            home: NewsLayout(),
          );
        }, ),
    );
  }
}
