
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/app_colors.dart';
import 'package:message_app/config/constants/assets.dart';
import 'package:message_app/features/auth/presentattion/widgets/custom_textfield.dart';
import '../../data/models/search_group_model.dart';

import '../bloc/home/home_bloc.dart';
import '../widgets/search_group_result.dart';

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
      backgroundColor: AppColors.neutral700,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              isPassword: false,
              prefixIcon: IconButton(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                onPressed: () {},
                icon: SvgPicture.asset(
                  Assets.icons.search,
                ),
              ),
              hintText: "Search...",
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
                        return SearchGroupResult(
                          searchGroupModel: listSearchResults[index],
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
 
}


