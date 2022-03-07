import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_blender_app/Layout/Cubit/states.dart';
import 'package:news_blender_app/modules/Business/busniess_screen.dart';
import 'package:news_blender_app/modules/Science/science_screen.dart';
import 'package:news_blender_app/modules/Sport/sport_screen.dart';
import 'package:news_blender_app/network/local/cach_helper.dart';
import 'package:news_blender_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  final formGlobalKey = GlobalKey<FormState>();
  bool isShow = true;

  static NewsCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: 'Busniess'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [BusinessScreen(), SportScreen(), ScienceScreen()];
  List<String> titles = ["Business News", "Sport News", "Science News"];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void changNavBottom(index) {
    current_index = index;
    emit(NewsChangeBarBottomState());

    if (index == 1) {
      getSport();
      emit(NewsChangeBarBottomState());
    }
    if (index == 2) {
      getScience();
      emit(NewsChangeBarBottomState());
    }
  }

  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "21ec5da562414c9e9fb0525d87dbb2e6"
    }).then((value) {
      business = value.data['articles'];
      emit(GetBusinessSuccessState());
    }).catchError((onError) {
      emit(GetBusinessErrorState(onError.toString()));
    });
  }

  void getSport() {
    emit(GetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "21ec5da562414c9e9fb0525d87dbb2e6"
      }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsSuccessState());
      }).catchError((onError) {
        emit(GetSportsErrorState(onError.toString()));
      });
    } else
      emit(GetSportsSuccessState());
  }

  void getScience() {
    emit(GetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "21ec5da562414c9e9fb0525d87dbb2e6"
      }).then((value) {
        science = value.data['articles'];
        emit(GetScienceSuccessState());
      }).catchError((onError) {
        emit(GetScienceErrorState(onError.toString()));
      });
    } else
      emit(GetScienceSuccessState());
  }

  void getSearch(String value) {
    emit(GetSearchLoadingState());
    search = [];
    DioHelper.getData(
            url: "v2/everything",
            query: {"q": value, "apiKey": "21ec5da562414c9e9fb0525d87dbb2e6"})
        .then((value) {
      search = value.data['articles'];
      emit(GetSearchSuccessState());
    }).catchError((onError) {
      emit(GetSearchErrorState(onError.toString()));
    });
  }

  ThemeMode appMode = ThemeMode.dark;
  bool isDark = false;
  void changeAppMode({dynamic? saveShared}) {
    if (saveShared == null) {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(ChangeAppMode());
      });
    } else {
      isDark = saveShared;
      emit(ChangeAppMode());
    }
  }
}
