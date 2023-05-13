import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

import '../controllers/deploy_controller.dart';

class DeployView extends GetView<DeployController> {
  const DeployView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: const Text('DEPLOY TO SERVER'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: Get.width,
                  height: 40,
                ),
                DropdownButton<String>(
                  value: controller.selectedDatabase.value,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    controller.selectedDatabase.value = value;
                  },
                  items: controller.databases
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: controller.articleNameController,
                    decoration: const InputDecoration(hintText: 'Article Name'),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.amberAccent,
                      onPressed: controller.onCompareArticle,
                      child: const Text('Compare Article'),
                    ),
                    const SizedBox(width: 30),
                    MaterialButton(
                      color: Colors.greenAccent,
                      onPressed: controller.onCompareEventIndex,
                      child: const Text('Compare Event Index'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: PrettyDiffText(
                    oldText: controller.textFoundInGithub.value ?? '',
                    newText: controller.textFoundInFirebase.value ?? '',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
