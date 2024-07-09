import 'dart:ui';

import 'package:blog_app_clean_tdd/core/theme/app_pallete.dart';

Color cardColorSelector(int index) {
  return index % 3 == 0
      ? AppPallete.gradient1
      : index % 3 == 1
          ? AppPallete.gradient2
          : AppPallete.gradient3;
}
