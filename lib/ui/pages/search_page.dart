import 'package:flutter/material.dart';
import 'package:my_movies_list/data/repositories/title_repository.dart';
import 'package:my_movies_list/ui/widgets/custom_gesture_detector.dart';
import 'package:my_movies_list/ui/widgets/custom_text_field.dart';

class SearchPage extends StatelessWidget {
  //final _repository = TitleRepository();
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomTextField(
            hintText: 'Pesquise aqui...',
            border: InputBorder.none,
          ),
        ),
        body:
            Container() /* GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 7,
        crossAxisSpacing: 2.0,
        childAspectRatio: .63,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        children: _repository
            .getTitleList()
            .map((e) => BuildGestureDetector(titleModel: e))
            .toList(),
      ), */
        );
  }
}
