import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      
      listener: (context, state) {},
      builder:(context,state)
      {
        if (state is NewsGetBusinessLoadingState)
        {
          return const Center(child: CircularProgressIndicator());
        } else
        {
          return ListView.separated(
              itemBuilder: (context, index) =>
                  itemShow(cubit.business[index],context),
              separatorBuilder: (context, index) => Container(
                    color: Theme.of(context).cardColor,
                    height: 1,
                    width: double.infinity,
                  ),
              itemCount: cubit.business.length);
        }
      },
    );
  }
}
