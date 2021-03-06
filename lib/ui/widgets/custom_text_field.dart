import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool comment;
  final Function? onPressed;
  final Function(String)? onFieldSubmitted;
  final bool colorTextEditDark;
  final TextInputType keyboardType;
  final InputBorder? border;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.border,
    this.keyboardType = TextInputType.streetAddress,
    this.onPressed,
    this.comment = false,
    this.onFieldSubmitted,
    this.colorTextEditDark = true,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autocorrect: false,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: _buildobscureTextPassword() ?? !obscureText,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: widget.colorTextEditDark
              ? null
              : const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              hintStyle: const TextStyle(color: Colors.white),
              enabledBorder: widget.border,
              suffixIcon: widget.comment
                  ? _buildSubmitComment()
                  : _buildIconPassword()),
        )
      ],
    );
  }

  _buildIconPassword() {
    if (widget.keyboardType == TextInputType.visiblePassword) {
      return IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => obscureText = !obscureText));
    } else {
      return null;
    }
  }

  _buildobscureTextPassword() =>
      widget.keyboardType == TextInputType.visiblePassword ? null : false;

  _buildSubmitComment() {
    return IconButton(
      icon: const Icon(Icons.send_rounded),
      onPressed: () async {
        await widget.onPressed!();
      },
    );
  }
}
