import 'dart:io';

import 'package:flutter/material.dart';

import '../config/constants/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.size,
    this.image,
    this.filePath,
    this.link, this.margin, this.border,
  });
  final double size;
  final String? image;
  final String? filePath;
  final String? link;
  final EdgeInsets? margin;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: margin,
      decoration: BoxDecoration(
        border: border == true
            ? Border.all(color: AppColors.white, width: 4)
            : null,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: getImages(),
        ),
      ),
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
    } else 
    if (link != null) {
      return NetworkImage(link!);
    } else {
      return AssetImage(image!);
    }
  }
}
