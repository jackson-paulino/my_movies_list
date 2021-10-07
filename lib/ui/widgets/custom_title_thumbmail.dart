import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';

import 'custom_network_image.dart';

class TitleThumbmail extends StatelessWidget {
  final TitleModel title;
  const TitleThumbmail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomNetworkImage(url: title.posterUrl),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          child: Text(
            title.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        )
      ],
    );
  }
}
