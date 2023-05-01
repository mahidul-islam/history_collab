import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

class InnerField extends StatelessWidget {
  final CodeController codeController;
  final Map<String, TextStyle> styles;

  const InnerField(
      {super.key, required this.styles, required this.codeController});

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: styles),
      child: CodeField(
        wrap: true,
        controller: codeController,
        textStyle: const TextStyle(fontFamily: 'SourceCode'),
      ),
    );
  }
}
