import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/features/home/presentation/widgets/participant_item_widget.dart';

import '../../../../config/constants/all_constants.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentattion/widgets/custom_textfield.dart';
import '../bloc/home/home_bloc.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({
    super.key,
  });

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetAllUsers());
  }

  List<UserModel> userSelectedList = [];
  late List<UserModel> listUsers = context.read<HomeBloc>().listUsers ?? [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520.h,
      decoration: BoxDecoration(
        color: AppColors.neutral700,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.body16w5.copyWith(
                  color: AppColors.white,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  height: 6.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.neutral500,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
                ),
                Text(
                  'Add participants',
                  style: AppTextStyles.body18w7.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: 160.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary400,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                          width: 160.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.primary400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: TextEditingController(),
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
                SizedBox(height: 25.h),
                Expanded(
                  child: GridView.builder(
                    itemCount: listUsers.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected =
                          userSelectedList.contains(listUsers[index]);
                      return ParticipantsItem(
                        userModel: listUsers[index],
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              userSelectedList.removeWhere(
                                  (element) => element == listUsers[index]);
                            } else {
                              userSelectedList.add(listUsers[index]);
                            }
                          });
                        },
                        isSelected: isSelected,
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
