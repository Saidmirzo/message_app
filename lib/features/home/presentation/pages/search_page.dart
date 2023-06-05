import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/search_group_model.dart';

import '../bloc/home/home_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search Page'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<HomeBloc>()
                  .add(SearchGroupByName(name: searchController.text));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70.h,
            child: TextField(
              controller: searchController,
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              List<SearchGroupModel> listSearchResults =
                  context.read<HomeBloc>().listSearchGroupResult;
              if (state is HomeLoadedState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: listSearchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.read<HomeBloc>().add(ToggleGroupEvent(
                              searchGroupModel: listSearchResults[index]));
                        },
                        title: Text(listSearchResults[index].groupName),
                        subtitle: Text(listSearchResults[index].admin),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
