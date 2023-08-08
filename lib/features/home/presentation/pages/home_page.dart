import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_styles.dart';
import '../../../../config/routes/routes.dart';
import '../../data/models/group_model.dart';
import '../bloc/home/home_bloc.dart';

import '../widgets/create_group_bottom_sheet.dart';
import '../widgets/group_tile.dart';
import '../widgets/no_group_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetGroupListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral900,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary400,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const CreateGroupBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: const Text('Home Page'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.settingsPage),
          icon: const Icon(Icons.settings_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.searchPage),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.body20w4,
              ),
            );
          } else if (state is HomeLoadedState) {
            return Container(
              child: StreamBuilder(
                stream: context.read<HomeBloc>().groups,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<GroupModel>? listGroups = snapshot.data;
                    if (listGroups != null) {
                      if (listGroups.isNotEmpty) {
                        return ListView.builder(
                          itemCount: listGroups.length,
                          itemBuilder: (context, index) {
                            return GroupTile(
                              groupModel: listGroups[index],
                            );
                          },
                        );
                      } else {
                        return const NoGroupsWidget();
                      }
                    } else {
                      return const NoGroupsWidget();
                    }
                  } else {
                    return const NoGroupsWidget();
                  }
                },
              ),
            );
          } else {
            return const NoGroupsWidget();
          }
        },
      ),
    );
  }
}
