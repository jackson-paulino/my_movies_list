import 'package:flutter/material.dart';
import 'package:my_movies_list/ui/shared/app_colors.dart';

class LoadingCircularProgress extends StatelessWidget {
  final String text;
  const LoadingCircularProgress({
    Key? key,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 160.0,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(width: 12),
            Text(text)
          ],
        ));
  }
}
