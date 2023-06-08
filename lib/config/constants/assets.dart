abstract class Assets {
  const Assets._();

  // ignore: library_private_types_in_public_api
  static _Icons get icons => const _Icons();

  // ignore: library_private_types_in_public_api
  static _Images get images => const _Images();
}

abstract class _AssetsHolder {
  final String basePath;

  const _AssetsHolder(this.basePath);
}

class _Icons extends _AssetsHolder {
  const _Icons() : super('assets/icons');

  // String get logo => "$basePath/logo.svg";
  String get google => "$basePath/google.svg";

  String get group => "$basePath/group_icon.svg";

  String get send => "$basePath/send_icon.svg";

  String get paperClip => "$basePath/paper_clip_icon.svg";

  String get logout => "$basePath/logout.svg";

  String get addPhoto => "$basePath/add_photo.svg";

  String get user => "$basePath/user.svg";

  String get check => "$basePath/check_ic.svg";

  String get search => "$basePath/search.svg";

}

class _Images extends _AssetsHolder {
  const _Images() : super('assets/images');

  String get user1 => '$basePath/user1.jpg';

  String get chatBg => '$basePath/chat_bg_img.png';

  String get logo => '$basePath/logo.svg';

  String get defUserimaage => '$basePath/def_user_img.png';

  String get uploadingUserimage => '$basePath/uploading_user_img.png';
}
