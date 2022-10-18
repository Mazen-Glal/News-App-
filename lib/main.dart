import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/cubit/bloc_observe.dart';
import 'layout/news_layout/news_layout.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? mode = CacheHelper.getData(key: 'isDark');
  
  
  runApp(MyApp(mode));
}

class MyApp extends StatelessWidget
{
  bool? isDark;
  MyApp(this.isDark, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create :(BuildContext context) => AppCubit()..changeAppMode(mode: isDark),
      child : BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              cardColor: Colors.grey[100],
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  )),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 0.0,
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  )
              )
          ),
          darkTheme: ThemeData(
              cardColor: Colors.black45,
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme:  AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 0.0,
                  backgroundColor: HexColor('333739')
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )
              )
          ),
          themeMode: AppCubit.get(context).isDark == true ? ThemeMode.dark : ThemeMode.light  ,
          home: const NewsLayout(),
        ),
      ),
    );
  }
}
