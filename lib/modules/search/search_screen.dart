import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  // GlobalKey<FormState> formKey=GlobalKey<FormState>();
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state)
      {
        var list =AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(title: const Text('Search')),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    AppCubit.get(context).getSearchData(value);
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty !!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search..',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => itemShow(list[index], context),
                      separatorBuilder: (context, index) => Container(
                            color: Theme.of(context).cardColor,
                            height: 1,
                            width: double.infinity,
                          ),
                      itemCount: list.length),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
