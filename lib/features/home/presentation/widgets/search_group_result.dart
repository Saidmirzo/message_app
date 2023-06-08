

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/all_constants.dart';
import '../../../../widgets/custom_avatar.dart';
import '../../data/models/search_group_model.dart';
import '../bloc/home/home_bloc.dart';

class SearchGroupResult extends StatelessWidget {
  const SearchGroupResult({
    super.key,
    required this.searchGroupModel,
  });

  final SearchGroupModel searchGroupModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomAvatar(
        size: 56.h,
        link: searchGroupModel.groupImage,
        image: Assets.images.defUserimaage,
      ),
      title: Text(
        searchGroupModel.groupName,
        style: AppTextStyles.body16w6.copyWith(
          color: AppColors.white,
        ),
      ),
      subtitle: Text(
        "${searchGroupModel.membersCount} members",
        style: AppTextStyles.body14w4.copyWith(
          color: AppColors.neutral200,
        ),
      ),
      trailing: !getUserIsJonied(context)
          ? InkWell(
              onTap: () {
                context.read<HomeBloc>().add(
                      ToggleGroupEvent(searchGroupModel: searchGroupModel),
                    );
              },
              child: Container(
                height: 30.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.neutral500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Join now",
                  style: AppTextStyles.body16w5.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  bool getUserIsJonied(BuildContext context) {
    bool result = context
        .read<HomeBloc>()
        .userModel
        .groups!
        .map((e) => e.substring(0, e.indexOf('_')))
        .contains(searchGroupModel.groupId);
    return result;
  }
}