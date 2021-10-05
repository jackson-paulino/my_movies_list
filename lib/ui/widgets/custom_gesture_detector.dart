import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/ui/shared/app_colors.dart';
import 'package:my_movies_list/ui/shared/app_routes.dart';

import 'custom_title_thumbmail.dart';

class CustomGestureDetector extends StatelessWidget {
  final TitleModel titleModel;
  const CustomGestureDetector({Key? key, required this.titleModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.titleDetailsPage,
          arguments: titleModel),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        color: AppColors.primaryDark,
        width: 100,
        child: TitleThumbmail(title: titleModel),
      ),
    );
  }
}
