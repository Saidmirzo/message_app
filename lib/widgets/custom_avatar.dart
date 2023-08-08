import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:message_app/config/constants/assets.dart';

import '../config/constants/app_colors.dart';

// ignore: must_be_immutable
class CustomAvatar extends StatelessWidget {
  CustomAvatar({
    super.key,
    required this.size,
    this.image,
    this.filePath,
    this.link,
    this.margin,
    this.isSelected = false,
    this.border = false,
  });
  final double size;
  final String? image;
  final String? filePath;
  final String? link;
  final EdgeInsets? margin;
  bool isSelected;
  bool border;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          margin: margin,
          decoration: BoxDecoration(
            border: (border) || (isSelected)
                ? Border.all(
                    color: isSelected ? AppColors.primary400 : AppColors.white,
                    width: 4,
                  )
                : null,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: getImages(),
            ),
          ),
        ),
        isSelected
            ? Container(
                height: size,
                width: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.opacity44,
                ),
                child: isSelected ? SvgPicture.asset(Assets.icons.check) : null,
              )
            : const SizedBox.shrink()
      ],
    );

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(100),
    //   child: SizedBox(
    //     height: size,
    //     width: size,
    //     child: link != null
    //         ? Image.network(
    //             link!,
    //             fit: BoxFit.cover,
    //             alignment: Alignment.center,
    //           )
    //         : filePath != null
    //             ? Image.file(
    //                 File(filePath!),
    //                 fit: BoxFit.cover,
    //                 alignment: Alignment.center,
    //               )
    //             : Image.asset(
    //                 image!,
    //                 fit: BoxFit.cover,
    //                 alignment: Alignment.center,
    //               ),
    //   ),
    // );
  }

  ImageProvider getImages() {
    if (filePath != null) {
      return FileImage(File(filePath!));
    } else if (link != null) {
      return NetworkImage(link!);
    } else {
      return AssetImage(image!);
    }
  }
}
