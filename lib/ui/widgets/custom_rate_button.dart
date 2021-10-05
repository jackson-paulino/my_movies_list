import 'package:flutter/material.dart';

class CustomRateButton extends StatelessWidget {
  final bool value;
  final Function(bool)? onPressed;
  const CustomRateButton({Key? key, required this.value, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!(true);
            }
          },
          icon: Icon(value ? Icons.thumb_up : Icons.thumb_up_alt_outlined),
        ),
        IconButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!(false);
            }
          },
          icon: Icon(value ? Icons.thumb_down : Icons.thumb_down_alt_outlined),
        ),
      ],
    );
  }
}
