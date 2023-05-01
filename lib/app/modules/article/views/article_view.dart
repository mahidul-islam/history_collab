import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:history_collab/app/modules/article/widget/code_box.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.save,
            child: const Icon(Icons.save),
          ),
          appBar: AppBar(
            title: const Text('Article Details'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              child: InnerField(
                codeController: controller.articleController,
                styles: controller.styles,
              ),
            ),
          ),
        );
      },
    );
  }
}
