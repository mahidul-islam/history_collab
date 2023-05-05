import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/all.dart';
import 'package:flutter_highlight/themes/vs.dart';

import '../../home/model/entry.dart';

class EntryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController articleNameController = TextEditingController();

  Entry? entry;

  final TextEditingController _passwordController = TextEditingController();

  final CodeController articleController = CodeController(
    text: '',
    language: allLanguages['plaintext'],
    modifiers: [const CloseBlockModifier()],
  );

  final Map<String, TextStyle> styles = vsTheme;

  @override
  void onInit() {
    entry = Get.arguments as Entry?;
    super.onInit();
  }
}
