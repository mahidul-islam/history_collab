import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_collab/app/modules/article/widget/code_box.dart';
import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({super.key});
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Article Name'),
                    const SizedBox(width: 40),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: controller.titleController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  child: InnerField(
                    codeController: controller.articleController,
                    styles: controller.styles,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
