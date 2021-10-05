import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
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
          decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              hintStyle: const TextStyle(color: Colors.white),
              enabledBorder: widget.border,
              suffixIcon: _buildIconPassword()),
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
}
