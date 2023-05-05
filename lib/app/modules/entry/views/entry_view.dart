import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:history_collab/app/modules/article/widget/code_box.dart';

import '../controllers/entry_controller.dart';

class EntryView extends GetView<EntryController> {
  const EntryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: const Text('Edit/Create Entry'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Name'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.nameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Date'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.dateController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Start'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.startController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('End'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.endController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Article Name'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.articleNameController,
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
  }
}
