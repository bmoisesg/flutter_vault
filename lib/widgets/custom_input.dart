import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController myCtl;
  final Icon myIcon;
  final String hintText;
  final bool hidePass;
  final TextInputType typeInput;

  const CustomInput({
    required this.myCtl,
    required this.myIcon,
    this.hintText = "",
    this.hidePass = false,
    this.typeInput = TextInputType.text,
    super.key,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.typeInput,
      controller: widget.myCtl,
      obscureText: widget.hidePass,
      decoration: InputDecoration(
        prefixIcon: widget.myIcon,
        border: const OutlineInputBorder(),
        labelText: widget.hintText,
        fillColor: Colors.transparent,
        filled: true,
        isDense: true,
      ),
    );
  }
}
