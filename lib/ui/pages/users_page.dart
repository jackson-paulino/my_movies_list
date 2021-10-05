import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

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
          child: LayoutBuilder(
            builder: (context, cons) {
              return Column(
                children: [_buildTitleCard(cons)],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleCard(BoxConstraints cons) {
    return SizedBox(
      width: cons.maxWidth,
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 15,
                width: 15,
              ),
            )),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'title.name',
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
}
