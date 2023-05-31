import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/config/constants/app_text_styles.dart';
import 'package:message_app/config/routes/routes.dart';
import 'package:message_app/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:message_app/logic/helper_functions.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
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
            return Center(
              child: StreamBuilder(
                stream: context.read<HomeBloc>().groups,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List? listGroups = snapshot.data['groups'];
                    if (listGroups != null) {
                      if (listGroups.isNotEmpty) {
                        return ListView.builder(
                          itemCount: listGroups.length,
                          itemBuilder: (context, index) {
                            return GroupTile(
                              title: listGroups[index],
                              admin: context.read<HomeBloc>().userName??"Default",
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
                    return const Center(
                      child: Text('Loading'),
                    );
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
