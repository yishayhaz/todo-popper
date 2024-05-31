import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? label;
  final TextInputType keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  final bool expands;
  final bool autofocus;
  final bool noBorder;

  const Input(
      {super.key,
      this.label,
      this.keyboardType = TextInputType.text,
      this.minLines,
      this.maxLines,
      this.maxLength,
      this.hintText,
      this.initialValue,
      this.onChanged,
      this.controller,
      this.expands = false,
      this.autofocus = false,
      this.noBorder = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      onChanged: onChanged,
      initialValue: initialValue,
      controller: controller,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          border: noBorder
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
          label: label != null ? Text(label!) : null,
          hintMaxLines: null,
          hintText: hintText),
    );
  }
}
