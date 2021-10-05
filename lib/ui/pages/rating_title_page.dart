import 'package:flutter/material.dart';
import 'package:my_movies_list/data/models/title_model.dart';
import 'package:my_movies_list/data/repositories/title_repository.dart';
import 'package:my_movies_list/ui/widgets/loading_circular_progress.dart';
import 'package:my_movies_list/ui/widgets/custom_network_image.dart';
import 'package:my_movies_list/ui/widgets/custom_carrousel.dart';

class RatingTitlePage extends StatelessWidget {
  //final _repository = TitleRepository();
  const RatingTitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: LayoutBuilder(builder: (context, cons) {
            return CustomCarrousel(
              label: 'Classificação de Filmes',
              scrollDirection: Axis.horizontal,
              children: /*  _repository.getTitleList().isEmpty
                  ? */
                  [_buildInit()]
              /*  : _repository
                      .getTitleList()
                      .map((e) => _buildTitleCard(cons, title: e))
                      .toList() */
              ,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTitleCard(BoxConstraints cons, {required TitleModel title}) {
    return SizedBox(
      width: cons.maxWidth,
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomNetworkImage(url: title.posterUrl),
            )),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Icon(Icons.thumb_down)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInit() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 160.0,
        width: 120,
        child: const LoadingCircularProgress());
  }
}
