import 'package:flutter/material.dart';

class CustomCarrousel extends StatelessWidget {
  final String? label;
  final List<Widget> children;
  final Axis scrollDirection;
  const CustomCarrousel(
      {Key? key,
      this.label,
      required this.children,
      this.scrollDirection = Axis.horizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Column(
                children: [
                  const SizedBox(height: 12.0),
                  Text(
                    label ?? '',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              )
            : Container(),
        scrollDirection == Axis.horizontal
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: children),
              )
            : Column(children: children),
      ],
    );
  }
}
