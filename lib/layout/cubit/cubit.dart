import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(InitState());

  var currentIndex=0;

  List<Widget> screens =  [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.business),label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports)  ,label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science) ,label: 'science'),
  ];

  List<dynamic> business =[];
  List<dynamic> sports =[];
  List<dynamic> science =[];
  List<dynamic> search =[];

  bool isDark = false;

  static AppCubit get(context) => BlocProvider.of(context);

  void changeBottomNav(index)
  {
    currentIndex=index;
    if(currentIndex == 0)
    {
      getBusinessData();
    }
    else if(currentIndex == 1)
    {
      getSportsData();
    }else if(currentIndex == 2)
    {
      getScienceData();
    }
    emit(BottomNavState());
  }

  void changeAppMode({bool? mode})
  {
    if(mode!=null) {
      isDark=mode;
      emit(ChangeAppMode());
    }else
    {
      isDark = !isDark;
      CacheHelper.putData(
          key: 'isDark',
          value: isDark
      ).then((value) {
        emit(ChangeAppMode());
      });

    }
  }

  void getBusinessData()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      business = value.data['articles'];
      emit(GetSuccessBusinessData());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetFailedBusinessDataError(error.toString()));
    });
  }

  void getSportsData()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(GetSuccessSportsData());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetFailedSportsDataError(error.toString()));
    });
  }

  void getScienceData()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      science = value.data['articles'];
      emit(GetSuccessScienceData());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetFailedScienceDataError(error.toString()));
    });
  }

  void getSearchData(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      path:'v2/everything' ,
      query: {
        'q':value,
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca'
      },
    ).then((value) {
      search = value.data['articles'];
      emit(GetSuccessSearchData());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetFailedSearchDataError(error.toString()));
    });
  }


}