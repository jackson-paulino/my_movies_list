import 'package:flutter/material.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const LoadingCircularProgress();
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/erro.jpg');
      },
    );
  }
}
